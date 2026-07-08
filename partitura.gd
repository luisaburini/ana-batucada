extends Node2D

var current_fase = ""
var current_partitura = []
var current_background = ""
var p_index = 0
var current_time = 1


var fase1_palmas = [
	"res://img/Fase1/palmas/compasso-palmas-1-1.png",
	"res://img/Fase1/palmas/compasso-palmas-1-2.png",
	"res://img/Fase1/palmas/compasso-palmas-1-3.png",
	"res://img/Fase1/palmas/compasso-palmas-1-4.png",
	"res://img/Fase1/palmas/compasso-palmas-1-5.png",
	"res://img/Fase1/palmas/compasso-palmas-1-6.png",
	"res://img/Fase1/palmas/compasso-palmas-1-7.png",
	"res://img/Fase1/palmas/compasso-palmas-1-8.png",
	"res://img/Fase1/palmas/compasso-palmas-1-9.png",
	"res://img/Fase1/palmas/compasso-palmas-1-10.png",
	"res://img/Fase1/palmas/compasso-palmas-1-11.png",
	"res://img/Fase1/palmas/compasso-palmas-1-12.png",
	"res://img/Fase1/palmas/compasso-palmas-1-13.png",
	"res://img/Fase1/palmas/compasso-palmas-1-14.png",
	"res://img/Fase1/palmas/compasso-palmas-1-15.png",
	"res://img/Fase1/palmas/compasso-palmas-1-16.png",
	"res://img/Fase1/palmas/compasso-palmas-1-17.png",
	"res://img/Fase1/palmas/compasso-palmas-1-18.png",
	"res://img/Fase1/palmas/compasso-palmas-1-19.png",
	"res://img/Fase1/palmas/compasso-palmas-1-20.png",
	"res://img/Fase1/palmas/compasso-palmas-2-1.png",
	"res://img/Fase1/palmas/compasso-palmas-2-2.png",
	"res://img/Fase1/palmas/compasso-palmas-2-3.png",
	"res://img/Fase1/palmas/compasso-palmas-2-4.png",
	"res://img/Fase1/palmas/compasso-palmas-2-5.png",
	"res://img/Fase1/palmas/compasso-palmas-2-6.png",
	"res://img/Fase1/palmas/compasso-palmas-2-7.png",
	"res://img/Fase1/palmas/compasso-palmas-2-8.png",
	"res://img/Fase1/palmas/compasso-palmas-2-9.png",
	"res://img/Fase1/palmas/compasso-palmas-2-10.png",
	"res://img/Fase1/palmas/compasso-palmas-2-11.png",
	"res://img/Fase1/palmas/compasso-palmas-2-12.png",
	"res://img/Fase1/palmas/compasso-palmas-2-13.png",
	"res://img/Fase1/palmas/compasso-palmas-2-14.png",
	"res://img/Fase1/palmas/compasso-palmas-2-15.png",
	"res://img/Fase1/palmas/compasso-palmas-2-16.png",
	"res://img/Fase1/palmas/compasso-palmas-2-17.png",
	"res://img/Fase1/palmas/compasso-palmas-2-18.png",
	"res://img/Fase1/palmas/compasso-palmas-2-19.png",
	"res://img/Fase1/palmas/compasso-palmas-2-20.png",
]


