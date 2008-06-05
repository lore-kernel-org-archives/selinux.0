Message-ID: <48483AB0.9000908@tycho.nsa.gov>
Date: Thu, 05 Jun 2008 15:12:48 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Dawid Kuroczko <qnex42@gmail.com>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: RFC: Per-object manager controls in /selinux/config
References: <4769A947.1030403@tycho.nsa.gov> <4769F731.6050002@ak.jp.nec.com> <48461B8C.60502@ak.jp.nec.com>
In-Reply-To: <48461B8C.60502@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> KaiGai Kohei wrote:
>   
>> Eamon Walsh wrote:
>>     
>>> I am proposing adding a separate config line for each userspace object 
>>> manager, as follows:
>>>
>>> #    permissive - SELinux prints warnings instead of enforcing.
>>> #    disabled - SELinux is fully disabled.
>>> SELINUX=enforcing
>>> +
>>> +# SELINUX_MANAGER= can take one of these four values
>>> +#    enforcing - SELinux security policy is enforced by this object 
>>> manager.
>>> +#    permissive - The object manager prints warnings instead of 
>>> enforcing.
>>> +#    disabled - SELinux is fully disabled by this object manager.
>>> +#    default - The object manager will track the system setting.
>>> +SELINUX_DBUS=default
>>> +SELINUX_XSERVER=permissive
>>> +
>>> # SELINUXTYPE= type of policy in use. Possible values are:
>>> #    targeted - Only targeted network daemons are protected.
>>> #    strict - Full SELinux protection.
>>>       
>> Eamon,
>>
>> Could you tell me the purpose of this new feature?
>>
>> It seems to me this new feature prevents to keep consistency of
>> the SELinux state. I think the internal state of userspace object
>> managers should be just a copy from the in-kernel reference monitor...
>>
>> Thanks,
>>     
>
> In the previous discussion, I told as above.
>
> However, some people in pgsql-hackers suggested me a facility to turn on/off
> MAC within SE-PostgreSQL. It seems to me they want to deliver a original
> PostgreSQL and SE- version's one within a single package.
> What is the best answer for this issue?
>
> In my opinion, this kind of configuration should be managed globally in system,
> because it enables to guarantee the consistency of access controls.
> In addition, a "policy-free" storage created by unauthorized users makes
> a loophole of data-flow-control scheme.
> But I can also understand their demands to avoid shipping two similar packages,...
>   

Based on the earlier feedback provided by you and Josh, I figured that 
my proposal had been NAK'ed.  Since that time, the Xorg server has been 
patched to support a configuration file option to set 
enabled/disabled/permissive.

I would be glad to reopen the discussion though, if you've changed your 
mind. 



> --------------------------------------------
> Subject: Re: [HACKERS] [0/4] Proposal of SE-PostgreSQL patches
>
> Dawid Kuroczko wrote:
>  > On Wed, May 7, 2008 at 7:52 AM, KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
>  >> Tom, Thanks for your reviewing.
>  >>> The patch hasn't got a mode in which SELinux support is compiled in but
>  >>> not active.  This is a good way to ensure that no one will ever ship
>  >>> standard RPMs with the feature compiled in, because they will be entirely
>  >>> nonfunctional for people who aren't interested in setting up SELinux.
>  >>> I think you need an "enable_sepostgres" GUC, or something like that.
>  >>> (Of course, the overhead of the per-row security column would probably
>  >>> discourage anyone from wanting to use such a configuration anyway,
>  >>> so maybe the point is moot.)
>  >> We can turn on/off SELinux globally, not bounded to SE-PostgreSQL.
>  >> The reason why I didn't provide a mode bit like "enable_sepostgresql"
>  >> is to keep consistency in system configuration.
>  >
>  > Hmm, I think ACE should be a CREATE DATABASE parameter.
>  >
>  > If I were to create a SE-database I would wish that disabling it was
>  > more difficult than changing a GUC in database.  And being able to
>  > set it on per-database basis would help get SE/ACE enabled by
>  > packagers.
>  >
>  >    Regards,
>  >       Dawid
> --------------------------------------------
>
> Thanks,
>
>   
>>> However, I am a little unclear on how runtime setenforce calls should 
>>> be dealt with.  The way it currently works is if the userspace object 
>>> manager is initialized without an enforcing mode specified in the call 
>>> to avc_open(), it will track the system setting and conform to netlink 
>>> "setenforce" messages.  However, if avc_open() is called with an 
>>> enforcing mode specified, it will stay in that mode and not respond to 
>>> the netlink messages.  Users might thus be confused if they issue a 
>>> "setenforce 0" and the X server stays in enforcing mode because it was 
>>> specified that way in the config file.  But I'm of the opinion that 
>>> runtime setenforcing is an abnormal event, and anyone who edits the 
>>> config file away from "default" and then runs setenforce will 
>>> understand how it works.
>>>       
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
