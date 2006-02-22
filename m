Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1MF1uCr026541
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2006 10:01:56 -0500
Subject: Re: [PATCH] context based audit filtering (take 3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, James Morris <jmorris@namei.org>
In-Reply-To: <43FBA962.5090904@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com>  <43FBA962.5090904@trustedcs.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 10:07:22 -0500
Message-Id: <1140620842.31467.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-21 at 17:59 -0600, Darrel Goeddel wrote:
> - Add a selinux callback for re-initializing the se_rule field when there is
>   a policy reload.  THIS NEEDS WORK - It doesn't obey proper locking yet, but
>   it is functional.  I need to get my head around the locking of the audit
>   structures a little better - I'll also take suggestions ;)
<snip>
> @@ -726,3 +777,45 @@ unlock_and_return:
>  	rcu_read_unlock();
>  	return result;
>  }
> +
> +static int selinux_callback(void)
> +{
> +	struct audit_entry *entry;
> +	int i, j, err = 0;
> +
> +	/* TODO: add proper locking. */
> +	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
> +		list_for_each_entry(entry, &audit_filter_list[i], list) {
> +			for (j = 0; j < entry->rule.field_count; j++) {
> +				struct audit_field *f = &entry->rule.fields[j];
> +				switch (f->type) {
> +				case AUDIT_SE_USER:
> +				case AUDIT_SE_ROLE:
> +				case AUDIT_SE_TYPE:
> +				case AUDIT_SE_SEN:
> +				case AUDIT_SE_CLR:
> +					selinux_audit_rule_free(f->se_rule);
> +					err = selinux_audit_rule_init(f->type,
> +					         f->op, f->se_str, &f->se_rule);
> +					if (err == -EINVAL) {
> +						printk(KERN_WARNING "selinux audit rule for item %s is invalid\n", f->se_str);
> +						err = 0;
> +					}
> +					if (err)
> +						goto out;
> +				}
> +			}
> +		}
> +	}

For RCU, you need to make a new copy of the entry, mutate the copy (not
the original), list_replace_rcu the old original with the modified copy,
and call_rcu to drop the original when it is safe to do so.  Look at the
SELinux AVC code for an example (avc_update_node).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
