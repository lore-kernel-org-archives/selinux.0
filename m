MIME-Version: 1.0
In-Reply-To: <CAN=9EoTMHD3ridU7CZ5bgyXUaRN-vMcvr3T3TrSaHigstWn2mA@mail.gmail.com>
References: <CAN=9EoQa0EMEG26QVJ6vJvfFf5yBW6_eOc3XAifc9xuoijzwhA@mail.gmail.com>
 <CAN=9EoQx2Q2KA2sE58nKvinpU4Js1-Sctgn77MSQ5mGF-hi-2w@mail.gmail.com>
 <CAN=9EoSj3PXQt2ADBkMwJ9u9JBAnz9QfyORzG32aSOHk2ZqeTg@mail.gmail.com>
 <CAN=9EoQZfUoQ5Bty-D-B2dP1swZ=p5dAM9uJmywwWbcZnNPc9g@mail.gmail.com>
 <CAN=9EoSKzx4_C04D6iidyorb1t2xu9KtOt0sSU4zRxVNQSMeaA@mail.gmail.com>
 <CAN=9EoQgxLfMvAZZw0mY9U6wADChBe7a7-dsLusLaAdwcKwT2w@mail.gmail.com>
 <CAN=9EoQOHP=DDowW-zD6FOpEze5H+9wjSbi47Bf9vekmddH85Q@mail.gmail.com>
 <CAN=9EoS9u96H7t8ebuSjK=jLOcOq66Nds70g0sY4W_ELZk_J1Q@mail.gmail.com>
 <CAN=9EoR6KXaWcngW5tUDtnEYiAhRQWS1z-iXsnpgsc=L7oQ3-w@mail.gmail.com>
 <CAN=9EoTMHD3ridU7CZ5bgyXUaRN-vMcvr3T3TrSaHigstWn2mA@mail.gmail.com>
From: Naina Emmanuel <nemmanuel1992@gmail.com>
Date: Tue, 20 Dec 2016 10:30:07 -0800
Message-ID: <CAN=9EoTXW=31mCS-GtsUkhPB3CCj6_jdiiC3vq4pVAV_72DFZg@mail.gmail.com>
Subject: Issues Confined domain
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Cc: masoom alam <masoom.alam@gmail.com>
Content-Type: multipart/alternative; boundary=001a1146f106d0c83e05441b394c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1146f106d0c83e05441b394c
Content-Type: text/plain; charset=UTF-8

Good morning sir,
I have questions about my finding....
Working on SELinux centos 7 (enforcing mode). I don't want any unconfined_t
label on my system, so I have confined my root and my users through
# /usr/sbin/semanage login -a -s staff_u root
# /usr/sbin/semanage login -a -s staff_u test
Q: In enforcing mode I could switch user(su) but I am not able to ssh or
login to root or any user that I am confining, it gives permission denied
error?
Same is the case when I am confining in staff_u or sysadm_u domain



Please help in this regard
Thanks

--001a1146f106d0c83e05441b394c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Good morning sir,<div dir=3D"auto">I have questions about=
 my finding....</div><div dir=3D"auto">Working on SELinux centos 7 (enforci=
ng mode). I don&#39;t want any unconfined_t label on my system, so I have c=
onfined my root and my users through</div><div dir=3D"auto"># /usr/sbin/sem=
anage login -a -s staff_u root</div><div dir=3D"auto"><div dir=3D"auto" sty=
le=3D"font-family:sans-serif"># /usr/sbin/semanage login -a -s staff_u test=
</div><div dir=3D"auto" style=3D"font-family:sans-serif">Q: In enforcing mo=
de I could switch user(su) but I am not able to ssh or login to root or any=
 user that I am confining, it gives permission denied error?</div><div dir=
=3D"auto" style=3D"font-family:sans-serif">Same is the case when I am confi=
ning in staff_u or sysadm_u domain =C2=A0</div><div dir=3D"auto" style=3D"f=
ont-family:sans-serif"><br></div><div dir=3D"auto" style=3D"font-family:san=
s-serif"><br></div><div dir=3D"auto" style=3D"font-family:sans-serif"><br><=
/div><div dir=3D"auto" style=3D"font-family:sans-serif">Please help in this=
 regard</div><div dir=3D"auto" style=3D"font-family:sans-serif">Thanks</div=
></div></div>

--001a1146f106d0c83e05441b394c--
