Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9KKPiNs006035
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 16:25:45 -0400 (EDT)
Subject: Re: Small policy cleanups
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20051018001506.GD10592@thorium.jmh.mhn.de>
References: <20051018001506.GD10592@thorium.jmh.mhn.de>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:22:17 -0400
Message-Id: <1129839737.25091.31.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Tue, 2005-10-18 at 02:15 +0200, Thomas Bleher wrote:
> Some cleanups:
> * Use 'self' in a few places where it was missing
> * Remove kerberos_master_port_t as it is not used anywhere
> * Assign attribute proc_fs to type mtrr_device_t as it is used both for
>   /dev/cpu/mtrr and /proc/mtrr
> * add reserved_port_t to dontaudit for userdomain name_bind, as it is
>   not part of reserved_port_type
> * check for xdm.te inside can_pipe_xdm() and remove redundant checks
> * Fix a bug in user_macros.te
> 
> Please apply.
> 
> Thomas
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
