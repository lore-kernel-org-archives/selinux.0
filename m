Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4AEEbZg006646
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2012 10:14:37 -0400
Message-ID: <4FABCD55.9000504@schaufler-ca.com>
Date: Thu, 10 May 2012 07:14:45 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Mel Gorman <mgorman@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>,
        Linux-Netdev <netdev@vger.kernel.org>,
        Linux-NFS <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Trond Myklebust <Trond.Myklebust@netapp.com>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mike Christie <michaelc@cs.wisc.edu>,
        Eric B Munson <emunson@mgebm.net>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 02/12] selinux: tag avc cache alloc as non-critical
References: <1336658065-24851-1-git-send-email-mgorman@suse.de> <1336658065-24851-3-git-send-email-mgorman@suse.de>
In-Reply-To: <1336658065-24851-3-git-send-email-mgorman@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/10/2012 6:54 AM, Mel Gorman wrote:
> Failing to allocate a cache entry will only harm performance not
> correctness.  Do not consume valuable reserve pages for something
> like that.

Copying to the LSM and SELinux lists.
 
>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Mel Gorman <mgorman@suse.de>
> ---
>  security/selinux/avc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 8ee42b2..75c2977 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -280,7 +280,7 @@ static struct avc_node *avc_alloc_node(void)
>  {
>  	struct avc_node *node;
>  
> -	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC);
> +	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC|__GFP_NOMEMALLOC);
>  	if (!node)
>  		goto out;
>  


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
