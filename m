Message-ID: <1502117108.4300.7.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 07 Aug 2017 10:45:08 -0400
In-Reply-To: <20170805101649.4931-2-nicolas.iooss@m4x.org>
References: <20170805101649.4931-1-nicolas.iooss@m4x.org>
 <20170805101649.4931-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/2] Travis-CI: do not test gold linkers with clang
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-08-05 at 12:16 +0200, Nicolas Iooss wrote:
> clang does not know -fuse-ld=gold. It only needs -flto, which
> automatically adds -plugin=LLVMgold.so to the linker command line,
> but
> this does not work on Travis-CI because the gold linker plugin is not
> installed:
> 
>     /usr/bin/ld: /usr/local/clang-3.9.0/bin/../lib/LLVMgold.so: error
>     loading plugin: /usr/local/clang-3.9.0/bin/../lib/LLVMgold.so:
>     cannot open shared object file: No such file or directory
> 
> Disable in the build matrix the combination of linking with special
> linkers with using clang.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied both patches.

> ---
>  .travis.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 27c0013d6e9e..1b761496dd12 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -29,6 +29,13 @@ env:
>      - PYVER=python3.6 RUBYLIBVER=2.2
>      - PYVER=python3.6 RUBYLIBVER=2.3
>  
> +matrix:
> +  exclude:
> +    - compiler: clang
> +      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
> +    - compiler: clang
> +      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
> +
>  # Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image"
> variant
>  sudo: required
>  dist: trusty
