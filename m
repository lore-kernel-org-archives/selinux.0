Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4GIN4E4003914
	for <selinux@tycho.nsa.gov>; Wed, 16 May 2012 14:23:04 -0400
Date: Wed, 16 May 2012 18:25:21 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] test_file: fix policy to allow
 building with relro
Message-ID: <20120516182521.GA20664@mail.hallyn.com>
References: <20120515095158.GA27306@dustball.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120515095158.GA27306@dustball.brq.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Jan Stancek (jstancek@redhat.com):
> glibc can apply extra memory protection to certain areas
> (data sections) when using partial or full RELRO,
> marking them as read-only using mprotect.
> 
> This works fine for majority of tests, whose executables
> are labelled as test_file_t because of:
>     miscfiles_read_test_files(testdomain)
> in test_global.te.
> 
> But it fails for test_sigiotask as some distributions
> are using relro as default now.
> 
> To reproduce build wait_io with relro:
> cc wait_io.c  -lselinux -lutil -o wait_io -Wl,-z,relro
> 
> wait_io executable is labelled with fileop_exec_t,
> so when glibc tries to apply memory protection while
> wait_io process runs in fileop_t it fails:
> 
> audit.log:
> type=AVC msg=audit(1336995324.461:1264): avc:  denied  { read } for
> pid=3335 comm="wait_io" path="/mnt/tests/kernel/distribution/
> selinux-testsuite/selinux-testsuite-20120120/tests/file/wait_io"
> dev="dm-1" ino=1049099
> scontext=unconfined_u:unconfined_r:fileop_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:fileop_exec_t:s0 tclass=file
> 
> strace:
> ...
> [pid  3335] arch_prctl(ARCH_SET_FS, 0x7f53aee85800) = 0
> [pid  3335] mprotect(0x7f53aec6b000, 16384, PROT_READ) = 0
> [pid  3335] mprotect(0x7f53ae8bd000, 4096, PROT_READ) = 0
> [pid  3335] mprotect(0x373ba1d000, 4096, PROT_READ) = 0
> [pid  3335] mprotect(0x600000, 4096, PROT_READ) = -1 EACCES (Permission
> denied)
> [pid  3335] writev(2, [{"wait_io", 7}, {": ", 2}, {"error while loading
> shared libra"..., 36}, {": ", 2}, {"", 0}, {"", 0}, {"cannot apply
> additional memory p"..., 58}, {": ", 2}, {"Permission denied", 17},
> {"\n", 1}], 10wait_io: error while loading shared libraries: cannot
> apply additional memory protection after relocation: Permission denied
> ) = 125
> 
> Fix this by allowing fileop_t read permissions on fileop_exec_t.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Thanks, Jan.  Applied.

> ---
>  policy/redhat/5/test_file.te |    1 +
>  policy/test_file.te          |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/redhat/5/test_file.te b/policy/redhat/5/test_file.te
> index 698626f..4196b1e 100644
> --- a/policy/redhat/5/test_file.te
> +++ b/policy/redhat/5/test_file.te
> @@ -38,6 +38,7 @@ type fileop_t;
>  domain_type(fileop_t)
>  typeattribute fileop_t fileopdomain;
>  typeattribute fileop_t testdomain;
> +read_files_pattern(fileop_t, fileop_exec_t, fileop_exec_t)
>  
>  # Type for a temp file that the bad domain has read/write/append
>  type nofileop_rw_file_t;
> diff --git a/policy/test_file.te b/policy/test_file.te
> index 0d4525d..eb93a49 100644
> --- a/policy/test_file.te
> +++ b/policy/test_file.te
> @@ -41,6 +41,7 @@ domain_type(fileop_t)
>  unconfined_runs_test(fileop_t)
>  typeattribute fileop_t fileopdomain;
>  typeattribute fileop_t testdomain;
> +read_files_pattern(fileop_t, fileop_exec_t, fileop_exec_t)
>  
>  # Type for a temp file that the bad domain has read/write/append
>  type nofileop_rw_file_t;
> -- 
> 1.7.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
