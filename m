Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAELQo3c001520
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 16:26:50 -0500
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAELPD1p026788
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 21:25:13 GMT
Date: Tue, 14 Nov 2006 16:27:01 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
Subject: Re: [PATCH 16/19] CacheFiles: Deal with LSM when accessing the cache
In-Reply-To: <20061114200656.12943.98985.stgit@warthog.cambridge.redhat.com>
Message-ID: <XMMS.LNX.4.64.0611141625090.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200656.12943.98985.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Nov 2006, David Howells wrote:

> @@ -80,6 +81,8 @@ struct cachefiles_cache {
>  	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
>  	rwlock_t			active_lock;	/* lock for active_nodes */
>  	atomic_t			gravecounter;	/* graveyard uniquifier */
> +	u32				access_sid;	/* cache access SID */
> +	u32				cache_sid;	/* cache fs object SID */

Please uniformly name these security IDs 'secids' in the main kernel, to 
avoid confusion with session IDs.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
