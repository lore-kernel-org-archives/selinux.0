Subject: Re: [patch] selinux-testsuite:  extend unconfined_runs_test
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1201116050.7025.303.camel@moss-spartans.epoch.ncsc.mil>
References: <1201116050.7025.303.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 31 Jan 2008 13:10:40 +0530
Message-Id: <1201765240.4500.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is through. Thanks.

--Subrata

> Extend the unconfined_runs_test interface in the selinux testsuite
> policy to allow the test programs to properly report back to the caller.
> This is required to enable many of the tests to pass on Fedora 8 and
> later.  Remaining FAIL cases are fdreceive and inherit (due to Fedora 8
> policy granting fd:use permission globally for all domains) and
> task_create (due to refpolicy automatically granting it to all domain
> types).
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> ---
> 
> Index: testcases/kernel/security/selinux-testsuite/misc/sbin_deprecated.patch
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/misc/sbin_deprecated.patch,v
> retrieving revision 1.1
> diff -u -r1.1 sbin_deprecated.patch
> --- testcases/kernel/security/selinux-testsuite/misc/sbin_deprecated.patch	2 Jan 2008 11:58:15 -0000	1.1
> +++ testcases/kernel/security/selinux-testsuite/misc/sbin_deprecated.patch	23 Jan 2008 19:11:05 -0000
> @@ -556,7 +556,7 @@
>  diff -Nrup refpolicy/test_policy.if refpolicy.new/test_policy.if
>  --- refpolicy/test_policy.if	2007-12-31 06:57:36.000000000 -0500
>  +++ refpolicy.new/test_policy.if	2007-12-31 06:05:59.000000000 -0500
> -@@ -25,3 +25,11 @@
> +@@ -25,3 +25,17 @@
>   ##      Domain allowed to transition.
>   ## </param>
>   #
> @@ -564,9 +564,15 @@
>  +interface(`unconfined_runs_test',`
>  +	gen_require(`
>  +		type unconfined_t;
> ++		type unconfined_devpts_t;
>  +	')
>  +
> ++	# Transition from the caller to the test domain.
>  +	allow unconfined_t $1:process transition;
> ++	# Report back from the test domain to the caller.
> ++	allow $1 unconfined_t:fd use;
> ++	allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
> ++	allow $1 unconfined_t:fifo_file { read write ioctl getattr };
>  +')
>  diff -Nrup refpolicy/test_ptrace.te refpolicy.new/test_ptrace.te
>  --- refpolicy/test_ptrace.te	2007-12-31 06:57:36.000000000 -0500
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
