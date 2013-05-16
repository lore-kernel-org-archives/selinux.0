MIME-Version: 1.0
Date: Fri, 17 May 2013 00:58:27 +0400
Message-ID: <CAHw9pMX-Ji6hds9_oP97NEMzsG5MM_=jwD-mA=eGVWG-Z5jVEA@mail.gmail.com>
Subject: connection between different labels
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013cb9e0c90a3404dcdc20b5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--089e013cb9e0c90a3404dcdc20b5
Content-Type: text/plain; charset=ISO-8859-1

Hi again. Is selinux contain something functional like 'multilevel port'
from solaris trusted extension? Concept of mlp is declaring number of
programm to be 'label aware'. Program of this type, allowed to handling
network request for specified service from all labels and handling/generate
trafic for any labels in clearance. So, OS just delegate information
control to this programm. As my mind, something like this is possible for
selinux contexts (we can allow traffic between different domains by policy,
and selinux context transfered by 'secret' local processing ;) but may be
something like this implemented for information labels s0,s1 etc?

For example:

type=AVC msg=audit(1368735963.286:1998): avc:  denied  { recv } for
 pid=4773 comm="python-thinlinc" saddr=127.0.0.1 src=46092 daddr=127.0.0.1
dest=9000 netif=lo scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
tcontext=system_u:object_r:netlabel_peer_t:s4 tclass=peer


My userspace program need to send status message to master process that
executed with clearance s0-s15:c0.c1023  but denied with request. Hmmm..
But clearance of master process is enough to work with this information?
>From some tests, i got result that 'real' leabel for master process is s0.
And all processes executed with label range handling connection only with
lowest label from range. Ok,  thats strong design and i agree. I can switch
label for reporter process to s0 and send message, of course ... but may be
any trick exist?

--089e013cb9e0c90a3404dcdc20b5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi again. Is selinux contain something functional like &#3=
9;multilevel port&#39; from solaris trusted extension? Concept of mlp is de=
claring number of programm to be &#39;label aware&#39;. Program of this typ=
e, allowed to handling network request for specified service from all label=
s and handling/generate trafic for any labels in clearance. So, OS just del=
egate information control to this programm. As my mind, something like this=
 is possible for selinux contexts (we can allow traffic between different d=
omains by policy, and selinux context transfered by &#39;secret&#39; local =
processing ;) but may be something like this implemented for information la=
bels s0,s1 etc?<div>
<br></div><div style>For example:</div><div style><br></div><div style><div=
>type=3DAVC msg=3Daudit(1368735963.286:1998): avc: =A0denied =A0{ recv } fo=
r =A0pid=3D4773 comm=3D&quot;python-thinlinc&quot; saddr=3D127.0.0.1 src=3D=
46092 daddr=3D127.0.0.1 dest=3D9000 netif=3Dlo scontext=3Dsystem_u:system_r=
:initrc_t:s0-s15:c0.c1023 tcontext=3Dsystem_u:object_r:netlabel_peer_t:s4 t=
class=3Dpeer</div>
<div><br></div><div><br></div><div style>My userspace program need to send =
status message to master process that executed with clearance s0-s15:c0.c10=
23 =A0but denied with request. Hmmm.. But clearance of master process is en=
ough to work with this information? From some tests, i got result that &#39=
;real&#39; leabel for master process is s0. And all processes executed with=
 label range handling connection only with lowest label from range. Ok, =A0=
thats strong design and i agree. I can switch label for reporter process to=
 s0 and send message, of course ... but may be any trick exist?</div>
<div style><br></div><div style><br></div></div></div>

--089e013cb9e0c90a3404dcdc20b5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