var fase1_aro = [
	"res://img/Fase1/aro/compasso-aro-1-1.png",
	"res://img/Fase1/aro/compasso-aro-1-2.png",
	"res://img/Fase1/aro/compasso-aro-1-3.png",
	"res://img/Fase1/aro/compasso-aro-1-4.png",
	"res://img/Fase1/aro/compasso-aro-1-5.png",
	"res://img/Fase1/aro/compasso-aro-1-6.png",
	"res://img/Fase1/aro/compasso-aro-1-7.png",
	"res://img/Fase1/aro/compasso-aro-1-8.png",
	"res://img/Fase1/aro/compasso-aro-1-9.png",
	"res://img/Fase1/aro/compasso-aro-1-10.png",
	"res://img/Fase1/aro/compasso-aro-1-11.png",
	"res://img/Fase1/aro/compasso-aro-1-12.png",
	"res://img/Fase1/aro/compasso-aro-1-13.png",
	"res://img/Fase1/aro/compasso-aro-1-14.png",
	"res://img/Fase1/aro/compasso-aro-1-15.png",
	"res://img/Fase1/aro/compasso-aro-1-16.png",
	"res://img/Fase1/aro/compasso-aro-2-1.png",
	"res://img/Fase1/aro/compasso-aro-2-2.png",
	"res://img/Fase1/aro/compasso-aro-2-3.png",
	"res://img/Fase1/aro/compasso-aro-2-4.png",
	"res://img/Fase1/aro/compasso-aro-2-5.png",
	"res://img/Fase1/aro/compasso-aro-2-6.png",
	"res://img/Fase1/aro/compasso-aro-2-7.png",
	"res://img/Fase1/aro/compasso-aro-2-8.png",
	"res://img/Fase1/aro/compasso-aro-2-9.png",
	"res://img/Fase1/aro/compasso-aro-2-10.png",
	"res://img/Fase1/aro/compasso-aro-2-11.png",
	"res://img/Fase1/aro/compasso-aro-2-12.png",
	"res://img/Fase1/aro/compasso-aro-2-13.png",
	"res://img/Fase1/aro/compasso-aro-2-14.png",
	"res://img/Fase1/aro/compasso-aro-2-15.png",
	"res://img/Fase1/aro/compasso-aro-2-16.png",
]

var fase1_caixa = [
	"res://img/Fase1/caixa/compasso-caixa-1-1.png",
	"res://img/Fase1/caixa/compasso-caixa-1-2.png",
	"res://img/Fase1/caixa/compasso-caixa-1-3.png",
	"res://img/Fase1/caixa/compasso-caixa-1-4.png",
	"res://img/Fase1/caixa/compasso-caixa-1-5.png",
	"res://img/Fase1/caixa/compasso-caixa-1-6.png",
	"res://img/Fase1/caixa/compasso-caixa-1-7.png",
	"res://img/Fase1/caixa/compasso-caixa-1-8.png",
	"res://img/Fase1/caixa/compasso-caixa-1-9.png",
	"res://img/Fase1/caixa/compasso-caixa-1-10.png",
	"res://img/Fase1/caixa/compasso-caixa-1-11.png",
	"res://img/Fase1/caixa/compasso-caixa-1-12.png",
	"res://img/Fase1/caixa/compasso-caixa-1-13.png",
	"res://img/Fase1/caixa/compasso-caixa-1-14.png",
	"res://img/Fase1/caixa/compasso-caixa-1-15.png",
	"res://img/Fase1/caixa/compasso-caixa-1-16.png",
	"res://img/Fase1/caixa/compasso-caixa-1-17.png",
	"res://img/Fase1/caixa/compasso-caixa-1-18.png",
	"res://img/Fase1/caixa/compasso-caixa-1-19.png",
	"res://img/Fase1/caixa/compasso-caixa-1-20.png",
	"res://img/Fase1/caixa/compasso-caixa-1-21.png",
	"res://img/Fase1/caixa/compasso-caixa-1-22.png",
	"res://img/Fase1/caixa/compasso-caixa-1-23.png",
	"res://img/Fase1/caixa/compasso-caixa-1-24.png",
	"res://img/Fase1/caixa/compasso-caixa-2-1.png",
	"res://img/Fase1/caixa/compasso-caixa-2-2.png",
	"res://img/Fase1/caixa/compasso-caixa-2-3.png",
	"res://img/Fase1/caixa/compasso-caixa-2-4.png",
	"res://img/Fase1/caixa/compasso-caixa-2-5.png",
	"res://img/Fase1/caixa/compasso-caixa-2-6.png",
	"res://img/Fase1/caixa/compasso-caixa-2-7.png",
	"res://img/Fase1/caixa/compasso-caixa-2-8.png",
	"res://img/Fase1/caixa/compasso-caixa-2-9.png",
	"res://img/Fase1/caixa/compasso-caixa-2-10.png",
	"res://img/Fase1/caixa/compasso-caixa-2-11.png",
	"res://img/Fase1/caixa/compasso-caixa-2-12.png",
	"res://img/Fase1/caixa/compasso-caixa-2-13.png",
	"res://img/Fase1/caixa/compasso-caixa-2-14.png",
	"res://img/Fase1/caixa/compasso-caixa-2-15.png",
	"res://img/Fase1/caixa/compasso-caixa-2-16.png",
	"res://img/Fase1/caixa/compasso-caixa-2-17.png",
	"res://img/Fase1/caixa/compasso-caixa-2-18.png",
	"res://img/Fase1/caixa/compasso-caixa-2-19.png",
	"res://img/Fase1/caixa/compasso-caixa-2-20.png",
	"res://img/Fase1/caixa/compasso-caixa-2-21.png",
	"res://img/Fase1/caixa/compasso-caixa-2-22.png",
	"res://img/Fase1/caixa/compasso-caixa-2-23.png",
	"res://img/Fase1/caixa/compasso-caixa-2-24.png",
	"res://img/Fase1/caixa/compasso-caixa-2-25.png",
	"res://img/Fase1/caixa/compasso-caixa-2-26.png",
	"res://img/Fase1/caixa/compasso-caixa-2-27.png",
	"res://img/Fase1/caixa/compasso-caixa-2-28.png",
]

