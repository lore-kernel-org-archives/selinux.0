Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LDaNWt026598
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 09:36:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LDaAIS021907
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:36:10 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9LDaADc021902
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:36:10 GMT
Subject: Re: chcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310212327.05821.russell@coker.com.au>
References: <200310212327.05821.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066743378.27065.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 09:36:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 09:27, Russell Coker wrote:
> Steve, chcon needs access to /selinux/context, is there any problem in putting 
> in a macro such as the following and using it for all user domains?
> 
> define(`can_check_context', `
> allow $1 security_t:dir search;
> allow $1 security_t:file { read write };
> allow $1 security_t:security { check_context };
> ')

This is a recent change to chcon in Dan's SRPM; doesn't exist in the
coreutil-selinux patch from the last release. It isn't truly necessary,
as the context will be checked when it is passed to the kernel via
setfilecon and that call will fail if the context is invalid, so it is
only useful if there is some benefit to catching such errors earlier.

Even if it is worth retaining in chcon, I would suggest distinguishing
between an errno of ENOENT and an errno of EINVAL, as the former may
just indicate that selinuxfs wasn't mounted or the kernel was a
non-SELinux kernel (but could still have the xattr handlers), and
letting the chcon proceed in the former case.  Otherwise, you won't be
able to use chcon if selinuxfs is unmounted or using a non-SELinux
kernel that has the xattr handlers.  I should likely make the same
change to setfiles.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
