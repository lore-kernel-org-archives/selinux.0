Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA20224
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 18:16:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA08016
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 22:14:41 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA08012 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 22:14:39 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: minilogd.te
Date: Fri, 12 Jul 2002 00:15:54 +0200
References: <20020711215548.37078.qmail@web40014.mail.yahoo.com>
In-Reply-To: <20020711215548.37078.qmail@web40014.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020711221554.75DA4429@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Jul 2002 23:55, Brad Chapman wrote:
> Everyone,
>
>       Here is a domain setup for minilogd, borrowed from klogd.te.
>
>       Status: It Works For Me (tm)

Use "fd use" not "fd inherit_fd_perms", the latter is obsolete.

Allowing any domain other than devfsd access to devfs_t chr_file devices is 
wrong.  The correct thing to do is to use genfs for anything that needs a 
label before devfsd starts.

What does minilogd do anyway?  Why not give it the same domain as klogd?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
