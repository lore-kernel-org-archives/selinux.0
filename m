Subject: Re: I still think typebounds checking is too tight.
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <d96a16a9-62e9-f65f-f045-eb7678acd620@redhat.com>
 <4de677bc-b755-5e3f-57fe-20487cef6ee3@tycho.nsa.gov>
 <a609530f-a663-286d-3190-0155805e7d7c@redhat.com>
 <51f5ead2-0fc0-cf52-c2e7-1d1dd7e9fecb@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <d104afdf-b160-39f5-183a-5d399f868c89@redhat.com>
Date: Wed, 27 Jul 2016 15:23:41 -0400
MIME-Version: 1.0
In-Reply-To: <51f5ead2-0fc0-cf52-c2e7-1d1dd7e9fecb@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 07/27/2016 02:01 PM, Stephen Smalley wrote:
> On 07/27/2016 12:52 PM, Daniel J Walsh wrote:
>>
>> On 07/27/2016 11:08 AM, Stephen Smalley wrote:
>>> On 07/27/2016 10:14 AM, Daniel J Walsh wrote:
>>>> We are now seeing breakage on entrypoint.
>>>>
>>>>
>>>> If I have a less confined domain and I want to allow unconfined_t to
>>>> transition to it, the compiler and the kernel eliminate entrypoints calls.
>>>>
>>>> unconfined_typebounds(svirt_lxc_net_t)
>>>>
>>>> Causes thousands of these errors.
>>>>
>>>>   (allow svirt_lxc_net_t ccs_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t canna_initrc_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t canna_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t callweaver_initrc_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t callweaver_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t calamaris_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t cachefilesd_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>   (allow svirt_lxc_net_t bumblebee_exec_t (file (entrypoint)))
>>>>     <See previous>
>>>>
>>>> Since svirt_lxc_net_t can be entered via an exec_type.  But unconfined_t
>>>> can not.  I think this access should be treated like a target also.
>>>>
>>>> IE Ignored, I don't want to have to allow unconfined_t or docker_t to be
>>>> able to be entered by all of the domains that svirt_lxc_net_t could be
>>>>
>>>> entered from.
>>> First question: Why does svirt_lxc_net_t need so many entrypoints?
>>> Optimally each domain would only have a single entrypoint type, for the
>>> executable used to initially enter that domain.
>>>
>>> Regardless, the correct way to handle this situation is to define a
>>> typebounds on the _exec_t types too, e.g.
>>> typebounds unconfined_exec_t ccs_exec_t;
>>> will cause the first rule above to pass as long as you have:
>>> allow unconfined_t unconfined_exec_t:file entrypoint;
>>> in your policy.
>>>
>>> However, you'll need to do this for all of the _exec_t types that are
>>> entrypoints for your domain.
>>>
>>> This was case #2 in the typebounds logic in my kernel patch description:
>>>     2. If we have:
>>>         typebounds A B;
>>>         typebounds A_exec B_exec;
>>>     then:
>>>         allow B B_exec:file <permissions>;
>>>     will satisfy the bounds constraint iff:
>>>         allow A A_exec:file <permissions>;
>>>     is also allowed in policy.
>>>
>>>     This is essentially the same as #1; it is merely included as
>>>     an example of dealing with object types related to a bounded domain
>>>     in a manner that satisfies the bounds relationship.  Note that
>>>     this approach is preferable to leaving B_exec unbounded and having:
>>>         allow A B_exec:file <permissions>;
>>>     in policy because that would allow B's entrypoints to be used to
>>>     enter A.  Similarly for _tmp or other related types.
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>>
>>>
>> Reason for container domains to be use exec_type entrypoints was policy
>> was originally written to allow you to start a container on any
>> executable in /usr.
>>
>> Basically we are doing
>>
>> runcon -t svirt_lxc_net_t /usr/bin/httpd
>>
>>
>> Can't do
>> typebounds unconfined_exec_t exec_type;
>>
>> ======================
>> policy_module(mypol,1.0)
>>
>> gen_require(`
>>     type svirt_lxc_net_t;
>>     attribute entry_type;
>>     type unconfined_exec_t;
>> ')
>> unconfined_typebounds(svirt_lxc_net_t)
>> typebounds unconfined_exec_t entry_type;
>> ========================
>>
>> # make -f /usr/share/selinux/devel/Makefile
>> Compiling targeted mypol module
>> /usr/bin/checkmodule:  loading policy configuration from tmp/mypol.tmp
>> mypol.te:9:ERROR 'type entry_type is not declared' at token ';' on line
>> 3257:
>>     
>> typebounds unconfined_exec_t entry_type;
>> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>> /usr/share/selinux/devel/include/Makefile:154: recipe for target
>> 'tmp/mypol.mod' failed
>> make: *** [tmp/mypol.mod] Error 1
> In the meantime, can't you work around this by adding a typebounds
> unconfined_exec_t $1; to wherever you currently have typeattribute $1
> entry_type;?
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
Yes that would work.
