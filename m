Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MJtVdW025459
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 14:55:31 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MJr7ZG010930
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 19:53:11 GMT
Date: Tue, 22 Feb 2005 14:52:58 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   <selinux@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH] Pass requested protection to security_file_mmap/mprotect
 hooks
In-Reply-To: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0502221452190.28223-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Feb 2005, Stephen Smalley wrote:

> possible.  What do people think about this proposed patch (obviously not
> intended for upstreaming until after 2.6.11 is out)?

Seems like a good idea.

> Should the default value for /selinux/checkreqprot be configurable?

I think so, perhaps via a boot param.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
