Message-ID: <1501247194.32334.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Guy Briggs <rgb@redhat.com>, SElinux list <selinux@tycho.nsa.gov>,
 linux-audit@redhat.com
Cc: Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@redhat.com>
Date: Fri, 28 Jul 2017 09:06:34 -0400
In-Reply-To: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
References: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: remove AVC init audit log message
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-07-28 at 03:23 -0400, Richard Guy Briggs wrote:
> In the process of normalizing audit log messages, it was noticed that
> the AVC
> initialization code registered an audit log KERNEL record that didn't
> fit the
> standard format.  In the process of attempting to normalize it it was
> determined that this record was not even necessary.  Remove it.
> 
> Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
> See: https://github.com/linux-audit/audit-kernel/issues/48
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/avc.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index e60c79d..4b42931 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -197,8 +197,6 @@ void __init avc_init(void)
>  	avc_xperms_data_cachep =
> kmem_cache_create("avc_xperms_data",
>  					sizeof(struct
> extended_perms_data),
>  					0, SLAB_PANIC, NULL);
> -
> -	audit_log(current->audit_context, GFP_KERNEL, AUDIT_KERNEL,
> "AVC INITIALIZED\n");
>  }
>  
>  int avc_get_hash_stats(char *page)
