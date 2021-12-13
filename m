Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CA4C433FE
	for <selinux@archiver.kernel.org>; Mon, 13 Dec 2021 10:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbhLMKX1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:23:27 -0500
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:59222 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244171AbhLMKQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Dec 2021 05:16:42 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20211213101638.UFRB24326.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Mon, 13 Dec 2021 10:16:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1639390598; 
        bh=J+htdAqH1j6s8H2JwjcdV2DMnosyDjPL0VOWa+LqcUA=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Iw+9tahkU+rdlvHGw11lSA/rHC/1ym/9m+lLG3Ttb+5IjDokQr+5j4UljCDevKY2o29XoYq9qJS/QAIYL/VX+GhjsT7JcZ2DTVHK4kG65EX4lbuwt0wzcoIeueDn6aAdh3r95teDHzUvsTq28504YiS80OTKmB8YA/oaBiBoRWh1xXCXPGbnvAbnL5vbCuOXpmn7f95emLLEEkzN7K11MpE0bXpwD/JCV0GxDunKPTTTpBDfE8rP9f+Id7QL4i4A6JOGCj28XrXx41ZV6lQ492UiPM3LiDgVp3pTdneDdoI24y5giu6PJejnRWaTVJOhivHZE4PnMh1ckcbffBphCA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A8DE80D18AF92
X-Originating-IP: [217.42.116.92]
X-OWM-Source-IP: 217.42.116.92 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrkeekgddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdhqredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepgfffuddvveffgfegveelledtieeludejueduhefftedtvefhtdehhfeuiefhgeetnecuffhomhgrihhnpehinhhkshgtrghpvgdrohhrghdpphhurhhlrdhorhhgpdhrvghsohhurhgtvgdrohhrghdpfiefrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtnecukfhppedvudejrdegvddrudduiedrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudejrdegvddrudduiedrledvpdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopegusghurhhgvghnvghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgv
        rhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.42.116.92) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8DE80D18AF92; Mon, 13 Dec 2021 10:16:38 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, dburgener@linux.microsoft.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 2/4] src/images: Remove current penguin
Date:   Mon, 13 Dec 2021 10:16:20 +0000
Message-Id: <20211213101622.29888-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213101622.29888-1-richard_c_haines@btinternet.com>
References: <20211213101622.29888-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove penguin image before replacement

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/images/selinux-penguin.svg | 398 ---------------------------------
 1 file changed, 398 deletions(-)
 delete mode 100644 src/images/selinux-penguin.svg

