Message-ID: <4FE08888.7070603@tresys.com>
Date: Tue, 19 Jun 2012 10:11:20 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH kernel/tegra] enable secmark labeling for SE Android network
 access controls
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>  <1339872999-30243-4-git-send-email-jbrindle@tresys.com> <1340112403.18291.28.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1340112403.18291.28.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2012-06-16 at 14:56 -0400, Joshua Brindle wrote:
>> Signed-off-by: Joshua Brindle<jbrindle@tresys.com>
>> ---
>>   arch/arm/configs/stingray_defconfig |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/configs/stingray_defconfig b/arch/arm/configs/stingray_defconfig
>> index e67e4d5..9fe1fdd 100644
>> --- a/arch/arm/configs/stingray_defconfig
>> +++ b/arch/arm/configs/stingray_defconfig
>> @@ -459,3 +459,7 @@ CONFIG_SECURITY=y
>>   CONFIG_LSM_MMAP_MIN_ADDR=4096
>>   CONFIG_SECURITY_NETWORK=y
>>   CONFIG_SECURITY_SELINUX=y
>> +CONFIG_NETWORK_SECMARK=y
>> +CONFIG_NF_CONNTRACK_SECMARK=y
>> +CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
>> +CONFIG_NETFILTER_XT_TARGET_SECMARK=y
>
> Thanks, merged.
>
> No samsung kernel patch?
>

We are only using AOSP devices, Galaxy Nexus is Omap and Xoom is Tegra. I'll add 
the secmark configs to the other kernels but I have no way of testing them.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
