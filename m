Subject: Re: [PATCH 4/5] conntrack: export lsm context rather than internal
 secid via netlink
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netfilter@vger.kernel.org, jmorris@namei.org, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jengelh@medozas.de,
        linux-security-module@vger.kernel.org, mr.dash.four@googlemail.com,
        pablo@netfilter.org
In-Reply-To: <20101012154028.26943.6918.stgit@paris.rdu.redhat.com>
References: <20101012154008.26943.44399.stgit@paris.rdu.redhat.com>
	 <20101012154028.26943.6918.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Oct 2010 19:14:44 -0400
Message-ID: <1286925284.5133.98.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-10-12 at 11:40 -0400, Eric Paris wrote:
> The conntrack code can export the internal secid to userspace.  These are
> dynamic, can change on lsm changes, and have no meaning in userspace.  We
> should instead be sending lsm contexts to userspace instead.  This patch sends
> the secctx (rather than secid) to userspace over the netlink socket.  We use a
> new field CTA_SECCTX and stop using the the old CTA_SECMARK field since it did
> not send particularly useful information.

Looks fine to me in principal, just a nit-picky comment below ...

> -ctnetlink_dump_secmark(struct sk_buff *skb, const struct nf_conn *ct)
> +ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  {
> -	NLA_PUT_BE32(skb, CTA_SECMARK, htonl(ct->secmark));
> -	return 0;
> +	struct nlattr *nest_secctx;
> +	int len, ret;
> +	char *secctx;
> +
> +	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	if (ret)
> +		return ret;
> +
> +	ret = -1;
> +	nest_secctx = nla_nest_start(skb, CTA_SECCTX | NLA_F_NESTED);
> +	if (!nest_secctx)
> +		goto nla_put_failure;
>  
> +	NLA_PUT_STRING(skb, CTA_SECCTX_NAME, secctx);
> +	nla_nest_end(skb, nest_secctx);
> +
> +	ret = 0;
>  nla_put_failure:
> -	return -1;
> +	security_release_secctx(secctx, len);
> +	return ret;
>  }

All the ret assignments bother me, I also don't think "nla_put_failure"
is a good choice since we run this code both on success and failure -
how about this:

ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
{
	struct nlattr *nest_secctx;
	int len, ret;
	char *secctx;

	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
	if (ret)
		return ret;

	nest_secctx = nla_nest_start(skb, CTA_SECCTX | NLA_F_NESTED);
	if (!nest_secctx) {
		ret = -1;
		goto dump_secctx_out;
	}

	NLA_PUT_STRING(skb, CTA_SECCTX_NAME, secctx);
	nla_nest_end(skb, nest_secctx);

dump_secctx_out:
	security_release_secctx(secctx, len);
	return ret;
}

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