var fase2_agogo = [
	"res://img/Fase2/agogo/compasso-agogo1-1.png",
	"res://img/Fase2/agogo/compasso-agogo1-2.png",
	"res://img/Fase2/agogo/compasso-agogo1-3.png",
	"res://img/Fase2/agogo/compasso-agogo1-4.png",
	"res://img/Fase2/agogo/compasso-agogo1-5.png",
	"res://img/Fase2/agogo/compasso-agogo1-6.png",
	"res://img/Fase2/agogo/compasso-agogo1-7.png",
	"res://img/Fase2/agogo/compasso-agogo1-8.png",
	"res://img/Fase2/agogo/compasso-agogo1-9.png",
	"res://img/Fase2/agogo/compasso-agogo1-10.png",
	"res://img/Fase2/agogo/compasso-agogo1-11.png",
	"res://img/Fase2/agogo/compasso-agogo1-12.png",
	"res://img/Fase2/agogo/compasso-agogo1-13.png",
	"res://img/Fase2/agogo/compasso-agogo1-14.png",
	"res://img/Fase2/agogo/compasso-agogo1-15.png",
	"res://img/Fase2/agogo/compasso-agogo1-16.png",
	"res://img/Fase2/agogo/compasso-agogo2-1.png",
	"res://img/Fase2/agogo/compasso-agogo2-2.png",
	"res://img/Fase2/agogo/compasso-agogo2-3.png",
	"res://img/Fase2/agogo/compasso-agogo2-4.png",
	"res://img/Fase2/agogo/compasso-agogo2-5.png",
	"res://img/Fase2/agogo/compasso-agogo2-6.png",
	"res://img/Fase2/agogo/compasso-agogo2-7.png",
	"res://img/Fase2/agogo/compasso-agogo2-8.png",
	"res://img/Fase2/agogo/compasso-agogo2-9.png",
	"res://img/Fase2/agogo/compasso-agogo2-10.png",
	"res://img/Fase2/agogo/compasso-agogo2-11.png",
	"res://img/Fase2/agogo/compasso-agogo2-12.png",
	"res://img/Fase2/agogo/compasso-agogo2-13.png",
	"res://img/Fase2/agogo/compasso-agogo2-14.png",
	"res://img/Fase2/agogo/compasso-agogo2-15.png",
	"res://img/Fase2/agogo/compasso-agogo2-16.png",
	"res://img/Fase2/agogo/compasso-agogo2-17.png",
	"res://img/Fase2/agogo/compasso-agogo2-18.png",
	"res://img/Fase2/agogo/compasso-agogo2-19.png",
	"res://img/Fase2/agogo/compasso-agogo2-20.png",
]

