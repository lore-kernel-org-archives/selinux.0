Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q93EXWYN001620
	for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2012 10:33:32 -0400
Date: Wed, 3 Oct 2012 14:34:53 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] test_ptrace: fix policy to allow
 building with relro
Message-ID: <20121003143453.GA5612@mail.hallyn.com>
References: <0c7cd53d9b8658623c10d712f8d0f67b86524cf1.1349084369.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0c7cd53d9b8658623c10d712f8d0f67b86524cf1.1349084369.git.jstancek@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jan Stancek (jstancek@redhat.com):
> glibc can apply extra memory protection to certain areas
> (data sections) when using partial or full RELRO,
> marking them as read-only using mprotect.
> 
> If perl (or some bin_t utility in general) is built with
> RELRO, ptrace test fails to execute 'wait', because of lack
> of read permissions on /usr/bin/perl.
> 
> read_files_pattern or can_exec should suffice here, but
> let's match other testcases and allow to execute all helper
> programs in general.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

thanks, applied.

> ---
>  policy/redhat/5/test_ptrace.te |    9 +++++++++
>  policy/test_ptrace.te          |    9 +++++++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/redhat/5/test_ptrace.te b/policy/redhat/5/test_ptrace.te
> index 50e96fe..b514312 100644
> --- a/policy/redhat/5/test_ptrace.te
> +++ b/policy/redhat/5/test_ptrace.te
> @@ -36,3 +36,12 @@ allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
>  # via a program in the test directory.
>  miscfiles_domain_entry_test_files(ptracedomain)
>  userdom_sysadm_entry_spec_domtrans_to(ptracedomain)
> +
> +# Allow execution of helper programs.
> +corecmd_exec_bin(ptracedomain)
> +domain_exec_all_entry_files(ptracedomain)
> +files_exec_etc_files(ptracedomain)
> +libs_use_ld_so(ptracedomain)
> +libs_use_shared_libs(ptracedomain)
> +libs_exec_ld_so(ptracedomain)
> +libs_exec_lib_files(ptracedomain)
> diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
> index 41d474b..0ab9579 100644
> --- a/policy/test_ptrace.te
> +++ b/policy/test_ptrace.te
> @@ -39,3 +39,12 @@ allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
>  # via a program in the test directory.
>  miscfiles_domain_entry_test_files(ptracedomain)
>  userdom_sysadm_entry_spec_domtrans_to(ptracedomain)
> +
> +# Allow execution of helper programs.
> +corecmd_exec_bin(ptracedomain)
> +domain_exec_all_entry_files(ptracedomain)
> +files_exec_etc_files(ptracedomain)
> +libs_use_ld_so(ptracedomain)
> +libs_use_shared_libs(ptracedomain)
> +libs_exec_ld_so(ptracedomain)
> +libs_exec_lib_files(ptracedomain)
> -- 
> 1.7.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
