Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8DJgSAW026814
 for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2016 15:42:28 -0400
Received: by mail-oi0-f66.google.com with SMTP id 2so28058324oif.2
 for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2016 12:42:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1473793078-14237-1-git-send-email-sds@tycho.nsa.gov>
References: <1473793078-14237-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Sep 2016 15:42:25 -0400
Message-ID: <CAHC9VhQeR9OVMDgusu-XrjiVObxiNBOARxy4-0PG6pAnh3ZBpw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix file/test failure
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 13, 2016 at 2:57 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 4.8-rc5, Paul Moore reported the following test failure:
>
> file/test ............... 8/16 # Test 8 got: "256" (file/test at line 85)
> file/test ............... Failed 1/16 subtests
>
> ... this happens to be the SIGIO/good test.  Running the test by hand
> yields the following AVC:
>
> type=AVC msg=audit(1473785577.548:448): avc:  denied  { execute } for
>  pid=2336 comm="wait_io"
>  path="/root/sources/selinux-testsuite/tests/file/wait_io"
>  dev="sda3" ino=399656
>  scontext=unconfined_u:unconfined_r:fileop_t:s0-s0:c0.c1023
>  tcontext=system_u:object_r:fileop_exec_t:s0
>  tclass=file permissive=0
>
> commit 9f834ec18defc369d73ccf9e87a2790bfa05bf46 ("binfmt_elf: switch to new
> creds when switching to new mm") moved the switching of credentials before
> mapping the executable, and therefore triggers a file execute check between
> the new domain and the executable type on domain transitions.
>
> Switch the test policy to use domain_entry_file() rather than a
> handcoded allow rule, thereby allowing both permissions.
>
> Reported-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/test_file.te | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Great, thanks for fixing that while I was at lunch :)

I can confirm that this fixes the problem.

> diff --git a/policy/test_file.te b/policy/test_file.te
> index eb93a49..24c8b16 100644
> --- a/policy/test_file.te
> +++ b/policy/test_file.te
> @@ -66,7 +66,7 @@ userdom_sysadm_entry_spec_domtrans_to(fileopdomain)
>  corecmd_bin_entry_type(fileopdomain)
>  sysadm_bin_spec_domtrans_to(fileopdomain)
>
> -allow fileop_t fileop_exec_t:file entrypoint;
> +domain_entry_file(fileop_t, fileop_exec_t)
>  domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
>  allow test_fileop_t fileop_t:fd use;
>  allow fileop_t test_fileop_t:fd use;
> --
> 2.7.4

-- 
paul moore
www.paul-moore.com
