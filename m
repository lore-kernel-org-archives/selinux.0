Date: Thu, 14 Jun 2007 11:40:54 -0400
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
 capabilities
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <C296D9C6.23423%csellers@tresys.com>
In-Reply-To: <1181655164.17547.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/12/07 9:32 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
>> Extend SELinux to allow capabilities to be granted authoritatively.
>> Introduces a new cap_override access vector to indicate when the
>> secondary module (i.e. capability or dummy) check should be skipped.
>> Handle the new class gracefully even if the policy does not yet have
>> it defined.
> 
> Ah, I realized that this has the same issue in permissive mode as the
> get_user_sids code - we don't want to arbitrarily allow these
> dac_override permissions in permissive mode (otherwise setenforce 0
> turns off DAC as well), so the following patch should be applied on top:
> 
> diff -u b/security/selinux/hooks.c b/security/selinux/hooks.c
> --- b/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1424,7 +1424,7 @@
> int rc;
>  
> rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
> -      CAP_TO_MASK(cap), 0, NULL);
> +      CAP_TO_MASK(cap), AVC_STRICT, NULL);
> if (rc) {
> rc = secondary_ops->capable(tsk, cap);
> if (rc)
> 
> I'll fold that into the base patch for submission.

This certainly makes the permissive case better than the original patch, but
you're still opening up a new vector for escalation of privilege when
SELinux access controls aren't enforcing. At the very least, policy authors
are going to have to be really careful with this, as it's easy to shoot
yourself in the foot in permissive. One example scenario of escalation:

A domain is granted cap_override:dac_override in policy. The system is
running in permissive mode. In permissive mode, the only thing that protects
the policy from being reloaded is DAC permissions, which the policy has
granted the domain the ability to override. So, the domain loads a new
policy which grants it cap_override:*. This means that in permissive
dac_override can easily get you all capabilities. Also, note that the same
scenario can be constructed without the original allow rule using a
capability shedding scenario.

I realize that there are already other scenarios where a program can use
dac_override to escalate to further capabilities. My point is that we seem
to be opening up a new attack vector here.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
