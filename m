Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8U3GrrT020892
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 23:16:53 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8U3GrjQ007462
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 03:16:53 GMT
Subject: Re: Access to xdm_t
From: Colin Walters <walters@verbum.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
Content-Type: text/plain
Date: Wed, 29 Sep 2004 22:47:35 -0400
Message-Id: <1096512456.5008.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> I have a question about access to xdm_t:
> With KDM 3.3 I am seeing a lot of accesses to xdm_t:fd and
> xdm_t:fifo_file from user processes (say user_lpr_t and user_gpg_t)

For Fedora we modified GDM to log the X session errors to 
/tmp/xses-$USER.$RANDOM, you could probably do something similar with
KDM.

> Should these be allowed?
> If yes, should xdm_t get the attribute privfd?

I think it'd be better to move the X errors to /tmp.  It's more 
NFS-homedir friendly anyways.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
