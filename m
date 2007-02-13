Subject: Re: Deleting xfrms
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: jmorris@namei.org, vyekkirala@TrustedCS.com, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
In-Reply-To: <1171323597.2603.445.camel@faith.austin.ibm.com>
References: <1171323597.2603.445.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 07:39:16 -0500
Message-Id: <1171370356.3242.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 17:39 -0600, Joy Latten wrote:
> I was looking at a patch D.Miller posted for xfrm_audit_log()
> and could not help but notice that in pfkey_spddelete() and
> xfrm_get_policy() we delete policy first and then check to see if we
> have permissions to.  Am I missing the original intentions or 
> is this incorrect?  Shouldn't it be check the permissions first and then
> call xfrm_policy_bysel_ctx()?

IIUC, the security_xfrm_policy_free call is just freeing the temporary
object created from the user context in order to perform the lookup of
the xp.  The permission check occurs upon security_xfrm_policy_delete,
and the actual deletion of the policy occurs upon xfrm_pol_put ->
__xfrm_policy_destroy.  pfkey_spddelete() does look wrong, since it
always calls xfrm_pol_put on the out path, whereas xfrm_get_policy()
jumps over the xfrm_pol_put() call upon an error from
security_xfrm_policy_delete().

> 
> pfkey_spddelete() in af_key.c:
> 
>         xp = xfrm_policy_bysel_ctx(XFRM_POLICY_TYPE_MAIN,
> pol->sadb_x_policy_dir-1,
>                                    &sel, tmp.security, 1);
>         security_xfrm_policy_free(&tmp);
> 
>         xfrm_audit_log(audit_get_loginuid(current->audit_context), 0,
>                        AUDIT_MAC_IPSEC_DELSPD, (xp) ? 1 : 0, xp, NULL);
> 
>         if (xp == NULL)
>                 return -ENOENT;
> 
>         err = 0;
> 
>         if ((err = security_xfrm_policy_delete(xp)))
>                 goto out;
>         c.seq = hdr->sadb_msg_seq;
>         c.pid = hdr->sadb_msg_pid;
>         c.event = XFRM_MSG_DELPOLICY;
>         km_policy_notify(xp, pol->sadb_x_policy_dir-1, &c);
> 
> 
> xfrm_get_policy() in xfrm_user.c is very similar.

 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
