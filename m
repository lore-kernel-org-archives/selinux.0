Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q3OEDi8t010485
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012 10:13:44 -0400
Received: from mail213-ch1 (localhost [127.0.0.1])	by
 mail213-ch1-R.bigfish.com (Postfix) with ESMTP id A030C4202CD	for
 <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012 14:13:43 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.233])	by mail213-ch1.bigfish.com (Postfix) with ESMTP id
 F0877220045	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012 14:13:41 +0000
 (UTC)
Received: from CT11GSG01.am.mot-solutions.com (il06vts01.mot.com
 [129.188.137.141])	by CT11GSG01.am.mot-solutions.com (8.14.3/8.14.3) with
 ESMTP id q3OEGfBq002600	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012
 10:16:42 -0400 (EDT)
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])	by
 CT11GSG01.am.mot-solutions.com (8.14.3/8.14.3) with ESMTP id q3OEGeek002597
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)	for
 <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012 10:16:41 -0400 (EDT)
Received: from mail76-am1 (localhost [127.0.0.1])	by mail76-am1-R.bigfish.com
 (Postfix) with ESMTP id 0618E2E0471	for
 <selinux@tycho.nsa.gov.FOPE.CONNECTOR.OVERRIDE>; Tue, 24 Apr 2012 14:13:37
 +0000 (UTC)
Received: from AM1EHSMHS003.bigfish.com (unknown [10.3.201.235])	by
 mail76-am1.bigfish.com (Postfix) with ESMTP id 203E42C00B1	for
 <selinux@tycho.nsa.gov>; Tue, 24 Apr 2012 14:13:35 +0000 (UTC)
From: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Success - SEAndroid on Galaxy Nexus maguro
Date: Tue, 24 Apr 2012 14:13:27 +0000
Message-ID: <535CAAB8CFB77F45B4140FC615F0F21E07804B21@CH1PRD0410MB381.namprd04.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_535CAAB8CFB77F45B4140FC615F0F21E07804B21CH1PRD0410MB381_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_535CAAB8CFB77F45B4140FC615F0F21E07804B21CH1PRD0410MB381_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

All,

I've gotten SEAndroid 4.0.3 running on a Samsung Galaxy Nexus maguro (GSM).=
 I've seen posts about it running on Galaxy Nexus already, but I assume tha=
t was the CDMA version toro. Thought I'd my 2 cents and get it going on the=
 GSM handset.

I did have to manually(-ish) build the zImage in order for mkbootimg build =
dependency to be satisfied and didn't see that on the wiki. What's the reas=
oning for creating a separate project for the omap tuna kernel btw? I assum=
e it's because the Android build system is using a prebuilt kernel for the =
recovery image and we wanted an SELinux-aware kernel in place of it?

I haven't successfully turned enforcing on yet, but I have some avc denials=
. I'll try to run audit2allow tonight. The new SEAndroid Manager app with t=
he avc log file save capability is really nifty ;)

Has anyone been trying to get SLIDE/CDS working with the SEAndroid policy? =
My last attempt at it didn't work out because the SEAndroid policy isn't be=
ing compiled in the Referency Policy format as far as I can tell, but I hav=
en't spent significant amounts of time on it either to be honest.

Cheers!
-Tom

--_000_535CAAB8CFB77F45B4140FC615F0F21E07804B21CH1PRD0410MB381_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">All,<br>
<br>
I've gotten SEAndroid 4.0.3 running on a Samsung Galaxy Nexus maguro (GSM).=
 I've seen posts about it running on Galaxy Nexus already, but I assume tha=
t was the CDMA version toro. Thought I'd my 2 cents and get it going on the=
 GSM handset.<br>
<br>
I did have to manually(-ish) build the zImage in order for mkbootimg build =
dependency to be satisfied and didn't see that on the wiki. What's the reas=
oning for creating a separate project for the omap tuna kernel btw? I assum=
e it's because the Android build
 system is using a prebuilt kernel for the recovery image and we wanted an =
SELinux-aware kernel in place of it?<br>
<br>
I haven't successfully turned enforcing on yet, but I have some avc denials=
. I'll try to run audit2allow tonight. The new SEAndroid Manager app with t=
he avc log file save capability is really nifty ;)<br>
<br>
Has anyone been trying to get SLIDE/CDS working with the SEAndroid policy? =
My last attempt at it didn't work out because the SEAndroid policy isn't be=
ing compiled in the Referency Policy format as far as I can tell, but I hav=
en't spent significant amounts of
 time on it either to be honest.<br>
<br>
Cheers!<br>
-Tom<br>
</div>
</body>
</html>

--_000_535CAAB8CFB77F45B4140FC615F0F21E07804B21CH1PRD0410MB381_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
