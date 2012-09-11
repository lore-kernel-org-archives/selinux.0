In-Reply-To: <AEF56AAB-992E-4204-8F41-0B97603DA938@stratus.com>
References: <CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com> <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil> <CALrft98Np4v5Lyhzy+_NEJkf9aqkC60PzMT4fFoYcPgohzyJqQ@mail.gmail.com> <1347373683.17403.36.camel@moss-pluto.epoch.ncsc.mil> <AEF56AAB-992E-4204-8F41-0B97603DA938@stratus.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CDA0CD96-223C-4E13-95A4-F829511E0591@stratus.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Elena Reshetova <elena.reshetova@gmail.com>, SELinux@tycho.nsa.gov,
        Steve Lawrence <slawrence@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>
From: "Richard.Johnson" <Richard.Johnson@stratus.com>
Subject: Re: Security hooks for rpm
Date: Tue, 11 Sep 2012 10:52:50 -0400
To: "Richard.Johnson" <Richard.Johnson@stratus.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

..er sorry....off by on on message I was replying to.

On Sep 11, 2012, at 10:45 AM, Richard.Johnson wrote:

> or anywhere in the prompt.
> Normally it would be '#' for root and "$" for normal users.  And  
> the '>' would be for continuation of a command line.
>
> What does:
>      echo  PS1=${PS1} echo ${PS2}
>
> reveal?
>
>
> On Sep 11, 2012, at 10:28 AM, Stephen Smalley wrote:
>
>> On Tue, 2012-09-11 at 14:56 +0300, Elena Reshetova wrote:
>>> I agree that it is better to have one plugin interface for rpm that
>>> can be used either for security or other purposes. However my  
>>> current
>>> understanding is that the only interface for plugins that rpm has  
>>> is a
>>> "collection plugin". I don't have anything against it, but do we  
>>> need
>>> that notion for set of generic security rpm hooks? I don't think  
>>> every
>>> plugin needs to be aware about what is a  "collection" and how to
>>> handle it. I would prefer a simpler approach when a set of hooks is
>>> defined and then called at different stages of the rpm execution.
>>
>> I would tend to view the collection hooks as just part of the overall
>> hook interface for plugins.  You are defining per-transaction,
>> per-package, and per-file hooks, and per-collection hooks are just
>> another case to consider (unless I misunderstand).  But as I  
>> wasn't the
>> one who came up with the collection hooks, others may have other
>> opinions (Steve?  Jim?).
>>
>>> Another issue is that I would like to be able to mandate the  
>>> presence
>>> of a plugin in a system in some cases. For example for our  
>>> platform, I
>>> would like to tell that if loading of our security plugin fails,  
>>> then
>>> installation must be aborted. I think current plugin interface  
>>> doesn't
>>> provide a way to do it either.
>>
>> If not, I don't see why it cannot be made to support that  
>> functionality.
>> It isn't truly unique to security; other kinds of functional  
>> plugins may
>> need/want to be able to abort the installation.
>>
>>> Yes, you are right, this hook needs changing. The reason why  
>>> initially
>>> we didn't need more arguments is that the plugin remembered needed
>>> info from the FSM_OPENED hook (like path for example) and then in
>>> FSM_CLOSE used this info. However, I have just changed things a bit
>>> and I think now the interface can be smth like:
>>>
>>> rpmRC SECURITYHOOK_FSM_CLOSED_FUNC(const char* dirName, const char*
>>> baseName, mode_t mode, int rpmrc)
>>>
>>> I have noticed that SELinux uses fsm->path directly, do you  
>>> prefer to
>>> have that one passed to the hook or dirName + baseName is ok?
>>
>> As long as we can reliably determine the full path from the inputs, I
>> don't think it matters.
>>
>>> About the selabel handle: I would prefer to keep any plugin internal
>>> data outside of actual rpm. It helps to keep the rpm and plugin
>>> independent with only dependency on the actual hooks. The way we
>>> handle it in our plugin is that this info is preserved in the plugin
>>> state while package processing is going. Would any such approach be
>>> acceptable for selinux?
>>>
>>> Another option to go about it would be to define a handle for each
>>> plugin's data as simple void pointer and then pass this handle to  
>>> the
>>> plugin in everyhook. Internally plugin can store any stuct behind  
>>> this
>>> including any needed handles. But I think this won't be much  
>>> different
>>> for the plugin than storing this by itself.
>>
>> I'm unclear on this point; possibly others (Steve?) will have more
>> insight.  We appear to be maintaining a per-rpmts selabel handle at
>> present, and refreshing it under various conditions.  I know that our
>> situation is complicated by the fact that policy may change either  
>> as a
>> result of explicit policy in the rpm package using the plugin  
>> mechanism
>> or as a side effect of a %post scriptlet in the rpm package (the
>> original way of packaging policy which is still in widespread  
>> use).  So
>> I am uncertain as to whether it suffices to maintain this state  
>> globally
>> within the plugin or whether we truly need to be able to hang a  
>> selabel
>> handle off of the rpmts in some way and track its life cycle.
>>
>>> And fsmMkdirs() is actually a good point! I am wondering what  
>>> would be
>>> the proper way to handle this part. I think it might make sense to
>>> define a new hook just for this purpose, because this hook would be
>>> called only once per package versus the FSM_CLOSED that is called  
>>> once
>>> per every file in the package. The interface can be similar to  
>>> CLOSED
>>> hook:
>>>
>>> rpmRC SECURITYHOOK_FSM_MAKE_DIR_FUNC(const char* dirName, const  
>>> char*
>>> baseName, mode_t mode)
>>>
>>> What do you think?
>>
>> Yes, I think that makes sense.
>>
>> -- 
>> Stephen Smalley
>> National Security Agency
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing  
>> list.
>> If you no longer wish to subscribe, send mail to  
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to  
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
