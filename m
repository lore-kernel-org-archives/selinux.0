Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DKKorT005831
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 16:20:50 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DKJsHC007735
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 20:19:55 GMT
Subject: Re: policy patch against latest CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409111954.15823.russell@coker.com.au>
References: <200409111954.15823.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095106801.2161.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 16:20:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sat, 2004-09-11 at 05:54, Russell Coker wrote:
> The attached patch adds the dev_fs attribute in a few places where it was 
> missed before and uses the dev_fs attribute for tmpfs_t:filesystem associate.
> 
> It puts all the tmpfs /dev stuff inside distro_redhat because currently no 
> other distribution seems to be even considering doing this sort of thing (the 
> feeling within the Gentoo camp appears to be strongly against it).  We could 
> just as easily have a tmpfs_dev tunable for the same thing.
> 
> This patch removes one instance of ifdef(`devfsd.te'.  We should probably 
> remove all the devfsd stuff and delete devfsd.te and devfsd.fc as I don't 
> think we will ever support devfs again.
> 
> Removed some unneeded rules from the dovecot policy, someone added some 
> supposedly Debian specific stuff which isn't needed for Debian, and we have a 
> different type for certificates.
> 
> Trivial change to ipsec.te.
> 
> As previously discussed this patch removes a redundant allow rule from 
> named.te.
> 
> lvm.fc is updated to the latest file location that is (AFAIK) used by everyone 
> now).
> 
> Removed some redundant rules from user_macros.te.
> 
> 
> I believe that this is all worthy of inclusion in the CVS.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
