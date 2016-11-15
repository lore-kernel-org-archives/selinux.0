Subject: Re: [PATCH 2/2] libselinux, libsemanage: swig: use SWIG_fail when an
 error occurs
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161114215712.18962-1-nicolas.iooss@m4x.org>
 <20161114215712.18962-2-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <031334ad-00f1-6834-2808-a2a708a88ef3@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 11:14:48 -0500
MIME-Version: 1.0
In-Reply-To: <20161114215712.18962-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2016 04:57 PM, Nicolas Iooss wrote:
> Using SWIG_fail in the Python SWIG wrappers makes the wrapping function
> destroy/free the memory which could have been dynamically allocated
> before calling the wrapped function. This thus prevents possible memory
> leaks in the wrappers of set*con(), set*con_raw(), security_compute_*(),
> etc.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied both patches.

> ---
>  libselinux/src/exception.sh  | 2 +-
>  libsemanage/src/exception.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index a3ff83235ced..d6c8c71713ad 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -8,7 +8,7 @@ echo "
>    \$action 
>    if (result < 0) {
>       PyErr_SetFromErrno(PyExc_OSError);
> -     return NULL;
> +     SWIG_fail;
>    }
>  }
>  "
> diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
> index a4095f4f8ba6..97bc2ae879f2 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -4,7 +4,7 @@ echo "
>    \$action
>    if (result < 0) {
>       PyErr_SetFromErrno(PyExc_OSError);
> -     return NULL;
> +     SWIG_fail;
>    }
>  }
>  "
> 