diff --git a/src/images/selinux-penguin.svg b/src/images/selinux-penguin.svg
deleted file mode 100644
index ca7f1c9..0000000
--- a/src/images/selinux-penguin.svg
+++ /dev/null
@@ -1,398 +0,0 @@
-<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
-<!-- Created with Inkscape (http://www.inkscape.org/) -->
-<svg
-   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
-   xmlns:cc=3D"http://web.resource.org/cc/"
-   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
-   xmlns:svg=3D"http://www.w3.org/2000/svg"
-   xmlns=3D"http://www.w3.org/2000/svg"
-   xmlns:xlink=3D"http://www.w3.org/1999/xlink"
-   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
-   width=3D"311.78293"
-   height=3D"282.01117"
-   id=3D"svg2377"
-   sodipodi:version=3D"0.32"
-   inkscape:version=3D"0.44"
-   version=3D"1.0"
-   sodipodi:docbase=3D"/home/duffy/Desktop"
-   sodipodi:docname=3D"selinux-penguin.svg">
-  <defs
-     id=3D"defs2379">
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient3456"
-       id=3D"linearGradient16025"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(0.915315,0,0,0.915315,2239.551,1022.706=
)"
-       x1=3D"1194.6313"
-       y1=3D"412.29538"
-       x2=3D"1171.3751"
-       y2=3D"413.34372" />
-    <linearGradient
-       inkscape:collect=3D"always"
-       id=3D"linearGradient7995">
-      <stop
-         style=3D"stop-color:#f9cd9f;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop7997" />
-      <stop
-         style=3D"stop-color:#f9cd9f;stop-opacity:0;"
-         offset=3D"1"
-         id=3D"stop7999" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient7995"
-       id=3D"linearGradient16023"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(0.875918,0,0,0.84508,2877.878,1271.83)"
-       x1=3D"3350.2542"
-       y1=3D"464.7514"
-       x2=3D"3359.7368"
-       y2=3D"461.95596" />
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient7973"
-       id=3D"linearGradient16021"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(-1.054961,6.473881e-2,5.777657e-2,1.182=
084,4480.016,1225.353)"
-       x1=3D"3368.6697"
-       y1=3D"504.72177"
-       x2=3D"3372.1541"
-       y2=3D"499.90219" />
-    <linearGradient
-       inkscape:collect=3D"always"
-       id=3D"linearGradient7973">
-      <stop
-         style=3D"stop-color:#f6bb7c;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop7975" />
-      <stop
-         style=3D"stop-color:#f6bb7c;stop-opacity:0;"
-         offset=3D"1"
-         id=3D"stop7977" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient7973"
-       id=3D"linearGradient16019"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(1.055304,5.731966e-2,-5.115542e-2,1.182=
467,2251.536,1235.549)"
-       x1=3D"3343.3408"
-       y1=3D"502.40875"
-       x2=3D"3359.9348"
-       y2=3D"501.92487" />
-    <linearGradient
-       inkscape:collect=3D"always"
-       id=3D"linearGradient3456">
-      <stop
-         style=3D"stop-color:#171815;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop3458" />
-      <stop
-         style=3D"stop-color:#171815;stop-opacity:0;"
-         offset=3D"1"
-         id=3D"stop3460" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient3456"
-       id=3D"linearGradient16017"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(0.915315,0,0,0.915315,2239.551,1022.706=
)"
-       x1=3D"1271.3435"
-       y1=3D"427.07864"
-       x2=3D"1285.9489"
-       y2=3D"440.09644" />
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient3204"
-       id=3D"linearGradient16015"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(3.245443,0,0,3.245443,7987.484,7490.317=
)"
-       x1=3D"3275.3098"
-       y1=3D"619.61285"
-       x2=3D"3355.9373"
-       y2=3D"619.61285" />
-    <linearGradient
-       id=3D"linearGradient3204">
-      <stop
-         style=3D"stop-color:#5d6b4c;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop3206" />
-      <stop
-         style=3D"stop-color:#daeac6;stop-opacity:1;"
-         offset=3D"1"
-         id=3D"stop3208" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient3204"
-       id=3D"linearGradient17605"
-       x1=3D"3288.4302"
-       y1=3D"650.5318"
-       x2=3D"3315.6235"
-       y2=3D"598.50146"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"translate(0,-14.36947)" />
-    <linearGradient
-       id=3D"linearGradient8232">
-      <stop
-         style=3D"stop-color:#373737;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop8234" />
-      <stop
-         style=3D"stop-color:#171717;stop-opacity:1;"
-         offset=3D"1"
-         id=3D"stop8236" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient8232"
-       id=3D"linearGradient16011"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(0.915315,0,0,0.915315,4402.845,2122.899=
)"
-       x1=3D"3273.0642"
-       y1=3D"619.61285"
-       x2=3D"3358.1826"
-       y2=3D"619.61285" />
-    <linearGradient
-       id=3D"linearGradient48782">
-      <stop
-         style=3D"stop-color:#9fae8d;stop-opacity:1;"
-         offset=3D"0"
-         id=3D"stop48784" />
-      <stop
-         style=3D"stop-color:#ffffff;stop-opacity:1;"
-         offset=3D"1"
-         id=3D"stop48786" />
-    </linearGradient>
-    <linearGradient
-       inkscape:collect=3D"always"
-       xlink:href=3D"#linearGradient48782"
-       id=3D"linearGradient16009"
-       gradientUnits=3D"userSpaceOnUse"
-       gradientTransform=3D"matrix(-0.706096,0,0,0.706096,1538.025,2255.66=
5)"
-       x1=3D"-2564.1179"
-       y1=3D"-2276.9807"
-       x2=3D"-2479.4502"
-       y2=3D"-2369.3457" />
-  </defs>
-  <sodipodi:namedview
-     id=3D"base"
-     pagecolor=3D"#ffffff"
-     bordercolor=3D"#666666"
-     borderopacity=3D"1.0"
-     gridtolerance=3D"10000"
-     guidetolerance=3D"10"
-     objecttolerance=3D"10"
-     inkscape:pageopacity=3D"0.0"
-     inkscape:pageshadow=3D"2"
-     inkscape:zoom=3D"0.35"
-     inkscape:cx=3D"375"
-     inkscape:cy=3D"520"
-     inkscape:document-units=3D"px"
-     inkscape:current-layer=3D"layer1"
-     inkscape:window-width=3D"858"
-     inkscape:window-height=3D"587"
-     inkscape:window-x=3D"0"
-     inkscape:window-y=3D"26" />
-  <metadata
-     id=3D"metadata2382">
-    <rdf:RDF>
-      <cc:Work
-         rdf:about=3D"">
-        <dc:format>image/svg+xml</dc:format>
-        <dc:type
-           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
-      </cc:Work>
-    </rdf:RDF>
-  </metadata>
-  <g
-     inkscape:label=3D"Layer 1"
-     inkscape:groupmode=3D"layer"
-     id=3D"layer1"
-     transform=3D"translate(-17.82402,-34.21371)">
-    <g
-       id=3D"g15949"
-       transform=3D"matrix(1.973102,0,0,1.973102,-2240.003,-650.9784)"
-       inkscape:export-filename=3D"/home/duffy/Desktop/selinuxnews_logo.pn=
g"
-       inkscape:export-xdpi=3D"90"
-       inkscape:export-ydpi=3D"90">
-      <g
-         transform=3D"matrix(1.880752,0,0,1.880752,-5089.591,-469.8452)"
-         id=3D"g15951">
-        <path
-           style=3D"fill:#4a4a44;fill-opacity:1;fill-rule:evenodd;stroke:#=
21211e;stroke-width:1.875;stroke-linecap:butt;stroke-linejoin:miter;stroke-=
miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3357.7812,439.25 C 3345.872,439.70383 3342.8091,450.3792=
4 3345,459.6875 C 3344.8014,459.75196 3344.046,460.01103 3342.7812,460.4375=
 C 3342.7247,460.45668 3342.6808,460.48087 3342.625,460.5 C 3335.4694,462.9=
