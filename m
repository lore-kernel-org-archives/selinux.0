Date: Mon, 24 Jan 2011 10:36:59 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Shan Wei <shanwei@cn.fujitsu.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/4] security:selinux: kill unused MAX_AVTAB_HASH_MASK
 and ebitmap_startbit
In-Reply-To: <4D36AD28.2090303@cn.fujitsu.com>
Message-ID: <alpine.LRH.2.00.1101241036430.30043@tundra.namei.org>
References: <4D36AD28.2090303@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Jan 2011, Shan Wei wrote:

> Kill unused MAX_AVTAB_HASH_MASK and ebitmap_startbit.
> Just compiled test.
> 
> 
> Signed-off-by: Shan Wei <shanwei@cn.fujitsu.com>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


> ---
>  security/selinux/ss/avtab.h   |    1 -
>  security/selinux/ss/ebitmap.h |    1 -
>  2 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index dff0c75..3417f9c 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -86,7 +86,6 @@ void avtab_cache_destroy(void);
>  
>  #define MAX_AVTAB_HASH_BITS 11
>  #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
> -#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
>  
>  #endif	/* _SS_AVTAB_H_ */
>  
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index 1f4e93c..922f8af 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -36,7 +36,6 @@ struct ebitmap {
>  };
>  
>  #define ebitmap_length(e) ((e)->highbit)
> -#define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
>  
>  static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
>  						  struct ebitmap_node **n)
> -- 
> 1.6.3.3
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
