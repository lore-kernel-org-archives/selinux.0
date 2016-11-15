Subject: Re: [PATCH 1/1] libsemanage: use a macro prefixed with SEMANAGE to
 protect dso.h
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161115221523.17519-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <59782110-9a3e-d418-1fb3-62178e641b90@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 17:29:21 -0500
MIME-Version: 1.0
In-Reply-To: <20161115221523.17519-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/15/2016 05:15 PM, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied

> ---
>  libsemanage/src/dso.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/dso.h b/libsemanage/src/dso.h
> index 5c69aaef0090..8c9a0140871f 100644
> --- a/libsemanage/src/dso.h
> +++ b/libsemanage/src/dso.h
> @@ -1,5 +1,5 @@
> -#ifndef _SEPOL_DSO_H
> -#define _SEPOL_DSO_H	1
> +#ifndef _SEMANAGE_DSO_H
> +#define _SEMANAGE_DSO_H	1
>  
>  #ifdef SHARED
>  # define hidden __attribute__ ((visibility ("hidden")))
> 
