Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ANmbLa012807
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:48:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ANl0LY015207
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:47:00 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8ANl0sG015203
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:47:00 GMT
Date: Thu, 11 Sep 2003 00:48:35 +0100
From: Dale Amon <amon@vnl.com>
To: Colin Walters <walters@verbum.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910234834.GW5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063233012.27358.11.camel@columbia> <20030910230519.GU5397@vnl.com> <20030910233424.GV5397@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030910233424.GV5397@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2003 at 12:34:24AM +0100, Dale Amon wrote:
> * what should dst be?
> 	mkinitrd -o dst

Actually, I presume this gets done on bootup as

	mkinitrd -o /selinux

if I understand what is going on... which still
leaves me wondering about selinuxfs which I had
not run across before. Or does the boot up do this:

   mkinitrd -m "make an selinuxfs cmdstr" -o /selinux


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
