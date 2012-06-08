Message-ID: <4FD2538D.4030707@schaufler-ca.com>
Date: Fri, 08 Jun 2012 12:33:33 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Paul Moore <paul@paul-moore.com>, SELinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] Add SELinux policy capability for always checking
 packet class.
References: <1339093682-5113-1-git-send-email-cpebenito@tresys.com> <2776660.gCfiz8ed08@sifl> <4FD2445C.3070704@tresys.com>
In-Reply-To: <4FD2445C.3070704@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/8/2012 11:28 AM, Christopher J. PeBenito wrote:
> On 06/08/12 13:36, Paul Moore wrote:
>> On Thursday, June 07, 2012 02:28:01 PM Chris PeBenito wrote:
>>> Currently the packet class in SELinux is not checked if there are no
>>> SECMARK rules in the security or mangle netfilter tables.  Some systems
>>> prefer that packets are always checked, for example, to protect the system
>>> should the netfilter rules fail to load or if the nefilter rules
>>> were maliciously flushed.
>>>
>>> Add the always_check_network policy capability which, when enabled, treats
>>> SECMARK as enabled, even if there are no netfilter SECMARK rules.
>>>
>>> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
>> ...
>>
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 372ec65..ec7151b 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>> ...
>>
>>>  static int selinux_secmark_enabled(void)
>>>  {
>>> -	return (atomic_read(&selinux_secmark_refcount) > 0);
>>> +	if (selinux_policycap_alwaysnetwork)
>>> +		return 1;
>>> +	else
>>> +		return (atomic_read(&selinux_secmark_refcount) > 0);
>>>  }
>> Nit picky, but why not simply:
>>
>>   return (selinux_policycap_alwaysnetwork || atomic_read( ...
> Sure it can be done that way, but I'd argue that the intent is clearer the way its implemented in the patch.

Oh come on, no one does

    if (...)
            return x;
    else
            return y;

Much better to do

    if (...)
            return x;
    return y;

The else is unnecessary.

>
>
>>>  /*
>>> diff --git a/security/selinux/include/security.h
>>> b/security/selinux/include/security.h index dde2005..981c4ac 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -68,12 +68,14 @@ extern int selinux_enabled;
>>>  enum {
>>>  	POLICYDB_CAPABILITY_NETPEER,
>>>  	POLICYDB_CAPABILITY_OPENPERM,
>>> +	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>  	__POLICYDB_CAPABILITY_MAX
>>>  };
>>>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>>
>>>  extern int selinux_policycap_netpeer;
>>>  extern int selinux_policycap_openperm;
>>> +extern int selinux_policycap_alwaysnetwork;
>> Also nit picky, but it would seem like "selinux_policycap_netalways" is a bit 
>> more consistent with the other variables.
> This response stems on what you wrote on a later cunch about the capability name, so you should probably read below first.
>
> I don't agree.  If you go by current capabilities names/variables, based on the ordering of the words in the capability name, the words in the variable are in the same order. e.g.
>
> NETwork_PEER_controls -> selinux_policycap_netpeer
> OPEN_PERMs -> selinux_policycap_openperm
>
> hence
>
> ALWAYS_check_NETWORK -> selinux_policycap_alwaysnetwork
>
>>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>>> index 3ad2902..cb893f9 100644
>>> --- a/security/selinux/selinuxfs.c
>>> +++ b/security/selinux/selinuxfs.c
>>> @@ -44,7 +44,8 @@
>>>  /* Policy capability filenames */
>>>  static char *policycap_names[] = {
>>>  	"network_peer_controls",
>>> -	"open_perms"
>>> +	"open_perms",
>>> +	"always_check_network"
>>>  };
>> Similarly, I think "network_always" is more consistent.
> Earlier discussions concluded with this capability name.  (to be specific the discussion resolved with always_check_packets, but that was before the peer class was included)
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
