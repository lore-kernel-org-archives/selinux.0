Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DGKmrT003910
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 12:20:48 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DGJrHC019833
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 16:19:53 GMT
Subject: Re: process:share condition on 2.6.x kernel
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
In-Reply-To: <02eb01c49953$84344590$f97d220a@linux.bs1.fc.nec.co.jp>
References: <02eb01c49953$84344590$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Message-Id: <1095092319.22460.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 12:18:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-09-13 at 01:35, Kaigai Kohei wrote:
> The 'share' condition is checked in selinux_bprm_apply_creds() as
> an extension of execve() system call when the domain-transration
> is happened and LSM_UNSAFE_SHARE bit in the 'unsafe' variable is set.
> 
> Obviously, the domain-transition can happen according to the security-policy.
> But LSM_UNSAFE_SHARE bit is never set in 2.6.x, thus the 'share' condition
> is never evaluated, namely always ignored.
> 
> In 2.6.x implementation, de_thread() function is called from load_binary()
> method of the ELF,aout and so on when execve() is called.
> When the current process contains some threads, de_thread() kills all
> the threads except 'current' in the same threads-group.
> Then, compute_creds() function is called for the calculation of
> LSM_UNSAFE_SHARE. But the current process has already only a thread,
> so LSM_UNSAFE_SHARE is always unset.
> The 'share' condition is ignored in 2.6.x in the result.
> 
> I think the 'share' condition is one of the historical inheritances
> and harmless, so this condition should be documented as it's a deprecated
> condition.
> Is my understanding correct?

No.  They can share state without being part of the same thread group,
e.g. trying calling clone(2) with CLONE_FS and then exec'ing a
domain-changing program.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
