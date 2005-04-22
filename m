Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3MNxLgA020172
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 19:59:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3MNpJrf005567
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 23:51:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Tweaks to the amavis policy
Date: Sat, 23 Apr 2005 09:54:19 +1000
Cc: "Fedora SELinux support list for users &amp; developers." <fedora-selinux-list@redhat.com>,
   David Hampton <hampton-rh@rainbolthampton.net>, selinux@tycho.nsa.gov
References: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net> <200504221819.49152.russell@coker.com.au> <4268DB1F.80409@redhat.com>
In-Reply-To: <4268DB1F.80409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504230954.23278.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 22 April 2005 21:08, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >allow tmpreaper_t amavisd_quarantine_t:dir { rw_dir_perms unlink };
> >allow tmpreaper_t amavisd_quarantine_t:file { getattr unlink };
>
> Why not add the attribute tmpfile to amavisd_quarantine_t and you get
> this for free.

True.  tmpfile does grant access to the initrc_t domain, but that shouldn't be 
a problem in this case (and I can imagine a start script for amavis wanting 
to do such things).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
