Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA14266
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 19:13:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA10406
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 23:12:49 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id XAA10402
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 23:12:48 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: /tmp and others
Date: Sat, 6 Jul 2002 19:13:19 -0400
Message-ID: <004f01c22542$b775b8d0$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020706200822.1332F2892@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Ah.  For the /proc exploits I do recall reading about some but don't
remember the names.  I do know some rootkits use /proc.

Ed

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Thursday, July 04, 2002 9:39 PM
To: blacknet@simplyaquatics.com; Selinux
Subject: Re: /tmp and others

On Wed, 3 Jul 2002 22:25, Ed Street wrote:
> I'm curious as to how Selinux deals with /tmp issues like exploits.

As a general rule each domain that creates files in /tmp uses a
different 
type (user_tmp_t for user_t domain and sysadm_tmp_t for sysadm_t
domain).  So 
the only race condition that you are vulnerable to in a typical
configuration 
is that of having the system administrator follow a sym-link created by
a 
user.  But this could be fixed by a different policy (and I may do this
in my 
default policy).

There was a question about this issue at my presentation for OLS.

> Also how does Selinux deal with stack exploits and /proc exploits?

It doesn't do anything with stack exploits, you should be able to get
one of 
the stack protection mechanisms going in addition to it, but I've never 
really tried.

As for /proc exploits, what exactly do you mean?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
