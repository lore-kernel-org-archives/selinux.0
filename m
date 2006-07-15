Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FD8eTS017793
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 09:08:40 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FD8csi016002
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 13:08:38 GMT
Date: Sat, 15 Jul 2006 09:08:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <20060714185915.270209000@flek.zko.hp.com>
Message-ID: <Pine.LNX.4.64.0607150905550.24495@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 14 Jul 2006, paul.moore@hp.com wrote:

> +struct sk_buff *cipso_v4_doi_dump_all(const size_t headroom)
> +{
> +	struct sk_buff *skb;
> +	unsigned char *buf;
> +	struct cipso_v4_doi *iter;
> +	u32 doi_cnt = 0;
> +	ssize_t buf_len;
> +
> +	/* XXX - In both cases, this is kinda ugly as we have to go through
> +	   the list once to determine how large of a buffer we need,
> +	   drop the locks, allocate the buffer, grab the locks, and
> +	   finally fill the buffer.  The problem is that there is that
> +	   open window where the table could grow and we will end up
> +	   short on space. */

This needs to be fixed.

Currently, it seems that you just bail if this happens.

> +
> +	buf_len = NETLBL_LEN_U32;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(iter, &cipso_v4_doi_list, list)
> +		if (iter->valid) {
> +			doi_cnt += 1;
> +			buf_len += 2 * NETLBL_LEN_U32;
> +		}
> +	rcu_read_unlock();
> +
> +	skb = netlbl_netlink_alloc_skb(headroom, buf_len, GFP_KERNEL);
> +	if (skb == NULL)
> +		return NULL;
> +	buf = skb_put(skb, buf_len);
> +	netlbl_putinc_u32(&buf, doi_cnt, &buf_len);
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(iter, &cipso_v4_doi_list, list)
> +		if (iter->valid) {
> +			if (buf_len < 2 * NETLBL_LEN_U32) {
> +				rcu_read_unlock();
> +				kfree(skb);
> +				return NULL;
> +			}
> +			netlbl_putinc_u32(&buf, iter->doi, &buf_len);
> +			netlbl_putinc_u32(&buf, iter->type, &buf_len);
> +		}
> +	rcu_read_unlock();
> +
> +	return skb;
> +}
> +

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
