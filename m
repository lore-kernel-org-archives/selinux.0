Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6K73XUl022603
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 03:03:33 -0400
Received: by pbbrr13 with SMTP id rr13so5597065pbb.12
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 00:03:31 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 20 Jul 2012 00:03:31 -0700
Message-ID: <CAFftDdr2ha9=MO9A=F2eySeZeLopp-vo6OY2GdHsW68O_C64hw@mail.gmail.com>
Subject: frameworks/base out of date, needs merge with upstream
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b339bf56de6c404c53d7e87
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b339bf56de6c404c53d7e87
Content-Type: text/plain; charset=ISO-8859-1

Build is broken:

frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:140:
cannot find symbol
symbol  : variable PhoneConstants
location: class com.android.internal.telephony.TelephonyCapabilities
                || (phone.getPhoneType() == PhoneConstants.PHONE_TYPE_SIP));
                                            ^
frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:158:
cannot find symbol
symbol  : variable PhoneConstants
location: class com.android.internal.telephony.TelephonyCapabilities
        return ((phone.getPhoneType() == PhoneConstants.PHONE_TYPE_GSM)
                                         ^
frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:159:
cannot find symbol
symbol  : variable PhoneConstants
location: class com.android.internal.telephony.TelephonyCapabilities
                || (phone.getPhoneType() == PhoneConstants.PHONE_TYPE_SIP));
                                            ^
frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:179:
cannot find symbol
symbol  : variable PhoneConstants
location: class com.android.internal.telephony.TelephonyCapabilities
        return phoneType == PhoneConstants.PHONE_TYPE_GSM;

That is just some of them, it looks like we need to update your seandroid
branch with master.

They moved a bunch of telephony code to frameworks/opt/telephony to create
a common code base..


-- 
Respectfully,

William C Roberts

--047d7b339bf56de6c404c53d7e87
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Build is broken:<div><br></div><div><div>frameworks/opt/telephony/src/java/=
com/android/internal/telephony/TelephonyCapabilities.java:140: cannot find =
symbol</div><div>symbol =A0: variable PhoneConstants</div><div>location: cl=
ass com.android.internal.telephony.TelephonyCapabilities</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (phone.getPhoneType() =3D=3D PhoneC=
onstants.PHONE_TYPE_SIP));</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^</div><div>frameworks/=
opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities=
.java:158: cannot find symbol</div>
<div>symbol =A0: variable PhoneConstants</div><div>location: class com.andr=
oid.internal.telephony.TelephonyCapabilities</div><div>=A0 =A0 =A0 =A0 retu=
rn ((phone.getPhoneType() =3D=3D PhoneConstants.PHONE_TYPE_GSM)</div><div>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0^</div>
<div>frameworks/opt/telephony/src/java/com/android/internal/telephony/Telep=
honyCapabilities.java:159: cannot find symbol</div><div>symbol =A0: variabl=
e PhoneConstants</div><div>location: class com.android.internal.telephony.T=
elephonyCapabilities</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (phone.getPhoneType() =3D=3D PhoneC=
onstants.PHONE_TYPE_SIP));</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^</div><div>frameworks/=
opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities=
.java:179: cannot find symbol</div>
<div>symbol =A0: variable PhoneConstants</div><div>location: class com.andr=
oid.internal.telephony.TelephonyCapabilities</div><div>=A0 =A0 =A0 =A0 retu=
rn phoneType =3D=3D PhoneConstants.PHONE_TYPE_GSM;</div><div><br></div><div=
>That is just some of them, it looks like we need to update your seandroid =
branch with master.</div>
<div><br></div><div>They moved a bunch of telephony code to frameworks/opt/=
telephony to create a common code base..</div><div><br></div><div><br></div=
>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--047d7b339bf56de6c404c53d7e87--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
