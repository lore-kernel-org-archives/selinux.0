Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13785
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 16:07:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA05818
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:07:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA05814
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 20:07:00 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "Selinux" <selinux@tycho.nsa.gov>
Subject: Re: /tmp and others
Date: Thu, 4 Jul 2002 21:38:39 -0400
References: <004f01c22302$150ebf70$0a01a8c0@ed>
In-Reply-To: <004f01c22302$150ebf70$0a01a8c0@ed>
MIME-Version: 1.0
Message-Id: <20020706200822.1332F2892@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Jul 2002 22:25, Ed Street wrote:
> I'm curious as to how Selinux deals with /tmp issues like exploits.

As a general rule each domain that creates files in /tmp uses a different 
type (user_tmp_t for user_t domain and sysadm_tmp_t for sysadm_t domain).  So 
the only race condition that you are vulnerable to in a typical configuration 
is that of having the system administrator follow a sym-link created by a 
user.  But this could be fixed by a different policy (and I may do this in my 
default policy).

There was a question about this issue at my presentation for OLS.

> Also how does Selinux deal with stack exploits and /proc exploits?

It doesn't do anything with stack exploits, you should be able to get one of 
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
