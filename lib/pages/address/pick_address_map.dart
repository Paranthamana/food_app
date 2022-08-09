import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_button.dart';
import 'package:foodapp/controller/location_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({Key? key, required this.fromSignup, required this.fromAddress,
  this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition,zoom: 17);
    } else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
          _initialPosition = LatLng(
              double.parse(Get.find<LocationController>().getAddress['latitude']),
              double.parse(Get.find<LocationController>().getAddress['longitude']));
          _cameraPosition = CameraPosition(target: _initialPosition,zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition:
                  CameraPosition(
                    target: _initialPosition,
                    zoom: 17,
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                  ),
                  Center(
                    child: !locationController.loading?Image.asset("assets/image/ic_pick_map.png",
                    width: 50, height: 50):CircularProgressIndicator(),
                  ),
                  Positioned(
                      top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.width10, horizontal: Dimensions.width10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,size: 25, color: AppColors.yellowColor),
                            Expanded(child: Text(
                              '${locationController.pickPlaceMark.name??''}',
                              style: const TextStyle(color: Colors.white, overflow: TextOverflow.ellipsis),
                            ))
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoading?Center(
                        child: CircularProgressIndicator(),
                      ): CustomButton(buttonText: locationController.inZone?widget.fromAddress?'Pick Address':'Pick Location':'Service not available',
                        onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                          if(locationController.pickPosition.latitude!=0&&
                              locationController.pickPlaceMark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print('Now you can clicked on this');
                                widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                    locationController.pickPosition.latitude,
                                    locationController.pickPosition.longitude
                                ))));
                                locationController.setAddAddressData();
                              }
                              //Get.back();
                              Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }

                        },)
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
