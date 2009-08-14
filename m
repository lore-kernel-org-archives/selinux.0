Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7EBdWND001930
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 07:39:32 -0400
Received: from snt0-omc4-s36.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7EBd2E3023505
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:39:02 GMT
Message-ID: <SNT115-W34F722C08C53D234FB37CEC1020@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_2963ea34-ac56-4986-8bbb-02972a42da5d_"
From: Stefano Carucci <stecarucci@hotmail.com>
To: <jmorris@namei.org>
CC: <selinux@tycho.nsa.gov>
Subject: RE: SElinux protection
Date: Fri, 14 Aug 2009 11:39:31 +0000
In-Reply-To: <alpine.LRH.2.00.0908142117440.17571@tundra.namei.org>
References: <SNT115-W6FF8468946D002609BC73C1020@phx.gbl>
 <alpine.LRH.2.00.0908142117440.17571@tundra.namei.org>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_2963ea34-ac56-4986-8bbb-02972a42da5d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Two further questions:

1. Does SELinux provide any countermeasure against buffer overflows attacks=
?=20

2. I read about the possibility of keeping processes from forking. Wouldn't=
 you consider this as a protection from DoS attacks?



> Date: Fri=2C 14 Aug 2009 21:28:57 +1000
> From: jmorris@namei.org
> To: stecarucci@hotmail.com
> CC: selinux@tycho.nsa.gov
> Subject: Re: SElinux protection
>=20
> On Fri=2C 14 Aug 2009=2C Stefano Carucci wrote:
>=20
> >=20
> > Hello all.
> >=20
> > I would like to pose some questions on the type of attacks that SELinux=
 offers a protection from.
> >=20
> > In particular:=20
> > 1. What are the type of attacks that are inhibited?
>=20
> The aim for the general case is to contain software vulnerabilities in=20
> userland code.  Note that in commonly shipped general purpose policies=2C=
=20
> local login users are not confined by default=3B the emphasis is on locki=
ng=20
> down network facing services.
>=20
> > 2. What are those that are not=2C because not explicitly designed for=
=2C and may still affect the system?
>=20
> As mentioned=2C local login users are generally not confined by SELinux=20
> policy in Fedora-based systems=2C although this is a matter of policy=20
> design=3B it's not inherent to SELinux itself.  There are some examples o=
f=20
> confining local users=2C such as Kiosk Mode (install the xguest package)=
=2C=20
> and work in this area generally is expected to continue.
>=20
> SELinux operates at the kernel level=2C so vulnerabilities in the kernel=
=20
> itself may reduce or disable the protection of SELinux.  Other mechanisms=
=20
> are required to protect the kernel.
>=20
> > 3. Is there any countermeasure against DoS attacks?
>=20
> No.
>=20
> A lot of information on SELinux is available here:
> http://selinuxproject.org/page/User_Resources
>=20
> This is a very brief overview:
> http://www.slideshare.net/jamesmorris/lf-japan-08-talk
>=20
>=20
> --=20
> James Morris
> <jmorris@namei.org>

_________________________________________________________________
Messenger =E8 su Hotmail. Scopri le novit=E0.
http://www.messenger.it/accediWebMessengerHotmail.aspx=

--_2963ea34-ac56-4986-8bbb-02972a42da5d_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
<br>Two further questions:<br><br>1. Does SELinux provide any countermeasur=
e against buffer overflows attacks? <br><br>2. I read about the possibility=
 of keeping processes from forking. Wouldn't you consider this as a protect=
ion from DoS attacks?<br><br><br><br>&gt=3B Date: Fri=2C 14 Aug 2009 21:28:=
57 +1000<br>&gt=3B From: jmorris@namei.org<br>&gt=3B To: stecarucci@hotmail=
.com<br>&gt=3B CC: selinux@tycho.nsa.gov<br>&gt=3B Subject: Re: SElinux pro=
tection<br>&gt=3B <br>&gt=3B On Fri=2C 14 Aug 2009=2C Stefano Carucci wrote=
:<br>&gt=3B <br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Hello all.<br>&gt=3B &gt=3B=
 <br>&gt=3B &gt=3B I would like to pose some questions on the type of attac=
ks that SELinux offers a protection from.<br>&gt=3B &gt=3B <br>&gt=3B &gt=
=3B In particular: <br>&gt=3B &gt=3B 1. What are the type of attacks that a=
re inhibited?<br>&gt=3B <br>&gt=3B The aim for the general case is to conta=
in software vulnerabilities in <br>&gt=3B userland code.  Note that in comm=
only shipped general purpose policies=2C <br>&gt=3B local login users are n=
ot confined by default=3B the emphasis is on locking <br>&gt=3B down networ=
k facing services.<br>&gt=3B <br>&gt=3B &gt=3B 2. What are those that are n=
ot=2C because not explicitly designed for=2C and may still affect the syste=
m?<br>&gt=3B <br>&gt=3B As mentioned=2C local login users are generally not=
 confined by SELinux <br>&gt=3B policy in Fedora-based systems=2C although =
this is a matter of policy <br>&gt=3B design=3B it's not inherent to SELinu=
x itself.  There are some examples of <br>&gt=3B confining local users=2C s=
uch as Kiosk Mode (install the xguest package)=2C <br>&gt=3B and work in th=
is area generally is expected to continue.<br>&gt=3B <br>&gt=3B SELinux ope=
rates at the kernel level=2C so vulnerabilities in the kernel <br>&gt=3B it=
self may reduce or disable the protection of SELinux.  Other mechanisms <br=
>&gt=3B are required to protect the kernel.<br>&gt=3B <br>&gt=3B &gt=3B 3. =
Is there any countermeasure against DoS attacks?<br>&gt=3B <br>&gt=3B No.<b=
r>&gt=3B <br>&gt=3B A lot of information on SELinux is available here:<br>&=
gt=3B http://selinuxproject.org/page/User_Resources<br>&gt=3B <br>&gt=3B Th=
is is a very brief overview:<br>&gt=3B http://www.slideshare.net/jamesmorri=
s/lf-japan-08-talk<br>&gt=3B <br>&gt=3B <br>&gt=3B -- <br>&gt=3B James Morr=
is<br>&gt=3B &lt=3Bjmorris@namei.org&gt=3B<br><br /><hr />Dove sono i tuoi =
amici? <a href=3D'http://www.windowslive.it/invitaAmici.aspx' target=3D'_ne=
w'>Aggiungili a Messenger.</a></body>
</html>=

--_2963ea34-ac56-4986-8bbb-02972a42da5d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
