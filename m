Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h980GCWt015966
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 20:16:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h980G90p019372
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 00:16:10 GMT
Received: from mf2.bredband.net (mf2.bredband.net [195.54.106.37])
	by jazzswing.ncsc.mil  with ESMTP id h980G8r7019369
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 00:16:09 GMT
Received: from al ([213.113.37.131]) by mf2.bredband.net with ESMTP
          id <20031008001604.BEZT28253.mf2@al> for <selinux@tycho.nsa.gov>;
          Wed, 8 Oct 2003 02:16:04 +0200
From: Alex <alexn@telia.com>
Reply-To: alexn@telia.com
To: selinux@tycho.nsa.gov
Subject: Version mismatch in selinux-usr?
Date: Wed, 8 Oct 2003 02:16:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310080216.03233.alexn@telia.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I built load_policy out of the selinux-usr/policycoreutils/load-policy/ and 
built built my policy.conf and policy.12 out of selinux-usr/policy/

Now it appears to me as if load_policy tries to read a version 15 policydb, 
while the actual binary db is version 12.

Oct  8 01:23:58 selin kernel: security:  policydb version 12 does not match my 
version 15

The load_policy in Brian May's source is a version 12 match, but I needed to 
build a static binary for an initrd image, and the apt-get source selinux 
didn't appear to contain the load_policy files.

So I felt a bit stuck.

Also, I think Russel Coker sent a message earlier about a mkinitrd script 
which I would gladly have a look at, I didn't receive it and the archives 
don't appear to updated every day, so if someone would send it to me I would 
appreciate it.

I'm quite new to this, although I've spent the last days trying to figure out 
why I haven't got selinux up working, so I'm sorry if I'm missing obvious 
things.

Alex


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
