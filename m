Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07540
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 10:19:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA28775
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 15:17:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA28771
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 15:17:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: strange problem
Date: Thu, 31 Oct 2002 16:18:59 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210310713590.23380-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210310713590.23380-100000@raven>
MIME-Version: 1.0
Message-Id: <200210311618.59358.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 31 Oct 2002 13:21, Stephen Smalley wrote:
> > When I run "tr" from the command line it works!
> >
> > So why is it being denied when run from crack_t?
>
> This is expected without the separate SELinux patch due to a gap in LSM,
> but should be addressed by the separate SELinux patch.  Please verify that
> this happens with the SELinux patch applied (and not your hacked version
> of the patch, but the original one).  Is this 2.4.19 or 2.5.44?

It's 2.4.19.

I just realised that it's using the kernel without the extra SE patch, not the 
one with the patch.

I was watching TV at the time I was building the new kernel and didn't want to 
reboot my TV in the middle of a show.  After the show ended I forgot to 
reboot with the new kernel... :(

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