var fase2_bumbo = [
	"res://img/Fase2/bumbo/compasso-bumbo1-1.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-2.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-3.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-4.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-5.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-6.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-7.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-8.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-9.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-10.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-11.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-12.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-13.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-14.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-15.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-16.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-17.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-18.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-19.png",
	"res://img/Fase2/bumbo/compasso-bumbo1-20.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-1.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-2.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-3.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-4.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-5.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-6.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-7.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-8.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-9.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-10.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-11.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-12.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-13.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-14.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-15.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-16.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-17.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-18.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-19.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-20.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-21.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-22.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-23.png",
	"res://img/Fase2/bumbo/compasso-bumbo2-24.png",
]

var fase2_hihat = [
	"res://img/Fase2/hihat/compasso-hihat-1-1.png",
	"res://img/Fase2/hihat/compasso-hihat-1-2.png",
	"res://img/Fase2/hihat/compasso-hihat-1-3.png",
	"res://img/Fase2/hihat/compasso-hihat-1-4.png",
	"res://img/Fase2/hihat/compasso-hihat-1-5.png",
	"res://img/Fase2/hihat/compasso-hihat-1-6.png",
	"res://img/Fase2/hihat/compasso-hihat-1-7.png",
	"res://img/Fase2/hihat/compasso-hihat-1-8.png",
	"res://img/Fase2/hihat/compasso-hihat-1-9.png",
	"res://img/Fase2/hihat/compasso-hihat-1-10.png",
	"res://img/Fase2/hihat/compasso-hihat-1-11.png",
	"res://img/Fase2/hihat/compasso-hihat-1-12.png",
	"res://img/Fase2/hihat/compasso-hihat-1-13.png",
	"res://img/Fase2/hihat/compasso-hihat-1-14.png",
	"res://img/Fase2/hihat/compasso-hihat-1-15.png",
	"res://img/Fase2/hihat/compasso-hihat-1-16.png",
	"res://img/Fase2/hihat/compasso-hihat-2-1.png",
	"res://img/Fase2/hihat/compasso-hihat-2-2.png",
	"res://img/Fase2/hihat/compasso-hihat-2-3.png",
	"res://img/Fase2/hihat/compasso-hihat-2-4.png",
	"res://img/Fase2/hihat/compasso-hihat-2-5.png",
	"res://img/Fase2/hihat/compasso-hihat-2-6.png",
	"res://img/Fase2/hihat/compasso-hihat-2-7.png",
	"res://img/Fase2/hihat/compasso-hihat-2-8.png",
	"res://img/Fase2/hihat/compasso-hihat-2-9.png",
	"res://img/Fase2/hihat/compasso-hihat-2-10.png",
	"res://img/Fase2/hihat/compasso-hihat-2-11.png",
	"res://img/Fase2/hihat/compasso-hihat-2-12.png",
	"res://img/Fase2/hihat/compasso-hihat-2-13.png",
	"res://img/Fase2/hihat/compasso-hihat-2-14.png",
	"res://img/Fase2/hihat/compasso-hihat-2-15.png",
	"res://img/Fase2/hihat/compasso-hihat-2-16.png",
]

var fase3_bumbo = [
	"res://img/Fase3/bumbo/compasso-bumbo1-1.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-2.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-3.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-4.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-5.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-6.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-7.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-8.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-9.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-10.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-11.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-12.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-13.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-14.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-15.png",
	"res://img/Fase3/bumbo/compasso-bumbo1-16.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-1.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-2.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-3.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-4.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-5.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-6.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-7.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-8.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-9.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-10.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-11.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-12.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-13.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-14.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-15.png",
	"res://img/Fase3/bumbo/compasso-bumbo2-16.png",
]

var fase3_triangulo = [
	"res://img/Fase3/triangulo/compasso-triangulo1-1.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-2.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-3.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-4.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-5.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-6.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-7.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-8.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-9.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-10.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-11.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-12.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-13.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-14.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-15.png",
	"res://img/Fase3/triangulo/compasso-triangulo1-16.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-1.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-2.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-3.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-4.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-5.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-6.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-7.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-8.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-9.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-10.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-11.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-12.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-13.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-14.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-15.png",
	"res://img/Fase3/triangulo/compasso-triangulo2-16.png",
]

