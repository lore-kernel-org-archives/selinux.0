Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA13281
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 18:43:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA14000
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 22:42:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA13991
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 22:42:45 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Correct order to become sysadm_r
Date: Fri, 23 Aug 2002 00:43:38 +0200
References: <20020822215255.14078.qmail@web40015.mail.yahoo.com>
In-Reply-To: <20020822215255.14078.qmail@web40015.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020822224339.4CF298B5E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Aug 2002 23:52, Brad Chapman wrote:
> What is the correct sequence of commands to change from Brad:user_r:user_t
> to Brad:sysadm_r:sysadm_t without incurring avc: denied errors from either
> the transfer itself or any actions performed within sysadm_r? I'm trying to
> keep a lot of things out of user_macros.te and su_macros.te, and the only
> way to do that IMHO is to become either Brad:sysadm_r:sysadm_t or
> Brad:sysadm_r:sysadm_su_t. How do I do it?

newrole -r sysadm_r

The above command is all you need on a correctly configured system.

As an aside, it's better to change to sysadm_r before running "su -" so you 
can access .bashrc etc.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
