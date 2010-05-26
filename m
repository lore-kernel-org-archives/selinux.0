Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4QKROOm008416
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 16:27:24 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4QKSiHO011648
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 20:28:45 GMT
Received: by pwj6 with SMTP id 6so1133593pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 13:27:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>
References: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>
Date: Thu, 27 May 2010 01:27:21 +0500
Message-ID: <AANLkTineZEFnVtv-2XzU5LVUFpwAMWAraODhzh82kXlt@mail.gmail.com>
Subject: Re: SELinux support in Libc
From: Shaz <shazalive@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0cd11250e8075f04878519a9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd11250e8075f04878519a9
Content-Type: text/plain; charset=ISO-8859-1

> I was building eglibc and saw selinux support flag in it's configure
> script. Any idea what this is used for. Some hints and pointers needed.
>
> SELinux works for me without this support as far as I understand but need
> to get all the goodies that are available. Couln't find anything with a bit
> of googling!
>

According to Eric it has something to do with nscd. Is nscd part of libc
now? Why do we need an object manager here?

"

Glibc's nscd keeps its name service caches in fixed-size files.  These
are always mmap'd into the nscd daemon address space.  "persistent" and
"shared" are both per-name-service options.

"
http://anusf.anu.edu.au/~djh900/nscd.html

I think it is not that important for a newbie like me :(

-- 
Shaz

--000e0cd11250e8075f04878519a9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><div>=A0</div><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">I was building eglibc and saw selinux support flag =
in it&#39;s configure script. Any idea what this is used for. Some hints an=
d pointers needed.<br>
<br>SELinux works for me without this support as far as I understand but ne=
ed to get all the goodies that are available. Couln&#39;t find anything wit=
h a bit of googling!<br clear=3D"all">
</blockquote></div><br>According to Eric it has something to do with nscd. =
Is nscd part of libc now? Why do we need an object manager here? <br><br>&q=
uot;<pre>Glibc&#39;s nscd keeps its name service caches in fixed-size files=
.  These <br>
are always mmap&#39;d into the nscd daemon address space.  &quot;persistent=
&quot; and <br>&quot;shared&quot; are both per-name-service options.<br></p=
re>&quot;<br><a href=3D"http://anusf.anu.edu.au/~djh900/nscd.html">http://a=
nusf.anu.edu.au/~djh900/nscd.html</a><br>
<br>I think it is not that important for a newbie like me :(<br clear=3D"al=
l"><br>-- <br>Shaz<br><br>

--000e0cd11250e8075f04878519a9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
