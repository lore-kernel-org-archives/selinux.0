Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ANYRLa012747
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:34:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8ANYQmw010707
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:34:26 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8ANYQ9d010702 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:34:26 GMT
Date: Thu, 11 Sep 2003 00:34:24 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910233424.GV5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063233012.27358.11.camel@columbia> <20030910230519.GU5397@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030910230519.GU5397@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2003 at 12:05:19AM +0100, Dale Amon wrote:
> Okay, I see what you've done. mkinitrd loads /etc/mkinitrd/mkinitrd.conf
> which calls /etc/mkinitrd/scripts/selinux.

Okay, next round of questions. According to Steve's HOWTO, the
line

	none /selinux selinuxfs defaults 0 0

goes into the /etc/fstab to cause this file to mount. However
Debian mkinitrd defaults to cramfs and also states it requires
a debian dist patched kernel.

I'm left with these questions:

* what is an selinuxfs???
* where do I find the cramfs patches. I don't use packaged
  kernels. I roll my own no-module jobbies.
* what should dst be?
	mkinitrd -o dst

I'm going to go back and look over Steve's howto again and
see if I can figure how to relate it to your debian set up.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
