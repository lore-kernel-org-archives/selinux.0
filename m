Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA10770
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 18:44:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA25091
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 22:44:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA25087
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 22:44:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Updated Release
Date: Tue, 4 Jun 2002 00:44:04 +0200
Cc: Howard Holm <hdholm@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206030849470.25105-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206030849470.25105-100000@raven>
MIME-Version: 1.0
Message-Id: <20020603224404.B7C1E7272@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 Jun 2002 14:53, Stephen Smalley wrote:
> On Sat, 1 Jun 2002, Russell Coker wrote:
> > For 2.4.18 the kernel patch doesn't have the recent patches for
> > security_get_sids or the patch for sleeping allocation during a policy
> > load.
>
> I'm not sure what you mean.  I just downloaded the complete lsm-2.4 tree
> and the lsm patch from the NSA SELinux web site, and they did include
> these patches.

I have checked it again, it seems that I made a mistake.  I may have 
mistakenly used the latest LSM release when comparing instead.

It seems that the version on the NSA site has all the patches plus some new 
socket and MLS support.  I'll have it in Debian tomorrow.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
