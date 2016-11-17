Subject: Re: [PATCH 1/1] sandbox: make test not fail on systems without SELinux
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161117212006.20697-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8ff6e9d9-16db-70a1-884e-494ecb3739fe@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 16:45:13 -0500
MIME-Version: 1.0
In-Reply-To: <20161117212006.20697-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 04:20 PM, Nicolas Iooss wrote:
> On systems without SELinux (eg. some continuous integration
> environments), "make test" fails with:
> 
>     Traceback (most recent call last):
>       File "test_sandbox.py", line 110, in <module>
>         if selinux.security_getenforce() == 1:
>     FileNotFoundError: [Errno 2] No such file or directory
> 
> This is exception is thrown because the selinuxfs file system is not
> mounted.
> 
> Detect such configurations using selinux.is_selinux_enabled() and skip
> the test when SELinux is disabled accordingly.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied

> ---
>  sandbox/test_sandbox.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sandbox/test_sandbox.py b/sandbox/test_sandbox.py
> index bcecf66ee257..ba849a08141d 100644
> --- a/sandbox/test_sandbox.py
> +++ b/sandbox/test_sandbox.py
> @@ -107,7 +107,7 @@ class SandboxTests(unittest.TestCase):
>  
>  if __name__ == "__main__":
>      import selinux
> -    if selinux.security_getenforce() == 1:
> +    if selinux.is_selinux_enabled() and selinux.security_getenforce() == 1:
>          unittest.main()
>      else:
>          print("SELinux must be in enforcing mode for this test")
> 
