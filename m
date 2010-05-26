Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4QKtCmV009862
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 16:55:12 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4QKuUHO019302
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 20:56:30 GMT
Received: by pwj6 with SMTP id 6so1146222pwj.12
        for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 13:55:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTineZEFnVtv-2XzU5LVUFpwAMWAraODhzh82kXlt@mail.gmail.com>
References: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>
	<AANLkTineZEFnVtv-2XzU5LVUFpwAMWAraODhzh82kXlt@mail.gmail.com>
Date: Thu, 27 May 2010 01:44:26 +0500
Message-ID: <AANLkTiknYkF6FzlZATVKYqRALcC-z7igCAnoecmyjsoA@mail.gmail.com>
Subject: Re: SELinux support in Libc
From: Shaz <shazalive@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: libc-help@sourceware.org, Masoom Alam <masoom.alam@gmail.com>,
        Waqar Afridi <afridi.waqar@gmail.com>,
        Sanaullah khan <sanaullahkhan83@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd17fe4ffad40048785562b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd17fe4ffad40048785562b
Content-Type: text/plain; charset=ISO-8859-1

On Thu, May 27, 2010 at 1:27 AM, Shaz <shazalive@gmail.com> wrote:

>
>
>> I was building eglibc and saw selinux support flag in it's configure
>> script. Any idea what this is used for. Some hints and pointers needed.
>>
>> SELinux works for me without this support as far as I understand but need
>> to get all the goodies that are available. Couln't find anything with a bit
>> of googling!
>>
>
> According to Eric it has something to do with nscd. Is nscd part of libc
> now? Why do we need an object manager here?
>
> "
>
> Glibc's nscd keeps its name service caches in fixed-size files.  These
>
> are always mmap'd into the nscd daemon address space.  "persistent" and
> "shared" are both per-name-service options.
>
> "
> http://anusf.anu.edu.au/~djh900/nscd.html<http://anusf.anu.edu.au/%7Edjh900/nscd.html>
>

http://cblfs.cross-lfs.org/index.php/NSS_Caching mentions some concepts but
what can be a possible usecase to understand what this object manager really
achieves.

By the way could;nt find relevant eglibc mailing list for this question.

-- 
Shaz

--000e0cd17fe4ffad40048785562b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, May 27, 2010 at 1:27 AM, Shaz <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:shazalive@gmail.com">shazalive@gmail.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
<div class=3D"im"><div class=3D"gmail_quote"><div>=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I was building eglibc and saw sel=
inux support flag in it&#39;s configure script. Any idea what this is used =
for. Some hints and pointers needed.<br>

<br>SELinux works for me without this support as far as I understand but ne=
ed to get all the goodies that are available. Couln&#39;t find anything wit=
h a bit of googling!<br clear=3D"all">
</blockquote></div><br></div>According to Eric it has something to do with =
nscd. Is nscd part of libc now? Why do we need an object manager here? <br>=
<br>&quot;<pre>Glibc&#39;s nscd keeps its name service caches in fixed-size=
 files.  These <br>

are always mmap&#39;d into the nscd daemon address space.  &quot;persistent=
&quot; and <br>&quot;shared&quot; are both per-name-service options.<br></p=
re>&quot;<br><a href=3D"http://anusf.anu.edu.au/%7Edjh900/nscd.html" target=
=3D"_blank">http://anusf.anu.edu.au/~djh900/nscd.html</a><br>

</blockquote></div><br><a href=3D"http://cblfs.cross-lfs.org/index.php/NSS_=
Caching">http://cblfs.cross-lfs.org/index.php/NSS_Caching</a> mentions some=
 concepts but what can be a possible usecase to understand what this object=
 manager really achieves.<br>
<br>By the way could;nt find relevant eglibc mailing list for this question=
.<br clear=3D"all"><br>-- <br>Shaz<br><br>

--000e0cd17fe4ffad40048785562b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
