Subject: Re: [PATCH] context based audit filtering (take 3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@namei.org>, Amy Griffis <amy.griffis@hp.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <43FBA962.5090904@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
	 <43FB86DD.2020708@trustedcs.com>  <43FBA962.5090904@trustedcs.com>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 09:58:52 -0500
Message-Id: <1140620332.31467.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-21 at 17:59 -0600, Darrel Goeddel wrote:
> The updated version of Dustin's patch I referred to is below.  The changes are
> are follows:
>
> - printk a warning and ignore invalid selinux rules (but still hang on to them
>   so they may be activated with a later policy reload).

Should this be a printk or an audit_log call?

> @@ -370,6 +410,14 @@ static int audit_compare_rule(struct aud
>  			if (audit_compare_watch(a->watch, b->watch))
>  				return 1;
>  			break;
> +		case AUDIT_SE_USER:
> +		case AUDIT_SE_ROLE:
> +		case AUDIT_SE_TYPE:
> +		case AUDIT_SE_SEN:
> +		case AUDIT_SE_CLR:
> +			if (strcmp(a->fields[i].se_str, b->fields[i].se_str))
> +				return 1;
> +			break;

Do you want to catch aliases here?  If so, you need to have SELinux look
up the strings and compare the actual values.  But possibly that isn't
critical for the purposes of just preventing duplicate filters.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
