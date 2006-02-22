Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1MEf8bT026127
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2006 09:41:08 -0500
Subject: Re: [PATCH] context based audit filtering (take 3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, James Morris <jmorris@namei.org>
In-Reply-To: <43FB86DD.2020708@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 09:46:32 -0500
Message-Id: <1140619592.31467.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-21 at 15:32 -0600, Darrel Goeddel wrote:
> diff --git a/security/selinux/exports.c b/security/selinux/exports.c
> new file mode 100644
> index 0000000..5129add
> --- /dev/null
> +++ b/security/selinux/exports.c
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
> +                            struct selinux_audit_rule **rule)
> +{
> +	return security_aurule_init(field, op, rulestr, rule);
> +}

I'd drop these wrapper functions, and just name the underlying functions
in services.c with the exported names (i.e. selinux_ prefix).  The use
of security_ prefix in the SELinux code should likely be converted in
general to selinux_ (via separate patch) along with other namespace
cleanups; it is a legacy of when SELinux was a kernel patch and there
was no LSM.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d877cd1..5e05c5a 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
<snip>
> +int security_aurule_init(u32 field, u32 op, char *rulestr,
> +                         struct selinux_audit_rule **rule)
> +{
<snip>
> +	case AUDIT_SE_SEN:
> +	case AUDIT_SE_CLR:
> +		/* we need freestr because mls_context_to_sid will change
> +		   the value of tmpstr */
> +		tmpstr = freestr = kstrdup(rulestr, GFP_ATOMIC);
> +		if (!tmpstr) {
> +			rc = -ENOMEM;
> +		} else {
> +			rc = mls_context_to_sid(':', &tmpstr, &tmprule->au_ctxt,
> +			                        NULL, SECSID_NULL);
> +			kfree(freestr);
> +		}

Let's move this into a helper in mls.c with a nicer interface, similar
to what Ivan has done in libsepol (mls_from_string).

> +int security_aurule_match(u32 ctxid, u32 field, u32 op,
> +                          struct selinux_audit_rule *rule)
> +{
> +	struct context *ctxt;
> +	struct mls_level *level;
> +	int match = 0;
> +
> +	if (!rule)
> +		return 0;

Should this be an error?

> +	ctxt = sidtab_search(&sidtab, ctxid);
> +	if (!ctxt) {
> +		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
> +		       ctxid);

Should we be using printk(KERN_ERR...) or
audit_log(...AUDIT_SELINUX_ERR) for SELinux errors for all new code?

> +		case AUDIT_LESS_THAN:
> +			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
> +			                       level) &&
> +			         !mls_level_eq(&rule->au_ctxt.range.level[0],
> +			                       level));
> +			break;
> +		case AUDIT_LESS_THAN_OR_EQUAL:
> +			match = mls_level_dom(&rule->au_ctxt.range.level[0],
> +			                      level);
> +			break;

I'm not clear as to why we truly need both sets of operators in the
audit filters (<= n versus just < (n+1)), but that is unrelated to
SELinux per se.

I take it that you either decided against leveraging the constraint code
or haven't looked at that option yet?  IOW, convert an audit filter to a
constraint expression when the rule is initialized, and later just call
a common helper shared with constraint_expr_eval?

> +static int (*aurule_callback)(void) = NULL;
> +
> +static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
> +                               u16 class, u32 perms, u32 *retained)
> +{
> +	int err = 0;
> +
> +	if (event == AVC_CALLBACK_RESET && aurule_callback)
> +		err = aurule_callback();
> +	return err;
> +}

Hmm...on an error return, we will stop walking the callback list
presently on avc_ss_reset, which could prevent other callbacks (like the
netif one) from occurring.  Likely should change that.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
