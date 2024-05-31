let map;
let featureLayer;
let position;
async function initMap(d) {
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
    //14.669705954830007, 120.56385600326676
    position = { lat: d.Latitude, lng: d.Longitude };
    map = new Map(document.getElementById("map"), {
        center: position,
        zoom: 15,
        mapId: "9e5fbe0df461607b",
    });

    const marker = new AdvancedMarkerElement({
        map: map,
        position: position,
        title: "Bagumbayan",
    });
    featureLayer = map.getFeatureLayer("LOCALITY");
                
    // Define a style with purple fill and border.
    const featureStyleOptions = {
        strokeColor: "#810FCB",
        strokeOpacity: 1.0,
        strokeWeight: 3.0,
        fillColor: "#810FCB",
        fillOpacity: 0.5,
    };

    // Apply the style to a single boundary.
    featureLayer.style = (options) => {
        if (options.feature.placeId == "96b9143ef96ea480") {
            // Hana, HI
            return featureStyleOptions;
        }
    };
}



(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
    key: "AIzaSyAMqWgM1_T6tAN0wtJbCXSByuIzB2yYzkU",
    v: "weekly",
    // Use the 'v' parameter to indicate the version to use (weekly, beta, alpha, etc.).
    // Add other bootstrap parameters as needed, using camel case.
});