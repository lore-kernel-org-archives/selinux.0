Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CDVBrT001882
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 09:31:11 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CDVAPJ009387
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 13:31:10 GMT
Subject: Re: policy patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111759.34090.russell@coker.com.au>
References: <200407111759.34090.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089639046.22449.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 09:30:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 03:59, Russell Coker wrote:
> file_type_auto_trans(sysadm_t, user_home_dir_t, user_home_t)
> 
> I remove the above from domains/admin.te because it's granted to privhome by 
> macros/user_macros.te and sysadm_t has the privhome attribute.
> 
> checkpolicy_t should not be creating lnk_file, sock_file, or fifo_file objects 
> of type policy_config_t, and if there are sock_file or fifo_file objects of 
> type policy_src_t then it should not be reading them.
> 
> system_crond_t should not be trying to access device nodes of types that are 
> for files.
> 
> I still don't think that dmesg_t is appropriate for running dmesg from the 
> administrator shell.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
