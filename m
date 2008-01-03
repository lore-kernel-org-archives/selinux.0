Message-ID: <477D1A9D.7000900@martinorr.name>
Date: Thu, 03 Jan 2008 17:25:49 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Chris PeBenito <pebenito@gentoo.org>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Xorg modprobe denials
References: <47673B12.6040205@tycho.nsa.gov>	 <1197949627.4790.4.camel@defiant.pebenito.net>	 <1197984841.7967.5.camel@moss-spartans.epoch.ncsc.mil>	 <1197986223.7967.17.camel@moss-spartans.epoch.ncsc.mil>	 <476988ED.4070003@martinorr.name> <1199374256.12626.292.camel@gorn.columbia.tresys.com>
In-Reply-To: <1199374256.12626.292.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/01/08 15:30, Christopher J. PeBenito wrote:
> On Wed, 2007-12-19 at 21:11 +0000, Martin Orr wrote:
>> On 18/12/07 13:57, Stephen Smalley wrote:
>>> On Tue, 2007-12-18 at 08:34 -0500, Stephen Smalley wrote:
>>>> On Mon, 2007-12-17 at 22:47 -0500, Chris PeBenito wrote:
>>>>> Based on the other kernel messages, I'm guessing that the insmod
>>>>> succeeded despite the tty and capability denials?  If so I suppose we
>>>>> can dontaudit it.
>>>> I don't think we want to dontaudit the capability denials.
>>> And just to note, denials from insmod can be triggered either by
>>> userspace activity of insmod or by the module initialization code of the
>>> loaded module.
>> I find that on an SMP machine I need both the sys_nice capabability and
>> setsched on kernel_t to load modules.
>>
>> This is because stop_machine() is called by sys_init_module(), so it makes
>> sense to me to add these to kernel_load_module().
>>
>> Index: policy/modules/kernel/kernel.if
>> ===================================================================
>> --- policy/modules/kernel/kernel.if	(revision 2560)
>> +++ policy/modules/kernel/kernel.if	(working copy)
>> @@ -330,6 +330,9 @@
>>
>>  	allow $1 self:capability sys_module;
>>  	typeattribute $1 can_load_kernmodule;
>> +
>> +	allow $1 self:capability sys_nice;
>> +	kernel_setsched($1)
>>  ')
> 
> Are these rules are inherent to anything that loads a module or specific
> to insmod?  This patch only makes sense if its the former.
>

It happens inside the init_module system call in the kernel, so anything
that loads a module needs it.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
