Message-ID: <54006D79.1050409@tycho.nsa.gov>
Date: Fri, 29 Aug 2014 08:09:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
 selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] file: replace 'ls -Z' with 'ls -lZ' for consistent results
References: <20140828204738.10801.34505.stgit@localhost>
In-Reply-To: <20140828204738.10801.34505.stgit@localhost>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/28/2014 04:47 PM, Paul Moore wrote:
> I'm not sure the exact date of the change, but 'ls -Z' on Rawhide is
> a bit different than in the past; the output now looks like this:
> 
>   # /bin/ls -Z test
>   system_u:object_r:test_file_t:s0 test

That seems very wrong - who knows how many userspace scripts may rely on
the output of ls -Z having a given format?   Is this a change in
upstream coreutils or Fedora-specific?

> 
> This patch converts the testsuite to use 'ls -lZ' which appears to be
> consistent.
> 
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  tests/file/test |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/file/test b/tests/file/test
> index e6ed44d..1c8485a 100755
> --- a/tests/file/test
> +++ b/tests/file/test
> @@ -45,9 +45,9 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > /dev/null";
>  #
>  # Get the SID of the good file.
>  #
> -$output = `ls -Z $basedir/temp_file`;
> +$output = `ls -lZ $basedir/temp_file`;
>  @arr = split(' ', $output);
> -$good_file_sid = $arr[3];
> +$good_file_sid = $arr[4];
>  
>  #
>  # Attempt to access a restricted file as the 'good' domain.  The first test
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
