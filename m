Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB5Kx2sT013759
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2012 15:59:02 -0500
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Cc: geert@linux-m68k.org
Subject: Re: [PATCH] selinux: fix problems in netnode when BUG() is compiled out
Date: Wed, 05 Dec 2012 15:58:57 -0500
Message-ID: <2832833.Hoo22T01nR@sifl>
In-Reply-To: <20121205205812.22105.14253.stgit@localhost>
References: <20121205205812.22105.14253.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, December 05, 2012 03:58:12 PM Paul Moore wrote:
> When the BUG() macro is disabled at compile time it can cause some
> problems in the SELinux netnode code: invalid return codes and
> uninitialized variables.  This patch fixes this by making sure we take
> some corrective action after the BUG() macro.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  security/selinux/netnode.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index c5454c0..9e0048a 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -166,6 +166,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
> break;
>  	default:
>  		BUG();
> +		return;
>  	}
> 
>  	/* we need to impose a limit on the growth of the hash table so check
> @@ -225,6 +226,8 @@ static int sel_netnode_sid_slow(void *addr, u16 family,
> u32 *sid) break;
>  	default:
>  		BUG();
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (ret != 0)
>  		goto out;

Ooops, scratch this patch.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
