Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6N1e0dW012971
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 21:40:00 -0400
Message-ID: <COL127-W43DF20D535D54DC6DCE37DB1FE0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_1aa00442-8794-49bf-bea3-0733aa9e254d_"
From: Avijit Das <avijitnsec@live.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: File-system is not mounting when I am enabling selinux
Date: Tue, 22 Jul 2014 18:40:03 -0700
In-Reply-To: <53CE5531.4020306@tresys.com>
References: <COL127-W260C753E546A18A707547AB1F00@phx.gbl>,
 <53CE5531.4020306@tresys.com>
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_1aa00442-8794-49bf-bea3-0733aa9e254d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks a lot !!
It resolved my purpose.
Thanks=2CAvijit

> Date: Tue=2C 22 Jul 2014 08:12:33 -0400
> From: cpebenito@tresys.com
> To: avijitnsec@live.com=3B selinux@tycho.nsa.gov
> Subject: Re: File-system is not mounting when I am enabling selinux
>=20
> On 7/21/2014 7:03 PM=2C Avijit Das wrote:
> > Hi=2C
> >=20
> > I am trying to enable SELinux in Android platform. I am getting the
> > following error message:
>=20
> > [   17.767028] SELinux: (dev mmcblk0p24=2C type ext4) has no security
> > xattr handler
> > [   17.830819] SELinux: (dev mmcblk0p29=2C type ext4) has no security
> > xattr handler
> > [   17.865028] EXT4-fs (mmcblk0p29): mounted filesystem with ordered
> > data mode. Opts: barrier=3D1=2Cnoauto_da_alloc
> > [   17.873877] SELinux: (dev mmcblk0p29=2C type ext4) has no security
> > xattr handler
> > [   17.934144] SELinux: (dev mmcblk0p25=2C type ext4) has no security
> > xattr handler
> > [   17.955632] SELinux: (dev mmcblk0p26=2C type ext4) has no security
> > xattr handler
>=20
> Your ext4 is missing security labels (note no security xattr handler
> error)=2C you need to turn on CONFIG_EXT4_FS_SECURITY.
>=20
>=20
> --=20
> Chris PeBenito
> Tresys Technology=2C LLC
> www.tresys.com | oss.tresys.com
 		 	   		  =

--_1aa00442-8794-49bf-bea3-0733aa9e254d_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Thanks a lot !!<div><br></div><d=
iv>It resolved my purpose.</div><div><br></div><div>Thanks=2C</div><div>Avi=
jit<br><br><div>&gt=3B Date: Tue=2C 22 Jul 2014 08:12:33 -0400<br>&gt=3B Fr=
om: cpebenito@tresys.com<br>&gt=3B To: avijitnsec@live.com=3B selinux@tycho=
.nsa.gov<br>&gt=3B Subject: Re: File-system is not mounting when I am enabl=
ing selinux<br>&gt=3B <br>&gt=3B On 7/21/2014 7:03 PM=2C Avijit Das wrote:<=
br>&gt=3B &gt=3B Hi=2C<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B I am trying to en=
able SELinux in Android platform. I am getting the<br>&gt=3B &gt=3B followi=
ng error message:<br>&gt=3B <br>&gt=3B &gt=3B [   17.767028] SELinux: (dev =
mmcblk0p24=2C type ext4) has no security<br>&gt=3B &gt=3B xattr handler<br>=
&gt=3B &gt=3B [   17.830819] SELinux: (dev mmcblk0p29=2C type ext4) has no =
security<br>&gt=3B &gt=3B xattr handler<br>&gt=3B &gt=3B [   17.865028] EXT=
4-fs (mmcblk0p29): mounted filesystem with ordered<br>&gt=3B &gt=3B data mo=
de. Opts: barrier=3D1=2Cnoauto_da_alloc<br>&gt=3B &gt=3B [   17.873877] SEL=
inux: (dev mmcblk0p29=2C type ext4) has no security<br>&gt=3B &gt=3B xattr =
handler<br>&gt=3B &gt=3B [   17.934144] SELinux: (dev mmcblk0p25=2C type ex=
t4) has no security<br>&gt=3B &gt=3B xattr handler<br>&gt=3B &gt=3B [   17.=
955632] SELinux: (dev mmcblk0p26=2C type ext4) has no security<br>&gt=3B &g=
t=3B xattr handler<br>&gt=3B <br>&gt=3B Your ext4 is missing security label=
s (note no security xattr handler<br>&gt=3B error)=2C you need to turn on C=
ONFIG_EXT4_FS_SECURITY.<br>&gt=3B <br>&gt=3B <br>&gt=3B -- <br>&gt=3B Chris=
 PeBenito<br>&gt=3B Tresys Technology=2C LLC<br>&gt=3B www.tresys.com | oss=
.tresys.com<br></div></div> 		 	   		  </div></body>
</html>=

--_1aa00442-8794-49bf-bea3-0733aa9e254d_--
