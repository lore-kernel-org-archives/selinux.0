Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KJ8YrT006476
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 15:08:35 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KJ8XQ4007613
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 19:08:33 GMT
Subject: Re: policy patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408192257.15688.russell@coker.com.au>
References: <200408192257.15688.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093028836.16585.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 15:07:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-19 at 08:57, Russell Coker wrote:
> diff1 makes the Makefile use M4PARAM for the file_contexts.
> 
> It makes a trivial change to fsadm_t access which satisfies some of the 
> assertions I test with (no difference in production).
> 
> Removes devpts access from getty_t (it has no business doing such things, any 
> time it tries to do so is a bug somewhere).
> 
> Makes a change to initrc_t needed for cryptsetup on Debian (unsure whether 
> cryptsetup on Fedora will work the same way, it's quite likely - I think it's 
> best if we copy the Debian cryptsetup stuff into Fedora).
> 
> Also it removes boot_t:lnk_file access from klogd_t, on Fedora the only 
> boot_t:lnk_file is the GRUB menu.lst file (which klogd does not need access 
> to), on Debian there are also some sym-links for LILO (which are in the same 
> category).
> 
> 
> diff makes some minor changes to the passwd policy to work with different 
> editors for vipw and different versions of chfn.
> 
> Allows acct_t to execute logrotate.
> 
> Works with the latest version of amavis. 
> 
> Fixes the apmd policy to work with the device_type changes and some 
> functionality that is commonly called from apm scripts.
> 
> Changes the capabilities in bluetooth.te to be in the same order as the header 
> file.
> 
> Updates the calamaris policy to work with the latest version.

Merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
