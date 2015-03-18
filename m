Message-ID: <550971B7.9080807@tycho.nsa.gov>
Date: Wed, 18 Mar 2015 08:38:15 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsemanage: fix fname[] initialization in
 test_utilities.c
References: <1426501987-12646-1-git-send-email-plautrba@redhat.com>
In-Reply-To: <1426501987-12646-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/16/2015 06:33 AM, Petr Lautrbach wrote:
> There's no guaranty that last item in "char fname[]" will be a null character.
> Fixes segfault on some systems:
> 
>   Test: semanage_nc_sort ...passedtest_semanage_findval: : Invalid argument
> libsemanage-tests: TestRun.c:160: CU_assertImplementation: Assertion `((void *)0) != f_pCurTest' failed.
> make[1]: *** [test] Aborted (core dumped)
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsemanage/tests/test_utilities.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
> index 4d25b07..32cc33c 100644
> --- a/libsemanage/tests/test_utilities.c
> +++ b/libsemanage/tests/test_utilities.c
> @@ -45,7 +45,7 @@ void test_slurp_file_filter(void);
>  
>  char fname[] = {
>  	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
> -	'X', 'X'
> +	'X', 'X', '\0'
>  };
>  int fd;
>  FILE *fptr;
> 

Thanks, applied.
