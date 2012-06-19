Message-ID: <4FE0D54B.1020703@tresys.com>
Date: Tue, 19 Jun 2012 15:38:51 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH kernel/goldfish] enable secmark labeling for SE Android
 network access controls
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>  <1339872999-30243-6-git-send-email-jbrindle@tresys.com> <1340107289.18291.15.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1340107289.18291.15.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2012-06-16 at 14:56 -0400, Joshua Brindle wrote:
>> Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
>> ---
>>   arch/x86/configs/i386_defconfig |    4 ++++
>>   1 file changed, 4 insertions(+)
>
> I would have expected these changes to go into
> arch/x86/configs/goldfish_defconfig,
> arch/arm/configs/goldfish_defconfig, and
> arch/arm/configs/goldfish_armv7_defconfig.
>

Wondering why this worked (since it is obviously the wrong config) I looked at 
the above files. It appears that the x86 goldfish_defconfig already had it (I 
didn't test on an ARM emulator):

android/kernel/goldfish/arch/x86/configs$ git blame goldfish_defconfig | grep 
SECMARK
b2069ffd (Jun Nakajima         2011-03-06 23:12:13 -0800  453) 
CONFIG_NETWORK_SECMARK=y
b2069ffd (Jun Nakajima         2011-03-06 23:12:13 -0800  464) 
CONFIG_NF_CONNTRACK_SECMARK=y
b2069ffd (Jun Nakajima         2011-03-06 23:12:13 -0800  470) 
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
b2069ffd (Jun Nakajima         2011-03-06 23:12:13 -0800  473) 
CONFIG_NETFILTER_XT_TARGET_SECMARK=y


I'll apply it to the arm configs and resubmit.



>> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
>> index edba00d..09db997 100644
>> --- a/arch/x86/configs/i386_defconfig
>> +++ b/arch/x86/configs/i386_defconfig
>> @@ -2128,6 +2128,10 @@ CONFIG_SECURITY_NETWORK=y
>>   CONFIG_SECURITY_FILE_CAPABILITIES=y
>>   # CONFIG_SECURITY_ROOTPLUG is not set
>>   CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=65536
>> +CONFIG_NETWORK_SECMARK=y
>> +CONFIG_NF_CONNTRACK_SECMARK=y
>> +CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
>> +CONFIG_NETFILTER_XT_TARGET_SECMARK=y
>>   CONFIG_SECURITY_SELINUX=y
>>   CONFIG_SECURITY_SELINUX_BOOTPARAM=y
>>   CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
