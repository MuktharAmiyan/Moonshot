//
//  MissionView.swift
//  Moonshot
//
//  Created by Mukthar Amiyan on 06/08/23.
//

import SwiftUI

struct MissionView: View {
    struct CrewMenber {
        let role : String
        let astronaut : Astronaut
    }
    let mission : Mission
    let crew : [CrewMenber]
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                    VStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.6)
                        
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(.lightBackground)
                                .frame(height: 2)
                                .padding(.vertical)
                            Text("Mission Highlights")
                                .font(.largeTitle.bold())
                                .padding(.bottom, 5)
                            Text(mission.description)
                            Rectangle()
                                .fill(.lightBackground)
                                .frame(height: 2)
                                .padding(.vertical)
                            Text("Crew")
                                .font(.largeTitle.bold())
                                .padding(.bottom,5)
                        }
                        .padding(.horizontal)
                    }
                
                ScrollView (.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(crew,id: \.role) { crew in
                            NavigationLink{
                                AstronautView(astronaut: crew.astronaut)
                            } label: {
                                HStack{
                                    Image(crew.astronaut.id)
                                        .resizable()
                                        .frame(width: 104,height: 72)
                                        .clipShape(Capsule())
                                        .overlay{
                                            Capsule()
                                                .strokeBorder(.white,lineWidth: 1)
                                        }
                                    VStack(alignment: .leading){
                                        Text(crew.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(crew.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.bottom)
                
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMenber(role: member.role, astronaut: astronaut)
            }else{
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
 static  let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts : [String:Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission : missions[0],astronauts:astronauts)
            .preferredColorScheme(.dark)
    }
}
