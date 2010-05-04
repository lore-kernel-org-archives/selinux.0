Subject: Re: [RFC PATCH v1 1/6] selinux: Update socket's label alongside
 inode's label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100503221122.8177.80352.stgit@flek.lan>
References: <20100503220455.8177.91177.stgit@flek.lan>
	 <20100503221122.8177.80352.stgit@flek.lan>
Content-Type: text/plain
Date: Tue, 04 May 2010 09:03:53 -0400
Message-Id: <1272978238.30175.22.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> We have always had a potential disconnect between the label on socket and
> the label on the associated inode when a user calls fsetxattr() on a
> socket.  The problem is that the fsetxattr() call would only relabel the
> inode and not the corresponding socket; the good news is that the
> mainstream SELinux policies have always prevented this, but better safe
> than sorry ...
> 
> This patch fixes this problem by adding the necessary socket labeling code
> to selinux_inode_setsecurity() so that if a user did relabel a socket via
> fsetxattr() both the inode and socket would be relabeled.
> 
> Signed-off-by: XXX
> ---
>  security/selinux/hooks.c            |   39 ++++++++++++++++++++++++++++++++++-
>  security/selinux/include/netlabel.h |    5 ++--
>  security/selinux/netlabel.c         |    8 +++++--
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5feecb4..f9545c8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2920,6 +2920,43 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	if (rc)
>  		return rc;
>  
> +	if (S_ISSOCK(inode->i_mode)) {

I think this is the wrong test - it would evaluate to true for both the
socket inode and for the file inode by which the socket is named, which
are separate and distinct objects.  I think you want:
	if (inode->i_sb->s_magic == SOCKFS_MAGIC)
which would only be true for the actual socket inode.

> +		struct sock *sk = SOCKET_I(inode)->sk;
> +		struct sk_security_struct *sksec = sk->sk_security;
> +
> +		/* XXX - In order to safely relabel a socket when labeled IPsec
> +		 *       is in use we need to also change the corresponding
> +		 *       flow secid (if any), if we don't change the flow's
> +		 *       secid then we run the risk of mislabeling traffic which
> +		 *       is not good.  Since the odds of us hitting this code
> +		 *       are very low (actually zero given refpolicy circa 2010)
> +		 *       we're not going to expend the effort in relabeling the
> +		 *       flow, just cause the fsetxattr() operation to fail
> +		 *       which should guarantee labeling safety. */
> +		if (selinux_xfrm_enabled())
> +			return -EPERM;
> +
> +		/* It is worth mentioning here that you could potentially see a
> +		 * labeling race condition if the socket being relabeled is
> +		 * undergoing lots of writes at the same time, as writes sent
> +		 * before the fsetxattr() operation may not receive their
> +		 * on-the-wire security label until after the fsetxattr()
> +		 * completes resulting in pre-fsetxattr() data getting labeled
> +		 * with a post-fsetxattr() security label.  However, we're just
> +		 * going to assume that if someone is silly enough to try and
> +		 * relabel a socket mid-stream then they should bear the
> +		 * responsibility of dealing with the potential problems.  It
> +		 * is also worth mentioning that this operation is forbidden by
> +		 * the 2010 refpolicy for this very reason. */
> +		lock_sock(sk);
> +		sksec->sid = newsid;
> +		selinux_netlbl_sk_security_reset(sksec);
> +		rc = selinux_netlbl_socket_setsid(sk, sk->sk_family);
> +		release_sock(sk);
> +		if (rc)
> +			return rc;

If the netlabel state change fails, do we want to revert the sksec->sid
to its original value?

> +	}
> +
>  	isec->sid = newsid;
>  	isec->initialized = 1;
>  	return 0;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
