Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GLEdRb012520
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 16:14:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0GLDTxr025070
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 21:13:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0GLDTYc025067
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 21:13:29 GMT
Subject: Re: Trival relabel Problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas DuBuisson <dubu0874@uidaho.edu>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.56.0401161244200.29958@cyclone.csrv.uidaho.edu>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
	 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1074271807.23661.119.camel@colossus.columbia.tresys.com>
	 <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.GSO.4.56.0401161244200.29958@cyclone.csrv.uidaho.edu>
Content-Type: text/plain
Message-Id: <1074287677.24719.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 16:14:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-16 at 16:03, Thomas DuBuisson wrote:
> I looked at the other relabel threads, they didn't seem to address my
> issue.  But if I missed something, sorry if this is a repeat.  I am fairly
> certain this is trivial but I am lost.
> 
> My problem:
> -----------------------
> root@blacktower:/etc/security/selinux/src/policy# execcon \
> root:sysadm_r:sysadm_t make relabel
> 
> /usr/sbin/setfiles:  read 425 specifications
> /usr/sbin/setfiles:  labeling files under /
> /: Operation not supported
> /usr/sbin/setfiles:  unable to obtain attribute for file /
> /usr/sbin/setfiles:  error while labeling files under /
> ----------------------------------------------------
> 
> My setup
> -----------------------------------
> Enforcing: 0
> Base System: Slackware 9.1
> Kernel: 2.6.1-mm2
> FS: reiserfs (I did edit the Makefile changing ext[23])
> PAM.77
> selinux-usr: 1.4
> ----------------------------------
> 
> So, any pointers on how to get this fs labeled?  What am I missing?

reiserfs doesn't support extended attributes unless you patch in
support, e.g. using Jeff Mahoney's patches from
ftp://ftp.suse.com/pub/people/jeffm/reiserfs/aclea/.  Hans has
previously indicated that he won't add new features to reiser3, so he
won't accept those patches into the mainline reiserfs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
