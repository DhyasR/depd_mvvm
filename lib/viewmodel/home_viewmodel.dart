import 'package:depd_mvvm/data/response/api_response.dart';
import 'package:depd_mvvm/model/city.dart';
import 'package:depd_mvvm/model/costs/costs.dart';
import 'package:depd_mvvm/repository/home_repository.dart';
import 'package:depd_mvvm/model/model.dart';
import 'package:flutter/material.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> cityListOrigin = ApiResponse.loading();
  ApiResponse<List<City>> cityListDestination = ApiResponse.loading();
  ApiResponse<List<Costs>> costList = ApiResponse.loading();

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading != value;
    notifyListeners();
  }

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProfinceList().then((value) {
      setProvinceList(ApiResponse.complete(value));
    }).onError((error, StackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  setCityListOrigin(ApiResponse<List<City>> response) {
    cityListOrigin = response;
    notifyListeners();
  }

  Future<void> getCityListOrigin(provId) async {
    setCityListOrigin(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityListOrigin(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setCityListOrigin(ApiResponse.error(error.toString()));
    });
  }

  setCityListDestination(ApiResponse<List<City>> response) {
    cityListDestination = response;
    notifyListeners();
  }

  Future<void> getCityListDestination(provId) async {
    setCityListDestination(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityListDestination(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setCityListDestination(ApiResponse.error(error.toString()));
    });
  }

  setCostList(ApiResponse<List<Costs>> response) {
    costList = response;
    notifyListeners();
  }

  Future<void> getCostList(
      String selectedProvinceOrigin,
      String selectedCityOrigin,
      String selectedProvinceDestination,
      String selectedCityDestination,
      int itemWeight,
      String selectedCourier) async {
    setLoading(true);
    _homeRepo
        .fetchCostList(
            selectedProvinceOrigin,
            selectedCityOrigin,
            selectedProvinceDestination,
            selectedCityDestination,
            itemWeight,
            selectedCourier)
        .then((value) {
      setCostList(ApiResponse.complete(value));
      setLoading(false);
    }).onError((error, stackTrace) {
      setCostList(ApiResponse.error(error.toString()));
    });
  }
}