1742 3315.6596,469.89994 3318.9062,472.21875 C 3320.881,473.6293 3326.9705,=
474.79999 3333,475.34375 C 3334.0891,475.44197 3335.1903,475.54021 3336.25,=
475.59375 C 3336.2554,476.34243 3336.1874,477.12746 3336.0625,477.96875 C 3=
334.5979,487.83424 3339.9781,501.68694 3356.9375,503.1875 C 3369.9294,504.3=
3701 3379.8469,493.84981 3380.9375,484.09375 C 3385.9834,486.19442 3391.037=
9,487.75359 3393.2188,487.5 C 3397.4563,487.0073 3380.3223,463.56034 3372.6=
875,458.59375 C 3374.3347,449.97263 3370.5741,439.1241 3358.375,439.25 C 33=
58.1811,439.252 3357.9706,439.24278 3357.7812,439.25 z "
-           id=3D"path15953" />
-        <path
-           style=3D"color:black;fill:#f09c42;fill-opacity:1;fill-rule:nonz=
ero;stroke:#21211e;stroke-width:1.4254936;stroke-linecap:round;stroke-linej=
oin:round;marker:none;marker-start:none;marker-mid:none;marker-end:none;str=
oke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1=
;visibility:visible;display:inline;overflow:visible"
-           d=3D"M 3370.0356,505.27476 C 3363.4735,507.14403 3359.39,508.67=
047 3359.8284,505.97579 C 3360.2566,503.34205 3364.8094,500.68175 3369.1849=
,499.42966 C 3373.87,498.08898 3381.6592,503.74169 3381.7517,506.11225 C 33=
81.8276,508.05699 3375.287,504.25072 3370.0356,505.27476 z "
-           id=3D"path15955"
-           sodipodi:nodetypes=3D"csssc" />
-        <path
-           sodipodi:nodetypes=3D"csssc"
-           id=3D"path15957"
-           d=3D"M 3351.1039,505.27476 C 3357.7812,507.14403 3361.9363,508.=
67047 3361.4902,505.97579 C 3361.0545,503.34205 3356.4219,500.68175 3351.96=
96,499.42966 C 3347.2024,498.08898 3339.2766,503.74169 3339.1824,506.11225 =
C 3339.1053,508.05699 3345.7606,504.25072 3351.1039,505.27476 z "
-           style=3D"color:black;fill:#f09c42;fill-opacity:1;fill-rule:nonz=
ero;stroke:#464640;stroke-width:1.00000036;stroke-linecap:round;stroke-line=
join:round;marker:none;marker-start:none;marker-mid:none;marker-end:none;st=
roke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:=
1;visibility:visible;display:inline;overflow:visible" />
-        <path
-           transform=3D"matrix(-0.474298,0,0,0.474298,4931.397,186.8732)"
-           sodipodi:open=3D"true"
-           sodipodi:end=3D"10.6623"
-           sodipodi:start=3D"4.3808269"
-           d=3D"M 3302.5036,581.50298 A 40.305088,40.305088 0 1 1 3302.438=
4,581.5255"
-           sodipodi:ry=3D"40.305088"
-           sodipodi:rx=3D"40.305088"
-           sodipodi:cy=3D"619.61285"
-           sodipodi:cx=3D"3315.6238"
-           id=3D"path15959"
-           style=3D"color:black;fill:url(#linearGradient16009);fill-opacit=
y:1;fill-rule:nonzero;stroke:none;stroke-width:3.70055676;stroke-linecap:ro=
und;stroke-linejoin:round;marker:none;marker-start:none;marker-mid:none;mar=
ker-end:none;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;=
stroke-opacity:1;visibility:visible;display:inline;overflow:visible"
-           sodipodi:type=3D"arc" />
-        <path
-           sodipodi:type=3D"arc"
-           style=3D"color:black;fill:none;fill-opacity:1;fill-rule:nonzero=
;stroke:url(#linearGradient16011);stroke-width:4.49084759;stroke-linecap:ro=
und;stroke-linejoin:round;marker:none;marker-start:none;marker-mid:none;mar=
ker-end:none;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;=
stroke-opacity:1;visibility:visible;display:inline;overflow:visible"
-           id=3D"path15961"
-           sodipodi:cx=3D"3315.6238"
-           sodipodi:cy=3D"619.61285"
-           sodipodi:rx=3D"40.305088"
-           sodipodi:ry=3D"40.305088"
-           d=3D"M 3302.5036,581.50298 A 40.305088,40.305088 0 1 1 3302.438=
4,581.5255"
-           sodipodi:start=3D"4.3808269"
-           sodipodi:end=3D"10.6623"
-           sodipodi:open=3D"true"
-           transform=3D"matrix(0.474298,0,0,0.474298,1786.211,186.8732)" />
-        <path
-           style=3D"color:black;fill:#171815;fill-opacity:1;fill-rule:nonz=
ero;stroke:none;stroke-width:3.70055676;stroke-linecap:round;stroke-linejoi=
n:round;marker:none;marker-start:none;marker-mid:none;marker-end:none;strok=
e-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;v=
isibility:visible;display:inline;overflow:visible"
-           d=3D"M 3358.3936,466.87132 C 3348.7522,466.63462 3341.4323,478.=
75067 3346.391,487.12873 C 3350.2055,494.79772 3361.8727,497.41723 3368.131=
9,491.1222 C 3373.9472,485.84925 3374.4208,475.35973 3368.0094,470.38512 C =
3365.3829,468.07143 3361.8997,466.7011 3358.3936,466.87132 z "
-           id=3D"path15963" />
-        <path
-           sodipodi:type=3D"arc"
-           style=3D"color:black;fill:url(#linearGradient17605);fill-opacit=
y:1;fill-rule:nonzero;stroke:url(#linearGradient16015);stroke-width:6.28939=
438;stroke-linecap:round;stroke-linejoin:round;marker:none;marker-start:non=
e;marker-mid:none;marker-end:none;stroke-miterlimit:4;stroke-dasharray:none=
;stroke-dashoffset:0;stroke-opacity:1;visibility:visible;display:inline;ove=
rflow:visible"
-           id=3D"path15965"
-           sodipodi:cx=3D"3315.6238"
-           sodipodi:cy=3D"619.61285"
-           sodipodi:rx=3D"40.305088"
-           sodipodi:ry=3D"40.305088"
-           d=3D"M 3302.5036,581.50298 A 40.305088,40.305088 0 1 1 3302.438=
4,581.5255"
-           sodipodi:start=3D"4.3808269"
-           sodipodi:end=3D"10.6623"
-           sodipodi:open=3D"true"
-           transform=3D"matrix(0.127397,0,0,0.127397,2936.408,402.0774)" />
-        <path
-           id=3D"path15967"
-           d=3D"M 3358.3936,466.87132 C 3348.7522,466.63462 3341.4323,478.=
75067 3346.391,487.12873 C 3350.2055,494.79772 3361.8727,497.41723 3368.131=
9,491.1222 C 3373.9472,485.84925 3374.4208,475.35973 3368.0094,470.38512 C =
3365.3829,468.07143 3361.8997,466.7011 3358.3936,466.87132 z "
-           style=3D"color:black;fill:none;fill-opacity:1;fill-rule:nonzero=
;stroke:none;stroke-width:10;stroke-linecap:square;stroke-linejoin:bevel;ma=
rker:none;marker-start:none;marker-mid:none;marker-end:none;stroke-miterlim=
it:0;stroke-dasharray:5, 5;stroke-dashoffset:100;stroke-opacity:1;visibilit=
y:visible;display:inline;overflow:visible" />
-        <path
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3359.2737,494.80581 L 3359.1845,489.71914"
-           id=3D"path15969"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           id=3D"path15971"
-           d=3D"M 3358.7952,472.18765 L 3358.7952,466.92251"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           id=3D"path15973"
-           d=3D"M 3367.448,480.75702 L 3372.7138,480.72007"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3344.781,481.14622 L 3350.0471,481.02003"
-           id=3D"path15975"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           id=3D"path15977"
-           d=3D"M 3351.4508,468.78169 L 3352.9571,471.68284"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           sodipodi:nodetypes=3D"cc"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3365.9575,468.65196 L 3364.4511,471.55311"
-           id=3D"path15979" />
-        <path
-           sodipodi:nodetypes=3D"cc"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3352.2291,492.95932 L 3353.7355,490.05816"
-           id=3D"path15981" />
-        <path
-           id=3D"path15983"
-           d=3D"M 3365.9306,492.95932 L 3364.4243,490.05816"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           sodipodi:nodetypes=3D"cc"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3371.2319,474.15681 L 3368.2043,475.38917"
-           id=3D"path15985" />
-        <path
-           id=3D"path15987"
-           d=3D"M 3371.1149,487.33908 L 3367.6965,485.94774"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666831;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           sodipodi:nodetypes=3D"cc"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           d=3D"M 3349.3069,476.03784 L 3346.2792,474.80546"
-           id=3D"path15989" />
-        <path
-           id=3D"path15991"
-           d=3D"M 3349.5664,486.22213 L 3346.5388,487.45449"
-           style=3D"fill:none;fill-opacity:0.75;fill-rule:evenodd;stroke:w=
hite;stroke-width:1.27666879;stroke-linecap:butt;stroke-linejoin:miter;stro=
ke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-           sodipodi:nodetypes=3D"cc" />
-        <path
-           style=3D"color:black;fill:#f09c42;fill-opacity:1;fill-rule:nonz=
ero;stroke:#21211e;stroke-width:0.99999988;stroke-linecap:round;stroke-line=
join:round;marker:none;marker-start:none;marker-mid:none;marker-end:none;st=
roke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:=
1;visibility:visible;display:inline;overflow:visible"
-           d=3D"M 3357.9752,455.64563 C 3353.1378,455.33562 3349.9284,456.=
03051 3350.5062,459.29868 C 3351.0707,462.493 3354.6587,465.66315 3357.8846=
,465.87706 C 3361.339,466.10611 3366.168,461.68483 3365.9987,458.66019 C 33=
65.8599,456.17893 3361.7996,455.29742 3357.9752,455.64563 z "
-           id=3D"path15993"
-           sodipodi:nodetypes=3D"csssc" />
-        <path
-           sodipodi:nodetypes=3D"cscc"
-           id=3D"path15995"
-           d=3D"M 3380.2142,482.67486 C 3381.8468,479.31258 3378.9858,472.=
1602 3379.4313,471.67876 C 3380.8677,470.12618 3388.8256,485.94455 3388.825=
6,485.94455 C 3388.8256,485.94455 3381.7679,483.9143 3380.2142,482.67486 z "
-           style=3D"fill:url(#linearGradient16017);fill-opacity:1;fill-rul=
e:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:=
miter;stroke-opacity:1" />
-        <path
-           style=3D"color:black;fill:#f09c42;fill-opacity:1;fill-rule:nonz=
ero;stroke:#21211e;stroke-width:1.4254936;stroke-linecap:round;stroke-linej=
oin:round;marker:none;marker-start:none;marker-mid:none;marker-end:none;str=
oke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1=
;visibility:visible;display:inline;overflow:visible"
-           d=3D"M 3351.1039,505.27476 C 3357.7812,507.14403 3361.9363,508.=
67047 3361.4902,505.97579 C 3361.0545,503.34205 3356.4219,500.68175 3351.96=
96,499.42966 C 3347.2024,498.08898 3339.2766,503.74169 3339.1824,506.11225 =
C 3339.1053,508.05699 3345.7606,504.25072 3351.1039,505.27476 z "
-           id=3D"path15997"
-           sodipodi:nodetypes=3D"csssc" />
-        <path
-           sodipodi:type=3D"inkscape:offset"
-           inkscape:radius=3D"0"
-           inkscape:original=3D"M 3351.5938 498.53125 C 3347.4332 497.3612=
1 3340.5197 502.2749 3340.4375 504.34375 C 3340.3703 506.04098 3346.1804 50=
2.73129 3350.8438 503.625 C 3356.6712 505.25636 3360.2956 506.57047 3359.90=
62 504.21875 C 3359.526 501.9202 3355.4794 499.62398 3351.5938 498.53125 z "
-           style=3D"color:black;fill:url(#linearGradient16019);fill-opacit=
y:1;fill-rule:nonzero;stroke:none;stroke-width:1.09509909;stroke-linecap:ro=
und;stroke-linejoin:round;marker:none;marker-start:none;marker-mid:none;mar=
ker-end:none;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;=
stroke-opacity:1;visibility:visible;display:inline;overflow:visible"
-           id=3D"path15999"
-           d=3D"M 3351.5938,498.53125 C 3347.4332,497.36121 3340.5197,502.=
2749 3340.4375,504.34375 C 3340.3703,506.04098 3346.1804,502.73129 3350.843=
8,503.625 C 3356.6712,505.25636 3360.2956,506.57047 3359.9062,504.21875 C 3=
359.526,501.9202 3355.4794,499.62398 3351.5938,498.53125 z "
-           transform=3D"matrix(0.79017,-3.830319e-2,3.4184e-2,0.705194,684=
.5232,277.5453)" />
-        <path
-           transform=3D"matrix(-0.789915,4.326094e-2,3.860855e-2,0.704965,=
5997.342,4.964376)"
-           d=3D"M 3351.5938,498.53125 C 3347.4332,497.36121 3340.5197,502.=
2749 3340.4375,504.34375 C 3340.3703,506.04098 3346.1804,502.73129 3350.843=
8,503.625 C 3356.6712,505.25636 3360.2956,506.57047 3359.9062,504.21875 C 3=
359.526,501.9202 3355.4794,499.62398 3351.5938,498.53125 z "
-           id=3D"path16001"
-           style=3D"color:black;fill:url(#linearGradient16021);fill-opacit=
y:1;fill-rule:nonzero;stroke:none;stroke-width:1.09509909;stroke-linecap:ro=
und;stroke-linejoin:round;marker:none;marker-start:none;marker-mid:none;mar=
ker-end:none;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;=
stroke-opacity:1;visibility:visible;display:inline;overflow:visible"
-           inkscape:original=3D"M 3351.5938 498.53125 C 3347.4332 497.3612=
1 3340.5197 502.2749 3340.4375 504.34375 C 3340.3703 506.04098 3346.1804 50=
2.73129 3350.8438 503.625 C 3356.6712 505.25636 3360.2956 506.57047 3359.90=
62 504.21875 C 3359.526 501.9202 3355.4794 499.62398 3351.5938 498.53125 z "
-           inkscape:radius=3D"0"
-           sodipodi:type=3D"inkscape:offset" />
-        <path
-           sodipodi:type=3D"inkscape:offset"
-           inkscape:radius=3D"0"
-           inkscape:original=3D"M 3353.9688 460.28125 C 3351.4236 460.4713=
7 3349.9344 461.36083 3350.3125 463.5 C 3350.8053 466.28778 3353.9346 469.0=
6332 3356.75 469.25 C 3359.7647 469.44989 3363.9914 465.57719 3363.8438 462=
.9375 C 3363.7225 460.77203 3360.1814 460.0086 3356.8438 460.3125 C 3355.78=
83 460.24486 3354.8171 460.21788 3353.9688 460.28125 z "
-           style=3D"color:black;fill:url(#linearGradient16023);fill-opacit=
y:1;fill-rule:nonzero;stroke:none;stroke-width:1.31550419;stroke-linecap:ro=
und;stroke-linejoin:round;marker:none;marker-start:none;marker-mid:none;mar=
ker-end:none;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;=
stroke-opacity:1;visibility:visible;display:inline;overflow:visible"
-           id=3D"path16003"
-           d=3D"M 3353.9688,460.28125 C 3351.4236,460.47137 3349.9344,461.=
36083 3350.3125,463.5 C 3350.8053,466.28778 3353.9346,469.06332 3356.75,469=
.25 C 3359.7647,469.44989 3363.9914,465.57719 3363.8438,462.9375 C 3363.722=
5,460.77203 3360.1814,460.0086 3356.8438,460.3125 C 3355.7883,460.24486 335=
4.8171,460.21788 3353.9688,460.28125 z "
-           transform=3D"matrix(0.794354,0,0,0.823342,690.4498,77.58585)" />
-        <path
-           style=3D"fill:url(#linearGradient16025);fill-opacity:1;fill-rul=
e:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:=
miter;stroke-opacity:1"
-           d=3D"M 3336.7553,475.51765 C 3337.0424,472.75825 3341.5651,468.=
82695 3341.4034,468.1913 C 3340.8821,466.14142 3327.9065,474.47564 3327.906=
5,474.47564 C 3327.9065,474.47564 3334.7984,475.86536 3336.7553,475.51765 z=
 "
