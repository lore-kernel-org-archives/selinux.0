Subject: Re: [RFC PATCH v2] selinux: Fix a problem with socket labels and
 the TUN driver
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090702212724.7080.70214.stgit@flek.lan>
References: <20090702212724.7080.70214.stgit@flek.lan>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 08:58:45 -0400
Message-Id: <1246885125.27287.38.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 17:27 -0400, Paul Moore wrote:
> There is a problem where packets being sent by the TUN driver are not
> correctly handled by SELinux in the postrouting code.  The issue is that
> the SELinux network access controls rely on a packet's associated sock, when
> present, for it's security label.  The TUN driver does create a sock to send
> network traffic but it only calls into the LSM/SELinux code once via the
> security_sk_alloc() hook which never fully initializes the sock's label.  This
> patch attempts to correct this problem by adding the normal LSM socket
> creation hooks to the TUN driver.
> 
> NOTE: this is an RFC patch intended to demonstrate a possible solution
> completely different from the v1 patch, but it is still crude, untested and
> not fully hashed out just yet.  Please take a look and see if this approach
> is even worth pursuing ... thanks.
> ---
> 
>  drivers/net/tun.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 11a0ba4..7db4b13 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -946,6 +946,10 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		if (!capable(CAP_NET_ADMIN))
>  			return -EPERM;
>  
> +		err = security_socket_create(AF_UNSPEC, SOCK_RAW, 0, 0);
> +		if (err < 0)
> +			return err;
> +

This is a permission checking hook only, so it isn't necessary to
setting up the socket security state, and it is questionable as to
whether we can add such a check unconditionally (it may cause denial
under existing policies that would have previously been allowed), or
whether it is necessary given that the process must have net_admin
capability.

>  		/* Set dev type */
>  		if (ifr->ifr_flags & IFF_TUN) {
>  			/* TUN device */
> @@ -987,6 +991,12 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		tun->sk = sk;
>  		container_of(sk, struct tun_sock, sk)->tun = tun;
>  
> +		/* XXX - correct placement? */
> +		err = security_socket_post_create(tun->socket,
> +						  AF_UNSPEC, SOCK_RAW, 0, 0);
> +		if (err < 0)
> +			goto err_free_sk;
> +

Current socket_post_create() hook presumes that the socket has an inode
with an allocated security struct, which I don't think we have here.

Wondering if it ought to just call sock_create_lite(), although that
will mark it as a kernel socket.  How do we actually want the socket
labeled - based on creating process or as a kernel-private socket?


>  		tun_net_init(dev);
>  
>  		if (strchr(dev->name, '%')) {
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
