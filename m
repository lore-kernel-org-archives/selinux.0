Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6ENuKTA008648
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 19:56:20 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6ENuJ48025226
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 23:56:19 GMT
Date: Fri, 14 Jul 2006 19:56:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        "David S. Miller" <davem@davemloft.net>, sds@epoch.ncsc.mil,
        pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <20060714185915.270209000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607141950580.19230@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:

> +int cipso_v4_validate(unsigned char **option)
> +{
> +	unsigned char *opt = *option;
> +	unsigned char *tag;
> +	unsigned char opt_iter;
> +	unsigned char err_offset = 0;
> +	unsigned char locked = 0;
> +	u8 opt_len;
> +	u8 tag_len;
> +	struct cipso_v4_doi *doi_def = NULL;
> +	u32 tag_iter;
> +
> +	/* XXX - caller already checks for length values that are too large */

Please don't put 'XXX' there for a normaly comment.  It's supposed to 
indicate that something needs attention (e.g. known bug, unresolved 
question etc).

> +	rcu_read_lock();
> +	locked = 1;

> +validate_return:
> +	if (locked)
> +		rcu_read_unlock();
> +	*option = opt + err_offset;
> +	return err_offset;
> +}

No need for the 'locked' variable, just create a new goto label, like:


{

out_unlock:
	rcu_read_unlock();
out:
	*option = opt + err_offset;
	return err_offset;
}

Then have the goto callers specify the correct label.

> +	/* In the case of sock_create_lite(), the sock->sk field is not
> +	   defined yet but it is not a problem as the only users of these
> +	   "lite" PF_INET sockets are functions which do an accept() call
> +	   afterwards so we will label the socket as part of the accept(). */

Coding style standard for multiline comments is:

	/*
	 *
         */


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
