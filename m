Message-ID: <484D0F5E.2000101@ak.jp.nec.com>
Date: Mon, 09 Jun 2008 20:09:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eamon Walsh <ewalsh@tycho.nsa.gov>, Dawid Kuroczko <qnex42@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: RFC: Per-object manager controls in /selinux/config
References: <4769A947.1030403@tycho.nsa.gov>	 <4769F731.6050002@ak.jp.nec.com> <48461B8C.60502@ak.jp.nec.com>	 <48483AB0.9000908@tycho.nsa.gov>	 <1212695376.2763.160.camel@moss-spartans.epoch.ncsc.mil>	 <4848D5A6.9020106@ak.jp.nec.com> <1212756767.2763.203.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1212756767.2763.203.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-06-06 at 15:13 +0900, KaiGai Kohei wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2008-06-05 at 15:12 -0400, Eamon Walsh wrote:
>>>> KaiGai Kohei wrote:
>>>>> KaiGai Kohei wrote:
>>>>>   
>>>>>> Eamon Walsh wrote:
>>>>>>     
>>>>>>> I am proposing adding a separate config line for each userspace object 
>>>>>>> manager, as follows:
>>>>>>>
>>>>>>> #    permissive - SELinux prints warnings instead of enforcing.
>>>>>>> #    disabled - SELinux is fully disabled.
>>>>>>> SELINUX=enforcing
>>>>>>> +
>>>>>>> +# SELINUX_MANAGER= can take one of these four values
>>>>>>> +#    enforcing - SELinux security policy is enforced by this object 
>>>>>>> manager.
>>>>>>> +#    permissive - The object manager prints warnings instead of 
>>>>>>> enforcing.
>>>>>>> +#    disabled - SELinux is fully disabled by this object manager.
>>>>>>> +#    default - The object manager will track the system setting.
>>>>>>> +SELINUX_DBUS=default
>>>>>>> +SELINUX_XSERVER=permissive
>>>>>>> +
>>>>>>> # SELINUXTYPE= type of policy in use. Possible values are:
>>>>>>> #    targeted - Only targeted network daemons are protected.
>>>>>>> #    strict - Full SELinux protection.
>>>>>>>       
>>>>>> Eamon,
>>>>>>
>>>>>> Could you tell me the purpose of this new feature?
>>>>>>
>>>>>> It seems to me this new feature prevents to keep consistency of
>>>>>> the SELinux state. I think the internal state of userspace object
>>>>>> managers should be just a copy from the in-kernel reference monitor...
>>>>>>
>>>>>> Thanks,
>>>>>>     
>>>>> In the previous discussion, I told as above.
>>>>>
>>>>> However, some people in pgsql-hackers suggested me a facility to turn on/off
>>>>> MAC within SE-PostgreSQL. It seems to me they want to deliver a original
>>>>> PostgreSQL and SE- version's one within a single package.
>>>>> What is the best answer for this issue?
>>>>>
>>>>> In my opinion, this kind of configuration should be managed globally in system,
>>>>> because it enables to guarantee the consistency of access controls.
>>>>> In addition, a "policy-free" storage created by unauthorized users makes
>>>>> a loophole of data-flow-control scheme.
>>>>> But I can also understand their demands to avoid shipping two similar packages,...
>>>>>   
>>>> Based on the earlier feedback provided by you and Josh, I figured that 
>>>> my proposal had been NAK'ed.  Since that time, the Xorg server has been 
>>>> patched to support a configuration file option to set 
>>>> enabled/disabled/permissive. 
>>>>
>>>> I would be glad to reopen the discussion though, if you've changed your 
>>>> mind. 
>>> I think a config option in the configuration file for the individual
>>> object manager is reasonable, with the default behavior being to track
>>> the kernel's setting.  For Xorg, we can disable just the XSELinux
>>> extension or make it permissive via xorg.conf while retaining the
>>> kernel's controls.  For PostgreSQL, I think we'd want a similar setting
>>> in its config file, whatever that might be, as long as the config file
>>> is administratively controlled.
>> Indeed, the configuration file of postgresql is labeled as postgresql_db_t
>> and it should not be modified without proper permission allowed by the policy.
>> I basically agree for your opinion.
>>
>> However, I have one unclear point of view.
>>
>> These configuration files have different security context.
>> It theoretically means different person can change the partial state.
>>
>> [root@saba ~]# ls -Z /etc/selinux/config    /etc/X11/xorg.conf  \
>>                      /var/lib/sepgsql/data/postgresql.conf
>> -rw-r--r--  root    root    system_u:object_r:selinux_config_t     /etc/selinux/config
>> -rw-r--r--  root    root    unconfined_u:object_r:etc_t            /etc/X11/xorg.conf
>> -rw-------  sepgsql sepgsql unconfined_u:object_r:postgresql_db_t  /var/lib/sepgsql/data/postgresql.conf
>>
>> I think /etc/selinux/config is better place to put these configuration
>> than /etc/X11/xorg.conf and $PGDATA/postgresql.conf
>>
>> What do you think?
>>
>> # No need to say, if a malicious user can access files labeled as postgresql_db_t,
>> # he don't need to access information stored within them via SQL. :-)
> 
> That is Eamon's view.  I'm not as clear on it.  As you note, if the
> process can directly access the raw data files, then whether or not the
> sepostgres controls are enforced on SQL queries is immaterial.  Also,
> suppose that you want to run multiple instances of postgres, where some
> instances are run single-context/level and thus do not need to act as
> object managers internally and some instances are run
> multi-context/level and do need to act as object managers internally.

Oh, I've left the case of multiple postgresql instances out of
my consideration. Indeed, the global /etc/selinux/config approach
cannot support such a situation.

Your explanation helps me to convince enough. In my current directionality,
it is the best way to add a mode parameter to turn on/off SE-PostgreSQL
feature within the postgresql configuration.

Thanks,

> The /etc/selinux/config approach doesn't seem to scale well and requires
> teaching libselinux about each new userspace object manager as they are
> introduced (which used to be true for the class and permission
> definitions, but is no longer the case due to the dynamic object class
> and permission discovery support).
> 
> Also, to fill out the picture, you also have to consider the security
> context on grub.conf and even the ability to enter kernel boot
> parameters interactively, as those can override the /etc/selinux/config
> settings.  The /etc/selinux/config SELINUX= setting was only introduced
> because of the alleged difficulty in changing kernel boot parameters on
> some platforms.

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
