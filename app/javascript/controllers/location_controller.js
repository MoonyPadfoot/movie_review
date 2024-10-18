import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['selectedRegionId', 'selectedProvinceId', 'selectedCityId', 'selectBarangayId', 'addressId']

    updateAddress() {
        let target = this.addressIdTarget
        let region = this.selectedRegionIdTarget
        let province = this.selectedRegionIdTarget
        let city = this.selectedRegionIdTarget
        let barangay = this.selectedRegionIdTarget

        let selectedOption = this.dropdownTarget.options[region.selectedIndex];
        let selectedText = $(selectedOption).text();
        console.log(selectedText)
    }

    fetchProvinces() {
        let target = this.selectedProvinceIdTarget
        $(target).empty();

        let promptOption = document.createElement('option');
        promptOption.value = "";
        promptOption.text = "Please select province";
        target.appendChild(promptOption);

        $.ajax({
            type: 'GET',
            url: '/api/v1/regions/' + this.selectedRegionIdTarget.value + '/provinces',
            dataType: 'json',
            success: (response) => {
                console.log(response)
                $.each(response, function (index, record) {
                    let option = document.createElement('option')
                    option.value = record.id
                    option.text = record.name
                    target.appendChild(option)
                })
            }
        })
    }

    fetchCities() {
        let target = this.selectedCityIdTarget
        $(target).empty();

        let promptOption = document.createElement('option');
        promptOption.value = "";
        promptOption.text = "Please select city";
        target.appendChild(promptOption);

        $.ajax({
            type: 'GET',
            url: '/api/v1/provinces/' + this.selectedProvinceIdTarget.value + '/cities',
            dataType: 'json',
            success: (response) => {
                console.log(response)
                $.each(response, function (index, record) {
                    let option = document.createElement('option')
                    option.value = record.id
                    option.text = record.name
                    target.appendChild(option)
                })
            }
        })
    }

    fetchBarangays() {
        let target = this.selectBarangayIdTarget
        $(target).empty();

        let promptOption = document.createElement('option');
        promptOption.value = "";
        promptOption.text = "Please select barangay";
        target.appendChild(promptOption);

        $.ajax({
            type: 'GET',
            url: '/api/v1/cities/' + this.selectedCityIdTarget.value + '/barangays',
            dataType: 'json',
            success: (response) => {
                console.log(response)
                $.each(response, function (index, record) {
                    let option = document.createElement('option')
                    option.value = record.id
                    option.text = record.name
                    target.appendChild(option)
                })
            }
        })
    }
}