var fase3_conga = [
	"res://img/Fase3/conga/compasso-conga1-1.png",
	"res://img/Fase3/conga/compasso-conga1-2.png",
	"res://img/Fase3/conga/compasso-conga1-3.png",
	"res://img/Fase3/conga/compasso-conga1-4.png",
	"res://img/Fase3/conga/compasso-conga1-5.png",
	"res://img/Fase3/conga/compasso-conga1-6.png",
	"res://img/Fase3/conga/compasso-conga1-7.png",
	"res://img/Fase3/conga/compasso-conga1-8.png",
	"res://img/Fase3/conga/compasso-conga1-9.png",
	"res://img/Fase3/conga/compasso-conga1-10.png",
	"res://img/Fase3/conga/compasso-conga1-11.png",
	"res://img/Fase3/conga/compasso-conga1-12.png",
	"res://img/Fase3/conga/compasso-conga1-13.png",
	"res://img/Fase3/conga/compasso-conga1-14.png",
	"res://img/Fase3/conga/compasso-conga1-15.png",
	"res://img/Fase3/conga/compasso-conga1-16.png",
	"res://img/Fase3/conga/compasso-conga2-1.png",
	"res://img/Fase3/conga/compasso-conga2-2.png",
	"res://img/Fase3/conga/compasso-conga2-3.png",
	"res://img/Fase3/conga/compasso-conga2-4.png",
	"res://img/Fase3/conga/compasso-conga2-5.png",
	"res://img/Fase3/conga/compasso-conga2-6.png",
	"res://img/Fase3/conga/compasso-conga2-7.png",
	"res://img/Fase3/conga/compasso-conga2-8.png",
	"res://img/Fase3/conga/compasso-conga2-9.png",
	"res://img/Fase3/conga/compasso-conga2-10.png",
	"res://img/Fase3/conga/compasso-conga2-11.png",
	"res://img/Fase3/conga/compasso-conga2-12.png",
	"res://img/Fase3/conga/compasso-conga2-13.png",
	"res://img/Fase3/conga/compasso-conga2-14.png",
	"res://img/Fase3/conga/compasso-conga2-15.png",
	"res://img/Fase3/conga/compasso-conga2-16.png",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func start():
	$Timer.start(current_time)

func set_current_fase(fase, timeout):
	current_fase = fase
	current_time = timeout
	if fase == "Fase1Aro":
		current_partitura = fase1_aro
		current_background = "res://img/taquaral.jpg"
	if fase == "Fase1Caixa":
		current_partitura = fase1_caixa
		current_background = "res://img/taquaral.jpg"
	if fase == "Fase1Palmas":
		current_partitura = fase1_palmas
		current_background = "res://img/taquaral.jpg"
	if fase == "Fase2Agogo":
		current_partitura = fase2_agogo
		current_background = "res://img/cerecamp-mogiana.jpg"
	if fase == "Fase2Hihat":
		current_partitura = fase2_hihat
		current_background = "res://img/cerecamp-mogiana.jpg"
	if fase == "Fase2Bumbo":
		print("FASE 2 BUMBO")
		current_partitura = fase2_bumbo
		current_background = "res://img/cerecamp-mogiana.jpg"
	if fase == "Fase3Bumbo":
		current_partitura = fase3_bumbo
		current_background = "res://img/estacao-cultura.jpg"
	if fase == "Fase3Triangulo":
		current_partitura = fase3_triangulo
		current_background = "res://img/estacao-cultura.jpg"
	if fase == "Fase3Conga":
		current_partitura = fase3_conga
		current_background = "res://img/estacao-cultura.jpg"
	$Background.texture = load(current_background)
	$Desenho.texture = load(current_partitura[p_index%len(current_partitura)])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stop():
	$Timer.stop()
	
func reset():
	p_index = 0
	set_current_fase(current_fase, current_time)

func _on_timer_timeout() -> void:
	p_index = p_index+1
	$Desenho.texture = load(current_partitura[p_index%len(current_partitura)])
	$Timer.start(current_time)
