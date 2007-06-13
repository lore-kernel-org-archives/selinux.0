Message-ID: <46704A98.8050507@redhat.com>
Date: Wed, 13 Jun 2007 15:50:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [RFC][PATCH] selinux: enable authoritative granting of	capabilities
References: <1181591750.8805.151.camel@moss-spartans.epoch.ncsc.mil>	 <1181654688.17547.110.camel@moss-spartans.epoch.ncsc.mil>	 <1181681436.17547.280.camel@moss-spartans.epoch.ncsc.mil>	 <1181682766.17547.304.camel@moss-spartans.epoch.ncsc.mil>	 <1181745113.17547.357.camel@moss-spartans.epoch.ncsc.mil>	 <1181747197.21771.5.camel@sgc.columbia.tresys.com>	 <1181748515.17547.380.camel@moss-spartans.epoch.ncsc.mil>	 <7e0fb38c0706131210l2d1477ddxca1093ea47d35be2@mail.gmail.com> <1181762530.17547.488.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1181762530.17547.488.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-06-13 at 15:10 -0400, Eric Paris wrote:
>   
>> On 6/13/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>     
>>> On Wed, 2007-06-13 at 11:06 -0400, Christopher J. PeBenito wrote:
>>>       
>>>> On Wed, 2007-06-13 at 10:31 -0400, Stephen Smalley wrote:
>>>>         
>>>>> Updated policy patch below, defines the new class and permissions,
>>>>> and introduces an interface for allowing the cap_override permissions
>>>>> that ensures that these domains are excluded from the set of domains
>>>>> that can be controlled by unconfined domains.
>>>>>           
>>>> [...]
>>>>
>>>>         
>>>>> +interface(`domain_capoverride',`
>>>>>           
>>>> I would probably call this domain_capability_override() or
>>>> domain_cap_override(), maybe even domain_authoritative_caps().
>>>>
>>>>         
>>>>> +   gen_require(`
>>>>> +           attribute capoverride_domain_type;
>>>>> +   ')
>>>>> +
>>>>> +   typeattribute $1 capoverride_domain_type;
>>>>> +
>>>>> +   allow $1 self:cap_override $2;
>>>>>           
>>>> I think it would be better to just have the allow rule in the TE file.
>>>> Then you can put your cap_override and capability allow rules next to
>>>> each other and see more clearly which ones are being overridden and
>>>> which aren't.
>>>>         
>>> Ok, so you'd prefer the patch below?
>>> BTW, one other issue that I noticed is that this has a side effect if I
>>> grant capoverride to any of the unconfined domains (not that one should
>>> do that, but still), because it seems that unconfined domains are
>>> implicitly picking up permissions to self through the allow
>>> unconfined_domain_type domain: rules.  Seems like those should be
>>> separated?
>>>
>>> Index: refpolicy/policy/flask/security_classes
>>> ===================================================================
>>> --- refpolicy/policy/flask/security_classes     (revision 2324)
>>> +++ refpolicy/policy/flask/security_classes     (working copy)
>>> @@ -97,4 +97,8 @@
>>>
>>>  class dccp_socket
>>>
>>> +class memprotect
>>> +
>>> +class cap_override
>>> +
>>>  # FLASK
>>>       
>> Looks good to me, thanks for putting in my classes and perms too, I'm
>> swamped still for a couple more days, I'm really sorry about that.....
>>     
>
> We'll need to introduce an interface for memprotect:mmap_zero as well to
> allow it when needed, along with a corresponding type attribute and
> neverallow rule to ensure that all such uses are flagged as such.
>
>   
These changes prevent a domain transition on targeted policy from 
initrc_t which is an unconfined_domain to a domain that has 
cap_override, which might be unexpected.  We might also want to add a

dontaudit unconfined_domain capoverride_domain_type:process ptrace;

Otherwise killall/pidof will generate avc messages.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
