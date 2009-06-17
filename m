Subject: Re: type bounds audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com
In-Reply-To: <4A38727F.7090705@ak.jp.nec.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <200906161040.52279.sgrubb@redhat.com>
	 <1245164133.2848.12.camel@localhost.localdomain>
	 <200906161123.52932.sgrubb@redhat.com>
	 <1245166869.2848.21.camel@localhost.localdomain>
	 <4A38727F.7090705@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 08:53:07 -0400
Message-Id: <1245243187.29288.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-06-17 at 13:35 +0900, KaiGai Kohei wrote:
> Summary of opinions:
> - SELINUX_INFO is good, because it is a new audit message type (Eric).
>   But it is not unclear whether the most descriptive type name, or not (Steve).
> - The { ... } style is not preferable, comma separated permissions list
>   is better (Eric).
> - The <name>=<value> style is more excellent (Dan).
> - The quoted strung should be limited to describe untrusted strings (Steve).
> - AVC denials also should use SELINUX_INFO with new style (Dan).

No, we can't change the AVC denial format without breaking existing
userspace.

>   - It describes an internal inconsistency within the policy, not AVC (Stephen).
> 
> Please tell me, if I missed your opinions.
> 
> I fixed the message format as follows:
> ("UNKNOWN[1418]" is AUDIT_SELINUX_INFO newly defined.)
> 
>   type=UNKNOWN[1418] msg=audit(1245207615.589:70):      \
>       op=security_compute_av masked=bounds              \
>       scontext=system_u:system_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=getattr,open
> 
> However, I think Stephen pointed out a significant thing.
> 
> Some of permissions are masked at runtime during security_compute_av()
> due to RBAC, Constraint, MLS and Type bounds, although TE allows them.
> It's not clear for me whether it should be considered as an error
> (SELINUX_ERR) because of an internal inconsistency within the policy,
> or should be considered as just an information (SELINUX_INFO) from
> the kernel.

I assume the desire for a new message type is to make it clear that it
can be parsed using the new format.  But conceptually it is no different
than the SELINUX_ERR messages emitted by security_compute_sid or
security_validate_transition.

> --------
> [PATCH] Add audit messages for masked SELinux permissions
> 
> The following patch adds a few audit messages,
>  1. when a multithread process switch its performing domain to unbounded
>     one, and the hardwired rule prevent it.
> 
>   type=SELINUX_ERR msg=audit(1245207506.618:62):        \
>       security_bounded_transition: denied for           \
>       oldcontext=system_u:system_r:httpd_t:s0           \
>       newcontext=system_u:system_r:guest_webapp_t:s0

Might as well use the op=security_bounded_transition result=denied style
of syntax here as well for ease of parsing.

>  2. when RBAC, MLS/Constraints and Type bounds masks permissions allowed
>     with TE rules on security_compute_av().
> 
>   * BRAC prevent domain transition
>   type=UNKNOWN[1418] msg=audit(1245207539.227:67):      \
>       op=security_compute_av masked=rbac                \
>       scontext=unconfined_u:unconfined_r:unconfined_t:s0    \
>       tcontext=staff_u:staff_r:staff_t:s0               \
>       tclass=process perms=transition
> 
>   * MCS prevent accesses to *:s0:c0 by *:s0
>   type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
>       op=security_compute_av masked=constraint          \
>       scontext=system_u:system_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=ioctl,read,write,create,setattr,lock,append,unlink,link,rename

I'm not sure about adding such messages for RBAC or constraints - this
will potentially generate a fair number of messages for permissions that
will never be checked by the AVC, and they don't represent any
inconsistency within the policy, unlike the boundary violations.  Users
could potentially see many of these messages and be concerned that they
represent actual access attempts vs. just av computation.  If we were to
add such messages, I think we'd want to be able to easily disable them
(and do so by default), and then only enable them when doing policy
debugging.

>   * Then, type bounds prevents accesses to shadow_t
>   type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
>       op=security_compute_av masked=bounds              \
>       scontext=system_u:system_r:user_webapp_t:s0       \
>       tcontext=system_u:object_r:shadow_t:s0:c0         \
>       tclass=file perms=getattr,open

This looks ok, although I'm not sure masked= is the best name (vs. e.g.
reason=).

<snip>
> +static void security_dump_masked_av(struct context *scontext,
> +				    struct context *tcontext,
> +				    u16 tclass,
> +				    u32 permissions,
> +				    const char *reason)
> +{
> +	struct common_datum *common_dat;
> +	struct class_datum *tclass_dat;
> +	struct audit_buffer *ab;
> +	char *tclass_name;
> +	char *scontext_name;
> +	char *tcontext_name;

Initialize the *_name variables to NULL.
And then you don't need multiple out paths - you can just always kfree()
them on the way out.


> +	char *permission_names[32];
> +	int index, length;
> +	bool need_comma = false;
> +
> +	if (!permissions)
> +		return;
> +
> +	tclass_name = policydb.p_class_val_to_name[tclass - 1];
> +	tclass_dat = policydb.class_val_to_struct[tclass - 1];
> +	common_dat = tclass_dat->comdatum;
> +
> +	/* init permission_names */
> +	if (common_dat) {
> +		if (hashtab_map(common_dat->permissions.table,
> +				dump_masked_av_helper, permission_names) < 0)
> +			goto out0;
> +	}
> +	if (hashtab_map(tclass_dat->permissions.table,
> +			dump_masked_av_helper, permission_names) < 0)
> +		goto out0;
> +
> +	/* get scontext/tcontext in text form */
> +	if (context_struct_to_string(scontext,
> +				     &scontext_name, &length) < 0)
> +		goto out0;
> +
> +	if (context_struct_to_string(tcontext,
> +				     &tcontext_name, &length) < 0)
> +		goto out1;
> +
> +	/* audit a message */
> +	ab = audit_log_start(current->audit_context,
> +			     GFP_ATOMIC, AUDIT_SELINUX_INFO);
> +	if (!ab)
> +		goto out2;
> +
> +	audit_log_format(ab,
> +			 "op=security_compute_av masked=%s "
> +			 "scontext=%s tcontext=%s tclass=%s perms=",
> +			 reason, scontext_name, tcontext_name, tclass_name);
> +
> +	for (index = 0; index < 32; index++) {
> +		u32 mask = (1 << index);
> +
> +		if ((mask & permissions) == 0)
> +			continue;
> +
> +		audit_log_format(ab, "%s%s",
> +				 need_comma ? "," : "",
> +				 permission_names[index]
> +				 ? permission_names[index] : "????");
> +		need_comma = true;
> +	}
> +	audit_log_end(ab);
> +
> +	/* release scontext/tcontext */
> +out2:
> +	kfree(tcontext_name);
> +out1:
> +	kfree(scontext_name);
> +out0:
> +	return;
> +}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
