Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PMcfrs007715
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 18:38:41 -0400
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PMcdRe017035
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 22:38:40 GMT
Date: Tue, 25 Sep 2007 15:38:37 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer labeling
 subsystems
In-Reply-To: <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0709251534360.26141@us.intercode.com.au>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
 <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Sep 2007, Paul Moore wrote:

> +int security_sid_mls_cmp(u32 sid_a, u32 sid_b)

This looks heavyweight on TCP connection establishment (MCS is enabled in 
Fedora/RHEL).

Perhaps see it can be noticed with lmbench and apachbench (with high rates 
of connection & small files) ?


> +{
> +	int rc;
> +	struct context *ctx_a;
> +	struct context *ctx_b;
> +
> +	if (!ss_initialized || !selinux_mls_enabled)
> +		return 0;
> +
> +	POLICY_RDLOCK;
> +
> +	ctx_a = sidtab_search(&sidtab, sid_a);
> +	if (!ctx_a) {
> +		printk(KERN_ERR
> +		       "security_sid_mls_cmp:  unrecognized SID %d\n", sid_a);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	ctx_b = sidtab_search(&sidtab, sid_b);
> +	if (!ctx_b) {
> +		printk(KERN_ERR
> +		       "security_sid_mls_cmp:  unrecognized SID %d\n", sid_b);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	rc = mls_context_cmp(ctx_a, ctx_b);
> +
> +out:
> +	POLICY_RDUNLOCK;
> +	return rc;
> +}
> +
>  static int get_classes_callback(void *k, void *d, void *args)
>  {
>  	struct class_datum *datum = d;
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
