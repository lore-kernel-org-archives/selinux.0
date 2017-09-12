Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CH0IAa024059
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 13:00:20 -0400
Received: by mail-io0-f177.google.com with SMTP id g32so32467513ioj.2
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 09:01:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912133835.GA5111@julius.enp8s0.d30>
References: <20170912133835.GA5111@julius.enp8s0.d30>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 12 Sep 2017 12:01:35 -0400
Message-ID: <CAB9W1A0yYAg3UzwPMo6RVUZEdHDNr3BhjKb=vhvJ4GcmyEA+mw@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113f16a6868fb60559002813"
Subject: Re: with extended_socket_class should be still be seeing
 "socket"?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f16a6868fb60559002813
Content-Type: text/plain; charset="UTF-8"

On Sep 12, 2017 7:01 AM, "Dominick Grift" <dac.override@gmail.com> wrote:

I have extended socket class polcap enabled but i am still seeing "socket"
class events and i was wondering whether that is to be expected?

avc:  denied  { create } for  pid=10484 comm="nethogs" scontext=wheel.id:
sysadm.role:nethogs.subj:s0 tcontext=wheel.id:sysadm.role:nethogs.subj:s0
tclass=socket permissive=0

This seems to be common to processes that also create (and map! [1])
"packet_socket" sockets (tcpdump/nethogs)

[1] avc:  denied  { map } for  pid=10525 comm="nethogs"
path="socket:[56040]" dev="sockfs" ino=56040
scontext=wheel.id:sysadm.role:nethogs.subj:s0
tcontext=wheel.id:sysadm.role:nethogs.subj:s0 tclass=packet_socket
permissive=0


No, that is not expected. Can you enable sys call audit and get those
records?


--
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift

--001a113f16a6868fb60559002813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Sep 12, 2017 7:01 AM, &quot;Dominick Grift&quot; &lt;<a href=3D"mailto=
:dac.override@gmail.com">dac.override@gmail.com</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">I have extended socket class polcap en=
abled but i am still seeing &quot;socket&quot; class events and i was wonde=
ring whether that is to be expected?<br>
<br>
avc:=C2=A0 denied=C2=A0 { create } for=C2=A0 pid=3D10484 comm=3D&quot;netho=
gs&quot; scontext=3Dwheel.id:sysadm.role:<wbr>nethogs.subj:s0 tcontext=3Dwh=
eel.id:sysadm.role:<wbr>nethogs.subj:s0 tclass=3Dsocket permissive=3D0<br>
<br>
This seems to be common to processes that also create (and map! [1]) &quot;=
packet_socket&quot; sockets (tcpdump/nethogs)<br>
<br>
[1] avc:=C2=A0 denied=C2=A0 { map } for=C2=A0 pid=3D10525 comm=3D&quot;neth=
ogs&quot; path=3D&quot;socket:[56040]&quot; dev=3D&quot;sockfs&quot; ino=3D=
56040 scontext=3Dwheel.id:sysadm.role:<wbr>nethogs.subj:s0 tcontext=3Dwheel=
.id:sysadm.role:<wbr>nethogs.subj:s0 tclass=3Dpacket_socket permissive=3D0<=
br></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">No, that is not expected. Can you enable sys call audit and get those =
records?=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<font color=3D"#888888"><br>
--<br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/<wbr>pks/lookup?op=3Dget&amp;search=3D<wbr>0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
</font></blockquote></div><br></div></div></div>

--001a113f16a6868fb60559002813--
