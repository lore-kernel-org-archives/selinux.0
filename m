Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m859C4P5024902
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 05:12:04 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m859BPDN006849
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:11:26 GMT
Date: Fri, 5 Sep 2008 19:12:02 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 11/14] selinux: Cache NetLabel secattrs in the
 socket's security struct
In-Reply-To: <20080903005005.15669.66676.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051909230.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903005005.15669.66676.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

>  /**
> + * selinux_netlbl_sock_genattr - Generate the NetLabel socket secattr
> + * @sk: the socket
> + * @sid: the socket's SID
> + *
> + * Description:
> + * Generate the NetLabel security attributes for a socket, making full use of
> + * the socket's attribute cache.  Returns a pointer to the security attributes
> + * on success, negative values on failure.

Don't you mean NULL on failure?

> + *
> + */
> +static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk,
> +							      u32 sid)
> +{
> +	int rc;
> +	struct sk_security_struct *sksec = sk->sk_security;
> +	struct netlbl_lsm_secattr *secattr;
> +
> +	if (sksec->nlbl_secattr != NULL)
> +		return sksec->nlbl_secattr;
> +
> +	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
> +	if (secattr == NULL)
> +		return NULL;
> +	rc = security_netlbl_sid_to_secattr(sid, secattr);
> +	if (rc != 0) {
> +		netlbl_secattr_free(secattr);
> +		return NULL;
> +	}
> +	sksec->nlbl_secattr = secattr;
> +
> +	return secattr;
> +}
> +

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
