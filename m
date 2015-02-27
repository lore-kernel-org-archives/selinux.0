Message-ID: <54F06DF1.8070605@tycho.nsa.gov>
Date: Fri, 27 Feb 2015 08:15:29 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeff Vander Stoep <jeffv@google.com>, jvanderstoep@gmail.com
Subject: Re: [PATCH] avc: remove unnecessary pointer reassignment
References: <1424987742-15120-1-git-send-email-jeffv@google.com>
In-Reply-To: <1424987742-15120-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/26/2015 04:54 PM, Jeff Vander Stoep wrote:
> Commit f01e1af445fa ("selinux: don't pass in NULL avd to avc_has_perm_noaudit")
> made this pointer reassignment unnecessary. Avd should continue to reference
> the stack-based copy.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/avc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index afcc0ae..3c17dda 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -724,12 +724,10 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	rcu_read_lock();
>  
>  	node = avc_lookup(ssid, tsid, tclass);
> -	if (unlikely(!node)) {
> +	if (unlikely(!node))
>  		node = avc_compute_av(ssid, tsid, tclass, avd);
> -	} else {
> +	else
>  		memcpy(avd, &node->ae.avd, sizeof(*avd));
> -		avd = &node->ae.avd;
> -	}
>  
>  	denied = requested & ~(avd->allowed);
>  	if (unlikely(denied))
> 
