Date: Sun, 23 Sep 2007 14:39:21 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ewalsh@tycho.nsa.gov,
        sgrubb@redhat.com
Subject: Re: [PATCH -v4] kernel: selinux: policy selectable handling of
 unknown classes and perms
In-Reply-To: <1190399830.3451.145.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0709231431320.23411@us.intercode.com.au>
References: <1190399830.3451.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Sep 2007, Eric Paris wrote:

>  	kfree(p->type_attr_map);
>  

Remove the blank line between these.

> +	kfree(p->undefined_perms);
> +

> +
> +	unsigned int reject_unknown : 1;
> +	unsigned int allow_unknown : 1;
> +	u32 *undefined_perms;

Why two separate bitfields ?

> +	if (p->allow_unknown) {
> +		u32 num_classes = kdefs->cts_len;
> +		p->undefined_perms = kcalloc(num_classes, sizeof(u32), GFP_KERNEL);
> +		if (!p->undefined_perms)
> +			return -ENOMEM;
> +	}

Why have num_classes when you only use the value once ?

It's clearer to just use kdefs->cts_len in the kcalloc.

> +int security_get_reject_unknown(void)
> +int security_get_allow_unknown(void)

Can you make these static inline?


What sort of testing has this had?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