-           id=3D"path16005"
-           sodipodi:nodetypes=3D"cscc" />
-      </g>
-      <path
-         style=3D"fill:#0c0c0c;fill-opacity:1;fill-rule:evenodd;stroke:bla=
ck;stroke-width:1.18040431;stroke-linecap:butt;stroke-linejoin:miter;stroke=
-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
-         d=3D"M 1199.9491,373.875 C 1199.7409,374.64642 1199.0943,376.6841=
2 1198.9179,377.875 C 1200.1886,379.43933 1203.44,380.06918 1204.9179,381.5=
 C 1204.9262,381.50588 1204.9411,381.52519 1204.9491,381.53125 C 1205.0029,=
381.5749 1205.0656,381.63536 1205.1054,381.6875 C 1205.7489,382.58612 1204.=
7836,384.65948 1211.3867,386.65625 C 1218.4425,388.79004 1219.7068,388.5750=
8 1221.3241,388.09375 C 1222.9418,387.61242 1223.7617,385.21876 1223.7617,3=
85.21875 C 1223.7616,385.21874 1224.3101,382.32651 1226.3554,382.09375 C 12=
26.3593,382.09488 1226.3829,382.09269 1226.3867,382.09375 C 1226.3949,382.0=
929 1226.4096,382.09451 1226.4179,382.09375 C 1226.42,382.09398 1226.4423,3=
82.09383 1226.4491,382.09375 C 1226.4915,382.0958 1226.533,382.08952 1226.5=
741,382.09375 C 1226.5779,382.09269 1226.6015,382.09488 1226.6054,382.09375=
 C 1228.6507,382.32651 1229.1992,385.21874 1229.1991,385.21875 C 1229.1991,=
