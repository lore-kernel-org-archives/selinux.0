Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBR7bFXf009766
	for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2005 02:37:15 -0500 (EST)
Received: from nproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBR7aHr9009509
	for <selinux@tycho.nsa.gov>; Tue, 27 Dec 2005 07:36:17 GMT
Received: by nproxy.gmail.com with SMTP id y38so456389nfb
        for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2005 23:37:11 -0800 (PST)
Message-ID: <4c2efa540512262337p6a2ec5d0n6ab17ee2302ae623@mail.gmail.com>
Date: Tue, 27 Dec 2005 01:37:10 -0600
From: L L <her.drinne@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: errors compiling policycoreutils-1.28
In-Reply-To: <4c2efa540512250155p3789d9eeg87e1241ed33d2b32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_28389_25621455.1135669030923"
References: <4c2efa540512250155p3789d9eeg87e1241ed33d2b32@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_28389_25621455.1135669030923
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/25/05, L L <her.drinne@gmail.com> wrote:
>
> I'm in the process of a source SELinux install, and have compiled and
> installed libsepol, libselinux and checkpolicy successflly, but when I tr=
y
> to compile policycoreutils, it complains that semanage/modules.h can not =
be
> found. and the build fails.  I cannot find a "module.h" within the tree I
> have all my SELinux files in, but I do have a modules.h as part of
> libsepol.  Not sure if these are related, but I do recall seeing a post i=
n
> the archives about  the read/write for the module sbeing moved from seman=
age
> to sepol, but I do not know if this is related or not.
>
> Any help would be greatly appreciated.  Thanks



I found the problem, sorry to bother everyone.  I had missed libsemanage on
my list of things to install first.  It's working now, and I am on to the
fun bits, like PAM.

Lee
>

------=_Part_28389_25621455.1135669030923
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/25/05, <b class=3D"gmail_sendername">L L</b> &lt;<a href=3D"mailto:he=
r.drinne@gmail.com">her.drinne@gmail.com</a>&gt; wrote:<div><span class=3D"=
gmail_quote"></span><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">
I'm in the process of a source SELinux install, and have compiled and
installed libsepol, libselinux and checkpolicy successflly, but when I
try to compile policycoreutils, it complains that semanage/modules.h
can not be found. and the build fails.&nbsp; I cannot find a &quot;module.h=
&quot;
within the tree I have all my SELinux files in, but I do have a
modules.h as part of libsepol.&nbsp; Not sure if these are related, but
I do recall seeing a post in the archives about&nbsp; the read/write
for the module sbeing moved from semanage to sepol, but I do not know
if this is related or not.<br>
<br>
Any help would be greatly appreciated.&nbsp; Thanks</blockquote><div><br>
<br>
I found the problem, sorry to bother everyone.&nbsp; I had missed
libsemanage on my list of things to install first.&nbsp; It's working
now, and I am on to the fun bits, like PAM.<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Lee<br>

</blockquote></div><br>

------=_Part_28389_25621455.1135669030923--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
