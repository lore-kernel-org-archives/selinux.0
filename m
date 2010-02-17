Message-ID: <4B7C0CB2.8020103@gmail.com>
Date: Wed, 17 Feb 2010 07:35:14 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Dominick Grift <domg472@gmail.com>, Alan Rouse <alan.rouse@ericsson.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com>  <4B7B97D4.7020005@gmail.com> <1266414196.4945.8.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266414196.4945.8.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/17/2010 05:43 AM, Stephen Smalley wrote:
> On Tue, 2010-02-16 at 23:16 -0800, Justin P. mattock wrote:
>> o.k. I think I thought too much on the subject
>> (I need to stop building systems from scratch
>> i.g. all I can think of is/are switches to enable).
>>
>> Anyways I figured out the problem seems easier
>> than I had expected:
>>
>> with a fresh build of suse 11.2, then
>> under yast adding the correct SELinux
>> apps/libs, then adjusting grub(in the control
>> center thing).
>>
>> reboot
>>
>> you hit a broken gdm dbus thing.
>>
>> under /var/log/gdm/:5-greeter.log
>>
>> there is an error message with dbus:
>>
>> Failed to start message bus: Failed to open
>> "/etc/selinux/targeted/contexts/dbus_contexts": No such file or directory
>> EOF in dbus-launch reading address from dbus daemon.
>>
>> so after reading that then looking at /etc/selinux/refpolicy-standard
>> I decided to just cp -R refpolicy-standard targeted(reboot)
>> and voila the system boots gdm starts, life is good with suse
>> (I guess there not the darkside after all!!).
>>
>> as for the real problem I'm guessing whatever is telling
>> dbus-launch to look for /etc/selinux/targeted
>> is the problem.
>>
>> Alan does just a simple renaming of refpolicy to targeted
>> at least get you up and running(if not use suses policy,
>> and rename it to targeted, until I can find what dbus launch script is
>> calling for that policy name).
>
> Interesting.  On Fedora, /etc/dbus-1/system.conf and session.conf
> contain this directive to include the selinux configuration for dbus:
> <include if_selinux_enabled="yes" selinux_root_relative="yes">contexts/dbus_contexts</include>
>
> This avoids any hardcoded dependency on the location of the configuration file.
> The dbus code uses the selinux_policy_root() function provided by
> libselinux to find the root of the policy directory.
>
> It should be using the SELINUXTYPE= definition in /etc/selinux/config to
> select the active policy root.
>


I'll go through and look at those files
to see what/where is giving the hardcoded call
like that.

main thing is suse doesn't crap out.
I can login, connect function as if nothing
was ever wrong.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
