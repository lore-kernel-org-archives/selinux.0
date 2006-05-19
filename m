Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JE2rGp005478
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:02:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JE2qfP013016
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:02:52 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446C9926.5070802@redhat.com>
References: <446C9926.5070802@redhat.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:04:53 -0400
Message-Id: <1148047494.31984.56.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-18 at 11:56 -0400, Daniel J Walsh wrote:
> Add boolean allow_nfsd_anon_write to it can write to public_content_rw_t
> 
> Stop transition to consoletype from initrc_t.  Maybe we need an 
> ifdef(targeted_policy)  But hostname and consoletype transitioning is a 
> pain in the but.  Lots of init scripts do stuff like

This is just like hostname, w.r.t. sys_admin capability, and us not
wanting to give that to initrc_t.

> consoletype >> MYLOG.log
> 
> prelink needs to be able to change the context even if the user part is 
> different.
> 
> Added unconfined_execmem_exec_t so that I can change the global 
> allow_execmem to off.  OpenOffice, valgrind and mplayer need it.  
> Probably could eliminate java, and wine domain and change to this.

I think this would be better if we had this transparently integrated
into the unconfined policy.  So we just add the rules to unconfined.te,
and put the domain transition into unconfined_domtrans().  The
differences between the two domains is just the execmem, so it should be
ok.  In fact this might be a simple example of hierarchy.

> Additinional dontaudit for ioctl on terminals
> 
> Fixes for amavis domain
> 
> named needs access to ldap when running with nss_ldap  (Seems lots of 
> domains need this if you set up nss_ldap.)
> 
> Allow bluetooth helper access to users homedir and tmp files.
> 
> cupsd_lpd_t wants to look at the routing table and communicate with the 
> cupsd socket
> 
> Want to label cvs and rsync as being executables so sysadm_r can run 
> them.  (No transition).

Should already be executable by being entrypoints for their respective
domains.

> Hal wants to look at the kernel image file
> 
> nfs needs access to rand/urand probably caused by nss_ldap.
> 
> xfs wants to execute itself if it has greater than 10 displays.
> 
> xdm is creating .Xauthority file with wrong context.
> 
> auditadm_r which is running as SystemHigh wants to be able to restart 
> auditd through init scripts.  So it needs to be able to 
> mls_range_transition run_init down to SystemLow-SystemHigh
> 
> Major bug in that we were not running semanage and setsebool as 
> semanage_t.  This is what is causing the mislabeled 
> /etc/selinux/targeted/modules directory
> 
> semanage_t needed fixes so that setsebool and semanage could run.
> 
> More fixes for xen domain.
> 
> auditadm_ stuff, but I agree that this is still in flux so don't add it.

The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
