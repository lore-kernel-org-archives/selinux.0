Message-ID: <1484689748.20454.27.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] semanage, sepolicy: make tests not fail on systems
 without SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 17 Jan 2017 16:49:08 -0500
In-Reply-To: <20170114144024.4709-1-nicolas.iooss@m4x.org>
References: <20170114144024.4709-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-01-14 at 15:40 +0100, Nicolas Iooss wrote:
> selinux.security_getenforce() triggers an exception when running
> tests
> on systems without SELinux. In order to skip tests which need SELinux
> in
> enforcing mode, test selinux.is_selinux_enabled() too, like commit
> 945bc8853b62 ("sandbox: make test not fail on systems without
> SELinux").

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  python/semanage/test-semanage.py | 2 +-
>  python/sepolicy/test_sepolicy.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/semanage/test-semanage.py b/python/semanage/test-
> semanage.py
> index 12ffc98afd6e..c8f6ec231fc2 100644
> --- a/python/semanage/test-semanage.py
> +++ b/python/semanage/test-semanage.py
> @@ -276,7 +276,7 @@ def gen_semanage_test_args(parser):
>  if __name__ == "__main__":
>      import selinux
>      semanage_test_list = [x for x in dir(SemanageTests) if
> x.startswith("test_")]
> -    if selinux.security_getenforce() == 1:
> +    if selinux.is_selinux_enabled() and
> selinux.security_getenforce() == 1:
>          parser = argparse.ArgumentParser(description='Semanage unit
> test script')
>          gen_semanage_test_args(parser)
>          try:
> diff --git a/python/sepolicy/test_sepolicy.py
> b/python/sepolicy/test_sepolicy.py
> index 61dfb4550830..304e56f60a7c 100644
> --- a/python/sepolicy/test_sepolicy.py
> +++ b/python/sepolicy/test_sepolicy.py
> @@ -115,7 +115,7 @@ class SepolicyTests(unittest.TestCase):
>  
>  if __name__ == "__main__":
>      import selinux
> -    if selinux.security_getenforce() == 1:
> +    if selinux.is_selinux_enabled() and
> selinux.security_getenforce() == 1:
>          unittest.main()
>      else:
>          print("SELinux must be in enforcing mode for this test")
