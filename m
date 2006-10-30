Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UKjipk023985
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 15:45:44 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UKisZb004024
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 20:44:56 GMT
Subject: Re: [patch 1/1] NetLabel: protect the CIPSOv4 socket option from
	setsockopt()
From: Eric Paris <eparis@redhat.com>
To: paul.moore@hp.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@redhat.com,
        sds@epoch.ncsc.mil
In-Reply-To: <20061030180801.641867000@hp.com>
References: <20061030180331.404950000@hp.com>
	 <20061030180801.641867000@hp.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 15:31:46 -0500
Message-Id: <1162240306.20103.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-30 at 13:03 -0500, paul.moore@hp.com wrote:
> plain text document attachment (netlabel-sockopts)
> From: Paul Moore <paul.moore@hp.com>
> 
> This patch makes two changes to protect applications from either removing or
> tampering with the CIPSOv4 IP option on a socket.  The first is the requirement
> that applications have the CAP_NET_RAW capability to set an IPOPT_CIPSO option
> on a socket; this prevents untrusted applications from setting their own
> CIPSOv4 security attributes on the packets they send.  The second change is to
> SELinux and it prevents applications from setting any IPv4 options when there
> is an IPOPT_CIPSO option already present on the socket; this prevents
> applications from removing CIPSOv4 security attributes from the packets they
> send.

> --- net-2.6_sockopt.orig/security/selinux/ss/services.c
> +++ net-2.6_sockopt/security/selinux/ss/services.c
> @@ -2682,4 +2682,41 @@ u32 selinux_netlbl_socket_getpeersec_dgr
>  
>  	return peer_sid;
>  }
> +
> +/**
> + * selinux_netlbl_socket_setsockopt - Do not allow users to remove a NetLabel
> + * @sock: the socket
> + * @level: the socket level or protocol
> + * @optname: the socket option name
> + *
> + * Description:
> + * Check the setsockopt() call and if the user is trying to replace the IP
> + * options on a socket and a NetLabel is in place for the socket deny the
> + * access; otherwise allow the access.  Returns zero when the access is
> + * allowed, -EACCES when denied, and other negative values on error.
> + *
> + */
> +int selinux_netlbl_socket_setsockopt(struct socket *sock,
> +				     int level,
> +				     int optname)
> +{
> +	int rc = 0;
> +	struct inode *inode = SOCK_INODE(sock);
> +	struct sk_security_struct *sksec = sock->sk->sk_security;
> +	struct inode_security_struct *isec = inode->i_security;
> +	struct netlbl_lsm_secattr secattr;
> +
> +	mutex_lock(&isec->lock);
> +	if (level == IPPROTO_IP && optname == IP_OPTIONS &&
> +	    sksec->nlbl_state == NLBL_LABELED) {
> +		netlbl_secattr_init(&secattr);
> +		rc = netlbl_socket_getattr(sock, &secattr);
> +		if (rc == 0 && (secattr.cache || secattr.mls_lvl_vld))
> +			rc = -EACCES;
> +		netlbl_secattr_destroy(&secattr);
> +	}
> +	mutex_unlock(&isec->lock);
> +
> +	return rc;
> +}
>  #endif /* CONFIG_NETLABEL */

I probably should have ask this a while back but both here and in
selinux_netlbl_socket_setsid() you are taking the isec->lock.  As I
originally understood the isec->lock it was just supposed to just
prevent multiple tasks from initializing the isec information
simultaneously while the isec information could be in an inconsistent
state.  After isec->initialized was set we didn't use the lock any more
(as typically the only change inside the isec was the ->sid which
couldn't even be 'in the middle').  I'm wondering what you are hoping to
protect taking this lock.  It doesn't seem like it would hurt anything,
but i'd like to hear what you see it's purpose as being...   (Then again
it's just as unlikely that I understood what it was being used for
pre-netlabel)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
