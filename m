Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M8Oi7C014371
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 04:24:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M8Gmrf021979
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 08:16:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: David Hampton <hampton-rh@rainbolthampton.net>
Subject: Re: Tweaks to the amavis policy
Date: Fri, 22 Apr 2005 18:19:46 +1000
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
References: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1110979100.20316.18.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221819.49152.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 March 2005 00:18, David Hampton 
<hampton-rh@rainbolthampton.net> wrote:
> I've added support to the (unused) amavis policy to allow interaction
> with additional mail filters, and added a new type specifically for
> quarantined spam and viruses.  I also tweaked the network access to
> limit ports that can be used by amavisd.  I'd appreciate any feedback on
> these changes or tips on how to write better policies.  Thanks.

+# Tmp reaper
+ifdef(`tmpreaper.te', `
+allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr 
unlink };
+allow tmpreaper_t amavisd_quarantine_t:file getattr;
+')

tmpreaper_t should not need setattr access to the directory.

To perform any useful function tmpreaper_t will need read/write access to the 
directory and unlink access to the file such as the following:

allow tmpreaper_t amavisd_quarantine_t:dir { rw_dir_perms unlink };
allow tmpreaper_t amavisd_quarantine_t:file { getattr unlink };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
