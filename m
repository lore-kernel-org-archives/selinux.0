Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06127
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 11:51:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA10942
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 15:51:12 GMT
Received: from web40018.mail.yahoo.com (web40018.mail.yahoo.com [66.218.78.58])
	by jazzswing.ncsc.mil  with SMTP id PAA10938
	for <selinux@tycho.nsa.gov>; Thu, 4 Jul 2002 15:51:11 GMT
Message-ID: <20020704155141.97379.qmail@web40018.mail.yahoo.com>
Date: Thu, 4 Jul 2002 08:51:41 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: This does not look correct....
To: gdsmarshall@hushmail.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200207041319.g64DJ8448572@mailserver2.hushmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sir,

--- gdsmarshall@hushmail.com wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Hello,
> 
> I know I have not been trying to configure SELinux for very long, but this
> does not look correct to me.  Should ssh have a getty_t definision?  I know
> it needs one to prevent this error message, but is it correct for ssh to have
> a getty_t definision?
> 
> Jul  4 08:05:33 gatekeeper kernel: avc:  denied  { use } for  pid=339
> exe=/usr/bin/ssh path=/dev/tty3 dev=03:01 ino=71770
> scontext=root:sysadm_r:sysadm_ssh_t tcontext=system_u:system_r:getty_t
> tclass=fd
> 
> I am running debian (woody), with kernel from NSA, and packages from
> Russell's site.

        To me, it looks like ssh is trying to access /dev/tty3 and failing
because it isn't allowed the "use" action for the getty_t domain from its own
domain. Try the following rule:

        allow sysadm_ssh_t getty_t:fd use;

        (Note to others: what does "use" mean?)

> 
> Many thanks in advance,
> 
> Spencer

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Sign up for SBC Yahoo! Dial - First Month Free
http://sbc.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
