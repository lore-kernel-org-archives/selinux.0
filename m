Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8D5ZVrT000769
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 01:35:34 -0400 (EDT)
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8D5YZHC023484
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 05:34:36 GMT
Received: from mailgate3.nec.co.jp (mailgate53.nec.co.jp [10.7.69.162] (may be forged))
	by tyo202.gate.nec.co.jp (8.11.7/3.7W01080315) with ESMTP id i8D5ZQ217069
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 14:35:26 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id i8D5ZPu12947 for selinux@tycho.nsa.gov; Mon, 13 Sep 2004 14:35:25 +0900 (JST)
Received: from mailsv.bs1.fc.nec.co.jp (venus.hpc.bs1.fc.nec.co.jp [10.34.77.164]) by mailsv3.nec.co.jp (8.11.7/3.7W-MAILSV4-NEC) with ESMTP
	id i8D5ZLW20557 for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 14:35:21 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (IDENT:postfix@namesv2.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv.bs1.fc.nec.co.jp (8.12.10/3.7W-HPC5.2F(mailsv)04081615) with ESMTP id i8D5biYV023941
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 14:37:46 +0900 (JST)
Received: from sanma (sanma.linux.bs1.fc.nec.co.jp [10.34.125.249])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with SMTP id B004130981
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 14:35:18 +0900 (JST)
Message-ID: <02eb01c49953$84344590$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: process:share condition on 2.6.x kernel
Date: Mon, 13 Sep 2004 14:35:45 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, all.

I noticed that the condition of 'process:share' is never checked in 2.6.x kernel.
Is it expected, or unexpected ?

Stephen D. Smalley wrote about the condition of 'share' in 23/Jan/2003.
See, http://www.nsa.gov/selinux/list-archive/0301/3782.cfm

>> Is there a short answer of what process "share" permission controls? 
>> Nothing obvious in any reports. Thanks Frank 
>
> It is mentioned in the module technical report. It is checked when
> a process SID would change (due to an execve or execve_secure) and
> the process shares state with its parent due to the prior use of
> clone(2) to create the process. See the man page for clone for
> detailed information about what can be shared. 

The 'share' condition is checked in selinux_bprm_apply_creds() as
an extension of execve() system call when the domain-transration
is happened and LSM_UNSAFE_SHARE bit in the 'unsafe' variable is set.

Obviously, the domain-transition can happen according to the security-policy.
But LSM_UNSAFE_SHARE bit is never set in 2.6.x, thus the 'share' condition
is never evaluated, namely always ignored.

In 2.6.x implementation, de_thread() function is called from load_binary()
method of the ELF,aout and so on when execve() is called.
When the current process contains some threads, de_thread() kills all
the threads except 'current' in the same threads-group.
Then, compute_creds() function is called for the calculation of
LSM_UNSAFE_SHARE. But the current process has already only a thread,
so LSM_UNSAFE_SHARE is always unset.
The 'share' condition is ignored in 2.6.x in the result.

I think the 'share' condition is one of the historical inheritances
and harmless, so this condition should be documented as it's a deprecated
condition.
Is my understanding correct?

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
