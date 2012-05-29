MIME-Version: 1.0
In-Reply-To: <CAFftDdrW0+3Fqbr0Anm6rKxqcE6LhHDa3qd_NG11bskf95Orog@mail.gmail.com>
References: <CAFftDdrW0+3Fqbr0Anm6rKxqcE6LhHDa3qd_NG11bskf95Orog@mail.gmail.com>
Date: Tue, 29 May 2012 15:13:10 -0400
Message-ID: <CAFftDdoNQ0NE=Ha4LqK5XH4jutTkX8FYSPMA9YfYCqxi3WSTFw@mail.gmail.com>
Subject: Re: Update patches for hci_attach service in SE Android
From: William Roberts <bill.c.roberts@gmail.com>
To: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=e89a8ff1bf6c1f989804c131a093
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff1bf6c1f989804c131a093
Content-Type: text/plain; charset=ISO-8859-1

Is anyone reviewing these patches for submission into mainline?

On Thu, May 24, 2012 at 7:47 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> The previous set up patches submitted yesterday got a reworking today with
> the help of Stephen (Thanks).
>
> Here are the most recent changes:
> 1. external/sepolicy/hci_attach.te is created. Since all Android devices
> have a hci_attach service, the rules can be allowed in there.
> 2. device/samsung/tuna policy.fc Labels the files properly that represent
> the hci_attach service. This varies per device.
> 3. General clean up
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

--e89a8ff1bf6c1f989804c131a093
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is anyone reviewing these patches for submission into mainline?=A0<br><br><=
div class=3D"gmail_quote">On Thu, May 24, 2012 at 7:47 PM, William Roberts =
<span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D=
"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The previous set up patches=A0submitted=A0ye=
sterday got a reworking today with the help of Stephen (Thanks).<div><br></=
div>
<div>Here are the most recent changes:</div><div>1. external/sepolicy/hci_a=
ttach.te is created. Since all Android devices have a hci_attach service, t=
he rules can be allowed in there.</div>
<div>2. device/samsung/tuna policy.fc Labels the files properly that repres=
ent the hci_attach service. This varies per device.</div><div>3. General cl=
ean up<span class=3D"HOEnZb"><font color=3D"#888888"><br clear=3D"all"><div=
>
<br></div>-- <br>Respectfully,<br><br>William C Roberts<br>
<br><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfully=
,<br><br>William C Roberts<br><br><br>

--e89a8ff1bf6c1f989804c131a093--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
