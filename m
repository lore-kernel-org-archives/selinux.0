Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CDSWrT001840
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:28:32 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CDSBDC005787
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:28:11 GMT
Subject: Re: init.te
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111745.51356.russell@coker.com.au>
References: <200407111745.51356.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089638904.22449.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 09:28:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 03:45, Russell Coker wrote:
> There should never be a sock_file or fifo_file object labelled as sbin_t or 
> bin_t, so there is no benefit in granting init_t such access.
> 
> I can't think of any reason for granting init_t access to exec_type (except 
> possibly a gross error in some other part of policy), and booting a rawhide 
> machine without such access does not give any audit messages.
> 
> I have drastically reduced the access of init_t to sbin_t, bin_t, and removed 
> access to exec_type, the patch is attached.
> 
> Steve, please put this in the CVS.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
