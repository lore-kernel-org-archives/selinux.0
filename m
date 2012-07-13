Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6DIxVm2019571
	for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2012 14:59:31 -0400
Received: from [192.168.1.2] (169.sub-166-251-210.myvzw.com [166.251.210.169])
	by mail.metronome-software.com (Postfix) with ESMTP id 70B91320125
	for <selinux@tycho.nsa.gov>; Fri, 13 Jul 2012 11:59:27 -0700 (PDT)
Date: Fri, 13 Jul 2012 14:59:25 -0400
Subject: SEAndroid and OpenSSL/ECC support
From: "Gia T. Nguyen" <gia.nguyen@metronome-software.com>
To: <selinux@tycho.nsa.gov>
Message-ID: <CC25E832.655E%gia.nguyen@metronome-software.com>
In-Reply-To: <CC25E820.655E%gia.nguyen@metronome-software.com>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3425036368_1280423"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3425036368_1280423
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit


Hello,

I have SEAndroid working on a Samsung Nexus S device.

We are looking into IPSec implementation via strongSwan next.  I have
SEAndroid working with strongSwan using RSA certificates.  However, I am
running into issues with AES-256 certificates.

A quick search revealed that, apparently, Android's OpenSSL implementation
does not support Elliptical Curve Cryptography by default ???  I'm wondering
if the SEAndroid community has any plan for this.  Any advice would be
greatly appreciated.

Best Regards,
Gia Nguyen





--B_3425036368_1280423
Content-type: text/html;
	charset="US-ASCII"
Content-transfer-encoding: quoted-printable

<html><head></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space; color: rgb(0, 0, 0); "><div sty=
le=3D"font-family: Calibri, sans-serif; font-size: 14px; "><div><div><br></div=
></div></div><span id=3D"OLK_SRC_BODY_SECTION"><div><div style=3D"word-wrap: bre=
ak-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; co=
lor: rgb(0, 0, 0); "><div><div><div style=3D"font-family: Calibri, sans-serif;=
 font-size: 14px; ">Hello,</div><div style=3D"font-family: Calibri, sans-serif=
; font-size: 14px; "><br></div><div style=3D"font-family: Calibri, sans-serif;=
 font-size: 14px; ">I have SEAndroid working on a Samsung Nexus S device.</d=
iv><div style=3D"font-family: Calibri, sans-serif; font-size: 14px; "><br></di=
v><div style=3D"font-family: Calibri, sans-serif; font-size: 14px; ">We are lo=
oking into IPSec implementation via strongSwan next. &nbsp;I have SEAndroid =
working with strongSwan using RSA certificates. &nbsp;However, I am running =
into issues with AES-256 certificates.</div><div style=3D"font-family: Calibri=
, sans-serif; font-size: 14px; "><br></div><div style=3D"font-family: Calibri,=
 sans-serif; font-size: 14px; ">A quick search revealed that, apparently, An=
droid's OpenSSL implementation does not support Elliptical Curve Cryptograph=
y by default ??? &nbsp;I'm wondering if the SEAndroid community has any plan=
 for this. &nbsp;Any advice would be greatly appreciated.</div><div style=3D"f=
ont-family: Calibri, sans-serif; font-size: 14px; "><br></div><div style=3D"fo=
nt-family: Calibri, sans-serif; font-size: 14px; ">Best Regards,</div><div s=
tyle=3D"font-family: Calibri, sans-serif; font-size: 14px; ">Gia Nguyen</div><=
div><div><div><p class=3D"MsoNormal" style=3D"margin-top: 0in; margin-right: 0in=
; margin-left: 0in; margin-bottom: 0.0001pt; color: rgb(0, 0, 0); "><font cl=
ass=3D"Apple-style-span" face=3D"Arial"><span class=3D"Apple-style-span" style=3D"fo=
nt-size: 13px;"><br></span></font></p><p style=3D"font-family: Calibri, sans-s=
erif; font-size: 14px; "></p></div></div></div></div></div></div></div></spa=
n></body></html>

--B_3425036368_1280423--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
