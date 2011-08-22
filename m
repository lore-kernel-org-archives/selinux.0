Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7ME4gqE026684
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 10:04:42 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7ME4fOt009231
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 14:04:41 GMT
Received: by gwj20 with SMTP id 20so4520970gwj.12
        for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 07:04:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <SNT139-W4228F2147CEF20A92FA2A1AB2F0@phx.gbl>
References: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com>
	<SNT139-W4228F2147CEF20A92FA2A1AB2F0@phx.gbl>
Date: Mon, 22 Aug 2011 10:04:41 -0400
Message-ID: <CACLa4pvPb74dHDnWJS1UgyLYDWwGrmuS6F=ANCKgqNT4_vf9Aw@mail.gmail.com>
Subject: Re: v2 Skip role attributes for policy.X and downgraded pp
From: Eric Paris <eparis@parisplace.org>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: slawrence@tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've applied to the 'queue' branch and will likely send along in my
next push, probably some time this week.  In the mean time you could
develop against the queue branch.  Be aware that the 'queue' branch
constantly rebases and should not been seen as anything more than a
random snapshot in time of my personal development.  Side note is that
if you send me a patch based off of a queue branch snapshot it'll
likely apply to whatever I have, and if it doesn't I'll likely be able
to figure out why.

-Eric

2011/8/22 HarryCiao <harrytaurus2002@hotmail.com>:
> Hi Steve,
>
> How do you feel about this patch? Right now I am trying to test my patchset
> to separate tunables from booleans, unfortunately one of them would have to
> be based on this patch. Once you are happy with it and merge it, I could
> create my patchset based on the latest master branch.
>
> Thanks a lot!
>
> Best regards,
> Harry
>
>> From: qingtao.cao@windriver.com
>> To: slawrence@tresys.com
>> CC: selinux@tycho.nsa.gov
>> Subject: v2 Skip role attributes for policy.X and downgraded pp
>> Date: Tue, 16 Aug 2011 16:08:51 +0800
>>
>>
>> Differnece from v1
>> --------------------
>> 1. Skip role attributes when pp is downgraded, as well as for policy.X.
>>
>> When pp is downgraded the flavor flag and roles ebitmap would be
>> discarded, resulting in role attributes useless at all. So in such
>> case role attributes should be ! skipped for pp too.
>>
>>
>> Tests I've done
>> -----------------
>> 1. Apply the role attribute test patch from Chris, adding a new test_r
>> role and calls rpm_run() for it.
>>
>> 2. Use the apol tool to analyze what types the test_r role could type
>> with:
>> (Since the apol installed on Ubuntu so far only support max version .24,
>> we need to setup "policy-version = 24" in semanage.conf)
>>
>> Note:
>> . There is no role attributes such as portage/semanage/rpm_roles in
>> policy.24
>> . By default pp's version is 13.
>>
>> test_r (36 types)
>> bootloader_t
>> chfn_t
>> chkpwd_t
>> consoletype_t
>> ddclient_t
>> depmod_t
>> dhcpc_t
>> groupadd_t
>> hostname_t
>> ifconfig_t
>> insmod_t
>> iptables_t
>> ldconfig_t
>> load_policy_t
>> loadkeys_t!
>> lvm_t
>> netutils_t
>> newrole_t
> &gt ; nscd_t
>> pam_t
>> passwd_t
>> ping_t
>> pppd_t
>> pptp_t
>> prelink_t
>> rpm_script_t
>> rpm_t
>> semanage_t
>> setfiles_t
>> test_t
>> traceroute_t
>> tzdata_t
>> updpwd_t
>> useradd_t
>> usernetctl_t
>> utempter_t
>>
>> 3. In write_binary_policy() in checkmodule.c, trigger pp downgrade
>> by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1;", then use
>> apol to analyze what types the test_r role could type with:
>>
>> Note:
>> . After downgrade, pp's version is 12 now.
>>
>> test_r (22 types)
>> chfn_t
>> chkpwd_t
>> consoletype_t
>> ddclient_t
>> dhcpc_t
>> hostname_t
>> ifconfig_t
>> insmod_t
>> iptables_t
>> loadkeys_t
>> netutils_t
>> newrole_t
> &gt! ; pam_t
>> passwd_t
>> ping_t
>> pppd_t
>> pptp_t
>> test_t
>> traceroute_t
>> updpwd_t
>> usernetctl_t
>> utempter_t
>>
>> Where we can see that test_r could no longer type with all those
>> types that are typed by rpm_roles and semanage_roles.
>>
>> (BTW, this means that once role attributes are endorsed in refpolicy,
>> the influence of pp downgrade could be far-reaching and perhaps
>> undesirable.)
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
