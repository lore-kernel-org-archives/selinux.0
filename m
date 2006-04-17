Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3HHuOjH021774
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 13:56:24 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3HHuNND022399
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 17:56:23 GMT
Subject: Re: Latest patches.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Russell Coker <rcoker@redhat.com>
In-Reply-To: <443F90CB.6080208@redhat.com>
References: <443F90CB.6080208@redhat.com>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 13:56:56 -0400
Message-Id: <1145296616.19561.0.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2006-04-14 at 08:08 -0400, Daniel J Walsh wrote:
> This is a combination of a patch from Russell and Me.
> 
> Comments added to explain MCS constraint decisions
> 
> Fixes for amanda to run as tcp
> 
> bootloader needs to read SystemHigh
> 
> make system-install-packages run as rpm
> 
> Changes to make stem compression algorithm work better.  Also some 
> changes to file_context to fix sort problems.  Mainly make sure 
> textrel_shlib_t always comes after shlib_t definition.
> 
> Allow usermanage to create staff user accounts
> 
> defind java as a entry_point
> 
> allow mono and unconfined_t to dbus_chat with programs running as 
> initrc_t/network_manager
> 
> Fixes to allow xen to work.
> 
> mailman interaction with postfix
> 
> Fix nfs booleans to actually work
> 
> fix samba to be able to create directories in users home dirs.
> 
> fix samba to work on nfs...
> 
> Allow usermanage to create the homedir

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