385.21876 1230.019,387.61242 1231.6367,388.09375 C 1233.2541,388.57508 1234=
.5183,388.79004 1241.5741,386.65625 C 1248.7368,384.49026 1246.9743,382.252=
08 1248.0429,381.5 C 1249.5208,380.06918 1252.7722,379.43933 1254.0429,377.=
875 C 1253.8665,376.68412 1253.2199,374.64642 1253.0117,373.875 C 1253.0082=
,373.87871 1252.9834,373.90328 1252.9804,373.90625 C 1252.5659,374.12303 12=
48.2762,376.6956 1247.8554,376.875 C 1246.7157,374.49584 1245.0521,374.4044=
2 1237.5429,375.96875 C 1230.2684,377.48419 1228.4897,379.76467 1228.3867,3=
79.90625 C 1228.3867,379.90625 1227.7818,379.90625 1227.4804,379.90625 C 12=
27.1582,379.90625 1227.0738,379.90625 1226.5117,379.90625 C 1225.9007,379.9=
0625 1225.8234,379.90625 1225.4804,379.90625 C 1225.179,379.90625 1224.5741=
,379.90625 1224.5741,379.90625 C 1224.4711,379.76467 1222.6924,377.48419 12=
15.4179,375.96875 C 1207.9087,374.40442 1206.2451,374.49584 1205.1054,376.8=
75 C 1204.6846,376.6956 1200.3949,374.12303 1199.9804,373.90625 C 1199.9774=
,373.90328 1199.9526,373.87871 1199.9491,373.875 z "
-         id=3D"path16007" />
-    </g>
-  </g>
-</svg>
--=20
2.33.1

