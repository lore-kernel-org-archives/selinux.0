Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6K7nlxo024383
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 03:49:47 -0400
Received: by ghbz13 with SMTP id z13so3833535ghb.12
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2012 00:49:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdr2ha9=MO9A=F2eySeZeLopp-vo6OY2GdHsW68O_C64hw@mail.gmail.com>
References: <CAFftDdr2ha9=MO9A=F2eySeZeLopp-vo6OY2GdHsW68O_C64hw@mail.gmail.com>
Date: Fri, 20 Jul 2012 00:49:45 -0700
Message-ID: <CAFftDdpt6VGiKQXsZ38MHJDt0sOyNRK0_BVpfxixx44uN+UxeA@mail.gmail.com>
Subject: Re: frameworks/base out of date, needs merge with upstream
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d042f9bc0bd5abe04c53e23ac
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042f9bc0bd5abe04c53e23ac
Content-Type: text/plain; charset=ISO-8859-1

Same thing with Settings....

I think you need to have a merge party

On Fri, Jul 20, 2012 at 12:03 AM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> Build is broken:
>
> frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:140:
> cannot find symbol
> symbol  : variable PhoneConstants
> location: class com.android.internal.telephony.TelephonyCapabilities
>                 || (phone.getPhoneType() ==
> PhoneConstants.PHONE_TYPE_SIP));
>                                             ^
> frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:158:
> cannot find symbol
> symbol  : variable PhoneConstants
> location: class com.android.internal.telephony.TelephonyCapabilities
>         return ((phone.getPhoneType() == PhoneConstants.PHONE_TYPE_GSM)
>                                          ^
> frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:159:
> cannot find symbol
> symbol  : variable PhoneConstants
> location: class com.android.internal.telephony.TelephonyCapabilities
>                 || (phone.getPhoneType() ==
> PhoneConstants.PHONE_TYPE_SIP));
>                                             ^
> frameworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapabilities.java:179:
> cannot find symbol
> symbol  : variable PhoneConstants
> location: class com.android.internal.telephony.TelephonyCapabilities
>         return phoneType == PhoneConstants.PHONE_TYPE_GSM;
>
> That is just some of them, it looks like we need to update your seandroid
> branch with master.
>
> They moved a bunch of telephony code to frameworks/opt/telephony to create
> a common code base..
>
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--f46d042f9bc0bd5abe04c53e23ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Same thing with Settings....<div><br></div><div>I think you need to have a =
merge party<br><br><div class=3D"gmail_quote">On Fri, Jul 20, 2012 at 12:03=
 AM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts=
@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Build is broken:<div><br></div><div><div>fra=
meworks/opt/telephony/src/java/com/android/internal/telephony/TelephonyCapa=
bilities.java:140: cannot find symbol</div>
<div>symbol =A0: variable PhoneConstants</div><div>location: class com.andr=
oid.internal.telephony.TelephonyCapabilities</div>
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
telephony to create a common code base..</div><span class=3D"HOEnZb"><font =
color=3D"#888888"><div><br></div><div><br></div>-- <br>Respectfully,<br><br=
>
William C Roberts<br><br><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfully=
,<br><br>William C Roberts<br><br><br>
</div>

--f46d042f9bc0bd5abe04c53e23ac--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
