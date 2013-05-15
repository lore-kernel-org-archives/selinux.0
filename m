MIME-Version: 1.0
Date: Wed, 15 May 2013 11:57:34 +0400
Message-ID: <CAHw9pMVv-Q7uZQvd2gJ_AD-FjRGegSWtZFwWH-U85u0vmF3YNw@mail.gmail.com>
Subject: marking ipv6 loopback for cipsov?
From: vlad halilov <vlad.halilov@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=bcaec50dc32c4cae2904dcbd1a3e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec50dc32c4cae2904dcbd1a3e
Content-Type: text/plain; charset=ISO-8859-1

Hello guyz. Is any way to mark traffic for ipv6 loopback interface as
'cipso'? Just have an next avc on redhat enterprise linux 6.4x64:

type=AVC msg=audit(1368559715.534:1532): avc:  denied  { recv } for
 pid=3787 comm="tl-xinit" saddr=::1 src=6001 daddr=::1 dest=51248 netif=lo
scontext=user_u:user_r:user_t:s0-s3:c0.c15
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=peer
type=AVC msg=audit(1368559716.538:1533): avc:  denied  { recv } for
 saddr=::1 src=6001 daddr=::1 dest=51248 netif=lo
scontext=user_u:user_r:user_t:s0-s3:c0.c15
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=peer
type=AVC msg=audit(1368559718.537:1545): avc:  denied  { recv } for
 pid=3795 comm="unix_chkpwd" saddr=::1 src=6001 daddr=::1 dest=51248
netif=lo scontext=user_u:user_r:user_t:s0-s3:c0.c15
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=peer
type=AVC msg=audit(1368559722.540:1560): avc:  denied  { recv } for
 saddr=::1 src=6001 daddr=::1 dest=51248 netif=lo
scontext=user_u:user_r:user_t:s0-s3:c0.c15
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=peer
type=AVC msg=audit(1368559730.540:1561): avc:  denied  { recv } for
 saddr=::1 src=6001 daddr=::1 dest=51248 netif=lo
scontext=user_u:user_r:user_t:s0-s3:c0.c15
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=peer



Server configures as mls system, and there are 'tl-xinit' that tried to
connect via ipv6 loopback (?), and context marked as unlabeled_t:s15 ....
so, no connection.


network configures as:

netlabelctl unlbl add interface:eth0
address:0.0.0.0/0label:system_u:object_r:node_t:s0
netlabelctl map del default
netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
netlabelctl cipsov4 add pass doi:32 tags:1
netlabelctl map add default address:127.0.0.0/8 protocol:cipsov4,32
netlabelctl map add default address:192.168.1.96/32 protocol:cipsov4,32
netlabelctl map add default address:::/0 protocol:unlbl

p.s.  btw, i tried to make something fool action, like 'netlabelctl map add
default address:::/128 protocol:cipsov4,32' and get kernel bug .. :)  is
these result need to be reported or no?

--bcaec50dc32c4cae2904dcbd1a3e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello guyz. Is any way to mark traffic for ipv6 loopback i=
nterface as &#39;cipso&#39;? Just have an next avc on redhat enterprise lin=
ux 6.4x64:<div><br></div><div><div>type=3DAVC msg=3Daudit(1368559715.534:15=
32): avc: =A0denied =A0{ recv } for =A0pid=3D3787 comm=3D&quot;tl-xinit&quo=
t; saddr=3D::1 src=3D6001 daddr=3D::1 dest=3D51248 netif=3Dlo scontext=3Dus=
er_u:user_r:user_t:s0-s3:c0.c15 tcontext=3Dsystem_u:object_r:unlabeled_t:s1=
5:c0.c1023 tclass=3Dpeer</div>
<div>type=3DAVC msg=3Daudit(1368559716.538:1533): avc: =A0denied =A0{ recv =
} for =A0saddr=3D::1 src=3D6001 daddr=3D::1 dest=3D51248 netif=3Dlo scontex=
t=3Duser_u:user_r:user_t:s0-s3:c0.c15 tcontext=3Dsystem_u:object_r:unlabele=
d_t:s15:c0.c1023 tclass=3Dpeer</div>
<div>type=3DAVC msg=3Daudit(1368559718.537:1545): avc: =A0denied =A0{ recv =
} for =A0pid=3D3795 comm=3D&quot;unix_chkpwd&quot; saddr=3D::1 src=3D6001 d=
addr=3D::1 dest=3D51248 netif=3Dlo scontext=3Duser_u:user_r:user_t:s0-s3:c0=
.c15 tcontext=3Dsystem_u:object_r:unlabeled_t:s15:c0.c1023 tclass=3Dpeer</d=
iv>
<div>type=3DAVC msg=3Daudit(1368559722.540:1560): avc: =A0denied =A0{ recv =
} for =A0saddr=3D::1 src=3D6001 daddr=3D::1 dest=3D51248 netif=3Dlo scontex=
t=3Duser_u:user_r:user_t:s0-s3:c0.c15 tcontext=3Dsystem_u:object_r:unlabele=
d_t:s15:c0.c1023 tclass=3Dpeer</div>
<div>type=3DAVC msg=3Daudit(1368559730.540:1561): avc: =A0denied =A0{ recv =
} for =A0saddr=3D::1 src=3D6001 daddr=3D::1 dest=3D51248 netif=3Dlo scontex=
t=3Duser_u:user_r:user_t:s0-s3:c0.c15 tcontext=3Dsystem_u:object_r:unlabele=
d_t:s15:c0.c1023 tclass=3Dpeer</div>
</div><div><br></div><div><br></div><div><br></div><div style>Server config=
ures as mls system, and there are &#39;tl-xinit&#39; that tried to connect =
via ipv6 loopback (?), and context marked as unlabeled_t:s15 .... so, no co=
nnection.</div>
<div style><br></div><div style><br></div><div style>network configures as:=
</div><div style><br></div><div style><div>netlabelctl unlbl add interface:=
eth0 address:<a href=3D"http://0.0.0.0/0">0.0.0.0/0</a> label:system_u:obje=
ct_r:node_t:s0=A0</div>
<div>netlabelctl map del default</div><div>netlabelctl map add default addr=
ess:<a href=3D"http://0.0.0.0/0">0.0.0.0/0</a> protocol:unlbl=A0</div><div>=
netlabelctl cipsov4 add pass doi:32 tags:1</div><div>netlabelctl map add de=
fault address:<a href=3D"http://127.0.0.0/8">127.0.0.0/8</a> protocol:cipso=
v4,32=A0</div>
<div>netlabelctl map add default address:<a href=3D"http://192.168.1.96/32"=
>192.168.1.96/32</a> protocol:cipsov4,32</div><div>netlabelctl map add defa=
ult address:::/0 protocol:unlbl</div><div><br></div><div style>p.s. =A0btw,=
 i tried to make something fool action, like &#39;netlabelctl map add defau=
lt address:::/128 protocol:cipsov4,32&#39; and get kernel bug .. :) =A0is t=
hese result need to be reported or no?</div>
</div></div>

--bcaec50dc32c4cae2904dcbd1a3e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
