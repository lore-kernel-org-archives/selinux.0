Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0N6npi7025957
 for <selinux@tycho.nsa.gov>; Mon, 23 Jan 2017 01:49:51 -0500
Received: by mail-lf0-f46.google.com with SMTP id n124so88081391lfd.2
 for <selinux@tycho.nsa.gov>; Sun, 22 Jan 2017 22:49:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2241712.usJZ9WgKHP@russell.coker.com.au>
References: <2241712.usJZ9WgKHP@russell.coker.com.au>
From: Jason Zaman <jason@perfinion.com>
Date: Mon, 23 Jan 2017 14:49:46 +0800
Message-ID: <CAPuKSJZnwX_VMbjfA8_qJTuemwsTTQRu9TL_qdgdMPfqAvepcA@mail.gmail.com>
Subject: Re: NFS mount contexts
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1146e4a4c13e690546bd673c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1146e4a4c13e690546bd673c
Content-Type: text/plain; charset=UTF-8

On 23 Jan 2017 14:41, "Russell Coker" <russell@coker.com.au> wrote:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=851143

I've filed a Debian bug report about systemd not using the context= mount
option.

root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|head -1
type=AVC msg=audit(1484976198.164:160): avc:  denied  { search } for
pid=1090
comm="maildrop" name="/" dev="0:40" ino=256
scontext=system_u:system_r:procmail_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0
root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|tail -1
type=AVC msg=audit(1484976262.152:222): avc:  denied  { search } for
pid=1173
comm="maildrop" name="/" dev="0:40" ino=256
scontext=system_u:system_r:procmail_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0

Also I've got a problem with kernel 4.9.2 apparently having an NFS mount as
unlabeled_t for a minute after it's first mounted.


What NFS version? I am working on a bug I have with labelled NFS v4.2 where
it starts as unlabelled and only gets the right context after getattr is
done on it (which is hard cuz not much has perms towards unlabelled_t)


--
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a1146e4a4c13e690546bd673c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On 23 Jan 2017 14:41, &quot;Russell Coker&quot; &lt;<a href=3D"ma=
ilto:russell@coker.com.au">russell@coker.com.au</a>&gt; wrote:<br type=3D"a=
ttribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><a href=3D"https://bugs.debian.org/cgi=
-bin/bugreport.cgi?bug=3D851143" rel=3D"noreferrer" target=3D"_blank">https=
://bugs.debian.org/cgi-<wbr>bin/bugreport.cgi?bug=3D851143</a><br>
<br>
I&#39;ve filed a Debian bug report about systemd not using the context=3D m=
ount<br>
option.<br>
<br>
root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|head -1<br>
type=3DAVC msg=3Daudit(1484976198.164:160): avc:=C2=A0 denied=C2=A0 { searc=
h } for=C2=A0 pid=3D1090<br>
comm=3D&quot;maildrop&quot; name=3D&quot;/&quot; dev=3D&quot;0:40&quot; ino=
=3D256<br>
scontext=3Dsystem_u:system_r:<wbr>procmail_t:s0<br>
tcontext=3Dsystem_u:object_r:<wbr>unlabeled_t:s0 tclass=3Ddir permissive=3D=
0<br>
root@swssmtp:/tmp# grep unlabeled_t /var/log/audit/audit.log|tail -1<br>
type=3DAVC msg=3Daudit(1484976262.152:222): avc:=C2=A0 denied=C2=A0 { searc=
h } for=C2=A0 pid=3D1173<br>
comm=3D&quot;maildrop&quot; name=3D&quot;/&quot; dev=3D&quot;0:40&quot; ino=
=3D256<br>
scontext=3Dsystem_u:system_r:<wbr>procmail_t:s0<br>
tcontext=3Dsystem_u:object_r:<wbr>unlabeled_t:s0 tclass=3Ddir permissive=3D=
0<br>
<br>
Also I&#39;ve got a problem with kernel 4.9.2 apparently having an NFS moun=
t as<br>
unlabeled_t for a minute after it&#39;s first mounted.<br></blockquote></di=
v></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">What NFS versio=
n? I am working on a bug I have with labelled NFS v4.2 where it starts as u=
nlabelled and only gets the right context after getattr is done on it (whic=
h is hard cuz not much has perms towards unlabelled_t)</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gma=
il_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<font color=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></blockquote></div><br></div></div></div>

--001a1146e4a4c13e690546bd673c--
