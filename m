Message-ID: <4B82E190.5060306@gmail.com>
Date: Mon, 22 Feb 2010 11:57:04 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com>	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>	 <4B7EDC9A.40801@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>	 <4B7F06F1.4070305@gmail.com>	 <1266847250.15933.23.camel@moss-pluto.epoch.ncsc.mil>	 <dd18b0c31002221127j4c22e9d1v94c037e86e7bb74e@mail.gmail.com> <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>
In-Reply-To: <dd18b0c31002221129s4be9b56cha13b7be39c2cba36@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/22/2010 11:29 AM, Justin Mattock wrote:
> On Mon, Feb 22, 2010 at 11:27 AM, Justin Mattock
> <justinmattock@gmail.com>  wrote:
>> On Mon, Feb 22, 2010 at 6:00 AM, Stephen Smalley<sds@tycho.nsa.gov>  wrote:
>>> On Fri, 2010-02-19 at 13:47 -0800, Justin P. mattock wrote:
>>>> On 02/19/2010 01:25 PM, Stephen Smalley wrote:
>>>>> On Fri, 2010-02-19 at 16:08 -0500, Alan Rouse wrote:
>>>>>> setsebool -P init_upstart=on
>>>>>> setsebool -P xdm_sysadm_login=on
>>>>>> setsebool -P xserver_object_manager=on
>>>>>
>>>>> I think you only need the first boolean setting.
>>>>> And we should likely introduce an ifdef for suse in refpolicy that
>>>>> always disables that transition so that you don't have to artificially
>>>>> turn on that boolean.
>>>>>
>>>>
>>>> as a test I built the policy with init_upstart=off
>>>> system crashes and burns with gdm/xserver(dbus error).
>>>> then changing to init_upstart=on xserver/gdm started right up.
>>>>
>>>> my question is why? especially if this is sysvinit.
>>>
>>> The refpolicy defines a domain transition from init_t to sysadm_t upon
>>> executing a shell so that the single-user mode shell is automatically
>>> run in sysadm_t, and it defines a domain transition from init_t to
>>> initrc_t upon executing an rc script (initrc_exec_t) so that rc scripts
>>> are automatically run in initrc_t.  This worked with sysvinit in Fedora
>>> and Debian.  However, upstart launches all services via shell command
>>> and thus all services would be run in sysadm_t if we kept that
>>> transition, so the refpolicy has the following logic (in
>>> system/init.te):
>>>
>>> tunable_policy(`init_upstart',`
>>>         corecmd_shell_domtrans(init_t, initrc_t)
>>> ',`
>>>         # Run the shell in the sysadm role for single-user mode.
>>>         # causes problems with upstart
>>>         sysadm_shell_domtrans(init_t)
>>> ')
>>>
>>> This snippet means:  if init_upstart=on, then transition from init_t to
>>> initrc_t upon executing a shell, else transition from init_t to sysadm_t
>>> upon executing a shell.
>>>
>>> I had suggested trying init_upstart=on in OpenSUSE because the sestatus
>>> and pstree output showed that most processes launched by init were
>>> running in sysadm_t, similar to what would happen on a system using
>>> upstart if that boolean were not enabled.
>>>
>>> This suggests that something is different about the sysvinit setup in
>>> OpenSUSE.  It might be useful to see your /etc/inittab file contents.
>>>
>>> --
>>> Stephen Smalley
>>> National Security Agency
>>>
>>>
>>
>> alright attached is dmesg and audit.log
>> both were cleaned out before the initial boot.
>>
>> yesterday I rebuilt sysvinit with the version
>> I use on my system and the patch that dan had
>> given me. but during the whole thing I can't remember
>> If I was able to bootup without the init_upstart boolean
>> turned on.(I'll rebuild that package and see if this is the case,
>> if so then this tells me that whatever/however suse built sysvinit
>> acts more like upstart(but could be wrong)).
>>
>> (BTW: I'll go(if need be) and file these, later on once
>> I get this thing cleaned and sorted out)
>>
>> --
>> Justin P. Mattock
>>
>
> hmm.. audit.log didn't go through
> resend
>


alright built sysvinit
with dan's patch he had provided me
a while back.

seems init is still hitting some dbus
thing without having init_upstart enabled.
maybe /etc/inittab is doing something.

I'll look at this today and see if I can find anything.


Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
