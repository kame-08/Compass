//
//  ContentView.swift
//  Compass
//
//  Created by Ryo on 2022/07/24.
//

import SwiftUI
import MapKit

import CoreLocation

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    @State var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    
    @State var kyori = 0
    
    
    @State private var galleLan = 35.76642
    @State private var galleLon = 139.65058
    
    
    
    
    
    var body: some View {
        let heading   = $manager.heading.wrappedValue
        //緯度
        let latitude  = $region.center.latitude.wrappedValue
        let longitude = $region.center.longitude.wrappedValue
        
        ZStack {
            
            VStack{
                
                Spacer(minLength: 800)
                
                HStack{
                    //                    TextField("35.69854", value: $galleLan, formatter: NumberFormatter())
                    //                    TextField("139.69601", value: $galleLon, formatter: NumberFormatter())
                }
                
                Map(coordinateRegion: $region,
                    interactionModes: .zoom,
                    showsUserLocation: true,
                    userTrackingMode: $trackingMode)
                
                
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                
                
                
                .clipShape(Circle())
                
                .rotationEffect(Angle(degrees: -heading))
                
                
                //            .clipped()
                //            .mask(
                //                Image("halfCircle")
                //                 .resizable()
                //    //             .frame(width: 100, height: 100, alignment: .trailing)
                //                 .scaledToFit()
                //            )
                
                //                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                //                .shadow(radius: 10)
                //                .padding(40)
                //                .edgesIgnoringSafeArea(.bottom)
            }
            
            VStack{
                Text("緯度：\(latitude) 経度： \(longitude)")
                    .onChange(of: latitude) { newValue in
                        
                        
                        
                        
                        //２点間の距離を求めてる
                        manager.kakudo = manager.angle(currentLatitude: latitude, currentLongitude: longitude, targetLatitude: galleLan, targetLongitude: galleLon)
                        
                        
                        
                        
                        
                        kyori = Int(CLLocation(latitude: latitude ,
                                               longitude: longitude).distance(from: CLLocation(latitude: galleLan ,
                                                                                               longitude: 139.69662)))
                    }
                //            Text("北方向: \(heading)")
                Text("\(heading)")
                Text("方位角\(manager.kakudo)")
                //                Text("\(-heading + Double(manager.kakudo))")
                
                
                
                //                if(Int(heading)<manager.kakudo){
                
                if(kyori < 5){
                    
                    ZStack{
                        Image(systemName: "flag.2.crossed.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
                        Text("あと\(kyori)m")
                            .font(.title)
                        
                            .fontWeight(.black)
                            .foregroundColor(Color.blue)
                        //
                    }
                    
                    
                }else{
                    ZStack{
                        Image(systemName: "location.north")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
                        Text("\(kyori)")
                            .foregroundColor(Color.blue)
                        
                    }
                    .rotationEffect(Angle(degrees:  Double(manager.kakudo)-heading))
                }
                
                
                //                }else if(Int(heading)>manager.kakudo){
                //                    Image(systemName: "location.north")
                //                        .resizable()
                //                        .aspectRatio(contentMode: .fit)
                //                        .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
                //                    .rotationEffect(Angle(degrees:  Double(manager.kakudo)+heading))
                //                }
                
                //                    .rotationEffect(Angle(degrees:Double(manager.kakudo)))
                
                
                
                
            }
        } .onAppear {
            //スリープさせない
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
