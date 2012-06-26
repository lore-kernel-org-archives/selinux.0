Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5QF1rbe013149
	for <selinux@tycho.nsa.gov>; Tue, 26 Jun 2012 11:01:53 -0400
Received: from athena.localnet (unknown [10.10.10.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A6F46180D1
	for <selinux@tycho.nsa.gov>; Wed, 27 Jun 2012 01:01:40 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: strange labelling error
Date: Wed, 27 Jun 2012 01:01:41 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206270101.42198.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was relabelling one of my systems that I've been using for development and 
saw the below messages.  I've got no idea how "SystemLow" apparently got into 
the contexts of lots of files.  Any ideas?

I can't reproduce it so I'm not particularly worried, presumably later 
versions of the code in question fixed it.  Given the files that were affected 
I suspect a bug in dpkg or in the SE Linux libraries it uses.  But it's a 
fairly strange one.

restorecon reset /usr/share/doc/xserver-xorg-video-intel/changelog.gz context 
system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
restorecon reset /usr/share/doc/xserver-xorg-video-intel/NEWS.gz context 
system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
restorecon reset /usr/share/doc/xserver-xorg-video-intel/README.Debian context 
system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
restorecon reset /usr/share/doc/xserver-xorg-video-intel/changelog.Debian.gz 
context system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
restorecon reset /usr/share/doc/xserver-xorg-video-intel/README context 
system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0
restorecon reset /usr/share/doc/xserver-xorg-video-intel/copyright context 
system_u:object_r:usr_t:SystemLow->system_u:object_r:usr_t:s0

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
