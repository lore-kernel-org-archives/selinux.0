Message-ID: <1496153967.2164.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] semanage: Fix manpage author for ibpkey and
 ibendport pages.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Tue, 30 May 2017 10:19:27 -0400
In-Reply-To: <1496150801-99207-1-git-send-email-danielj@mellanox.com>
References: <1496150801-99207-1-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-05-30 at 16:26 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

Thanks, applied.

> ---
>  python/semanage/semanage-ibendport.8 | 2 +-
>  python/semanage/semanage-ibpkey.8    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/semanage/semanage-ibendport.8
> b/python/semanage/semanage-ibendport.8
> index c3753a27..0a29eae1 100644
> --- a/python/semanage/semanage-ibendport.8
> +++ b/python/semanage/semanage-ibendport.8
> @@ -63,4 +63,4 @@ Label mlx4_0 port 2.
>  .BR semanage (8)
>  
>  .SH "AUTHOR"
> -This man page was written by Daniel Walsh <dwalsh@redhat.com>
> +This man page was written by Daniel Jurgens <danielj@mellanox.com>
> diff --git a/python/semanage/semanage-ibpkey.8
> b/python/semanage/semanage-ibpkey.8
> index 2da4f546..51f455ab 100644
> --- a/python/semanage/semanage-ibpkey.8
> +++ b/python/semanage/semanage-ibpkey.8
> @@ -63,4 +63,4 @@ Label pkey 0x8FFF (limited membership default pkey)
> as a default pkey type
>  .BR semanage (8)
>  
>  .SH "AUTHOR"
> -This man page was written by Daniel Walsh <dwalsh@redhat.com>
> +This man page was written by Daniel Jurgens <danielj@mellanox.com>
