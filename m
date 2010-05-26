Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4QLDgEx011364
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 17:13:42 -0400
Received: from mail-pz0-f173.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4QLCXBd021977
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 21:12:33 GMT
Received: by pzk3 with SMTP id 3so3484605pzk.26
        for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 14:13:15 -0700 (PDT)
Message-ID: <4BFD8EFC.80502@gmail.com>
Date: Wed, 26 May 2010 14:13:32 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, libc-help@sourceware.org,
        Masoom Alam <masoom.alam@gmail.com>,
        Waqar Afridi <afridi.waqar@gmail.com>,
        Sanaullah khan <sanaullahkhan83@gmail.com>
Subject: Re: SELinux support in Libc
References: <AANLkTinESptHxDYCPSiRJca5_-fK4DsiDwd_KQzQN6gX@mail.gmail.com>	<AANLkTineZEFnVtv-2XzU5LVUFpwAMWAraODhzh82kXlt@mail.gmail.com> <AANLkTiknYkF6FzlZATVKYqRALcC-z7igCAnoecmyjsoA@mail.gmail.com>
In-Reply-To: <AANLkTiknYkF6FzlZATVKYqRALcC-z7igCAnoecmyjsoA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050304090203080000010204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050304090203080000010204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/26/2010 01:44 PM, Shaz wrote:
>
>
> On Thu, May 27, 2010 at 1:27 AM, Shaz <shazalive@gmail.com 
> <mailto:shazalive@gmail.com>> wrote:
>
>         I was building eglibc and saw selinux support flag in it's
>         configure script. Any idea what this is used for. Some hints
>         and pointers needed.
>
>         SELinux works for me without this support as far as I
>         understand but need to get all the goodies that are available.
>         Couln't find anything with a bit of googling!
>
>
>     According to Eric it has something to do with nscd. Is nscd part
>     of libc now? Why do we need an object manager here?
>
>     "
>
>     Glibc's nscd keeps its name service caches in fixed-size files.  These
>
>
>     are always mmap'd into the nscd daemon address space.  "persistent" and
>     "shared" are both per-name-service options.
>          
>
>     "
>     http://anusf.anu.edu.au/~djh900/nscd.html
>     <http://anusf.anu.edu.au/%7Edjh900/nscd.html>
>
>
> http://cblfs.cross-lfs.org/index.php/NSS_Caching mentions some 
> concepts but what can be a possible usecase to understand what this 
> object manager really achieves.
>
> By the way could;nt find relevant eglibc mailing list for this question.
>
> -- 
> Shaz
>
I would try libc:
http://www.gnu.org/software/libc/
(maybe libc-help, and/or general question
list or something).

Justin P. Mattock

--------------050304090203080000010204
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 05/26/2010 01:44 PM, Shaz wrote:
<blockquote
 cite="mid:AANLkTiknYkF6FzlZATVKYqRALcC-z7igCAnoecmyjsoA@mail.gmail.com"
 type="cite"><br>
  <br>
  <div class="gmail_quote">On Thu, May 27, 2010 at 1:27 AM, Shaz <span
 dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:shazalive@gmail.com">shazalive@gmail.com</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div class="im">
    <div class="gmail_quote">
    <div>&nbsp;</div>
    <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I
was building eglibc and saw selinux support flag in it's configure
script. Any idea what this is used for. Some hints and pointers needed.<br>
      <br>
SELinux works for me without this support as far as I understand but
need to get all the goodies that are available. Couln't find anything
with a bit of googling!<br clear="all">
    </blockquote>
    </div>
    <br>
    </div>
According to Eric it has something to do with nscd. Is nscd part of
libc now? Why do we need an object manager here? <br>
    <br>
"
    <pre>Glibc's nscd keeps its name service caches in fixed-size files.  These 


are always mmap'd into the nscd daemon address space.  "persistent" and 
"shared" are both per-name-service options.
    </pre>
"<br>
    <a moz-do-not-send="true"
 href="http://anusf.anu.edu.au/%7Edjh900/nscd.html" target="_blank">http://anusf.anu.edu.au/~djh900/nscd.html</a><br>
  </blockquote>
  </div>
  <br>
  <a moz-do-not-send="true"
 href="http://cblfs.cross-lfs.org/index.php/NSS_Caching">http://cblfs.cross-lfs.org/index.php/NSS_Caching</a>
mentions some concepts but what can be a possible usecase to understand
what this object manager really achieves.<br>
  <br>
By the way could;nt find relevant eglibc mailing list for this question.<br
 clear="all">
  <br>
-- <br>
Shaz<br>
  <br>
</blockquote>
I would try libc:<br>
<a class="moz-txt-link-freetext" href="http://www.gnu.org/software/libc/">http://www.gnu.org/software/libc/</a><br>
(maybe libc-help, and/or general question<br>
list or something).<br>
<br>
Justin P. Mattock<br>
</body>
</html>

--------------050304090203080000010204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
