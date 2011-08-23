Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NDlRTC029904
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 09:47:27 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NDlQpd028626
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 13:47:26 GMT
Message-ID: <4E53AF6E.6010108@tresys.com>
Date: Tue, 23 Aug 2011 09:47:26 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <qingtao.cao@windriver.com>
CC: <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: v2 Skip role attributes for policy.X and downgraded pp
References: <1313482132-15188-1-git-send-email-qingtao.cao@windriver.com> <4E527F26.7090802@tresys.com> <4E52FD86.3030107@windriver.com>
In-Reply-To: <4E52FD86.3030107@windriver.com>
Content-Type: text/plain; charset="windows-1252"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/22/11 21:08, Harry Ciao wrote:
> Christopher J. PeBenito 写道:
>> On 08/16/11 04:08, Harry Ciao wrote:
>>   
>>> Differnece from v1
>>> --------------------
>>> 1. Skip role attributes when pp is downgraded, as well as for policy.X.
>>>
>>>    When pp is downgraded the flavor flag and roles ebitmap would be
>>>    discarded, resulting in role attributes useless at all. So in such
>>>    case role attributes should be skipped for pp too.
>>>
>>>
>>> Tests I've done
>>> -----------------
>>> 1. Apply the role attribute test patch from Chris, adding a new test_r
>>>    role and calls rpm_run() for it.
>>>    
>>> 2. Use the apol tool to analyze what types the test_r role could type with:
>>>    (Since the apol installed on Ubuntu so far only support max version .24,
>>>     we need to setup "policy-version = 24" in semanage.conf)
>>>    
>>> Note: 
>>> . There is no role attributes such as portage/semanage/rpm_roles in policy.24
>>> . By default pp's version is 13.
>>>
>>> test_r (36 types)
>>>     bootloader_t
>>>     chfn_t
>>>     chkpwd_t
>>>     consoletype_t
>>>     ddclient_t
>>>     depmod_t
>>>     dhcpc_t
>>>     groupadd_t
>>>     hostname_t
>>>     ifconfig_t
>>>     insmod_t
>>>     iptables_t
>>>     ldconfig_t
>>>     load_policy_t
>>>     loadkeys_t
>>>     lvm_t
>>>     netutils_t
>>>     newrole_t
>>>     nscd_t
>>>     pam_t
>>>     passwd_t
>>>     ping_t
>>>     pppd_t
>>>     pptp_t
>>>     prelink_t
>>>     rpm_script_t
>>>     rpm_t
>>>     semanage_t
>>>     setfiles_t
>>>     test_t
>>>     traceroute_t
>>>     tzdata_t
>>>     updpwd_t
>>>     useradd_t
>>>     usernetctl_t
>>>     utempter_t
>>>
>>> 3. In write_binary_policy() in checkmodule.c, trigger pp downgrade
>>>    by adding "policyvers = MOD_POLICYDB_VERSION_MAX - 1;", then use
>>>    apol to analyze what types the test_r role could type with:
>>>
>>> Note:
>>> . After downgrade, pp's version is 12 now.
>>>
>>> test_r (22 types)
>>>     chfn_t
>>>     chkpwd_t
>>>     consoletype_t
>>>     ddclient_t
>>>     dhcpc_t
>>>     hostname_t
>>>     ifconfig_t
>>>     insmod_t
>>>     iptables_t
>>>     loadkeys_t
>>>     netutils_t
>>>     newrole_t
>>>     pam_t
>>>     passwd_t
>>>     ping_t
>>>     pppd_t
>>>     pptp_t
>>>     test_t
>>>     traceroute_t
>>>     updpwd_t
>>>     usernetctl_t
>>>     utempter_t
>>>
>>>    Where we can see that test_r could no longer type with all those
>>>    types that are typed by rpm_roles and semanage_roles.
>>>
>>>    (BTW, this means that once role attributes are endorsed in refpolicy,
>>>     the influence of pp downgrade could be far-reaching and perhaps
>>>     undesirable.)
>>>     
>>
>> I would not say this is undesirable, but broken instead.  The attributes
>> should be expanded out so the role has the same type set regardless of
>> the policydb version.
>>
>>   
> I agree, originally I would use "broken" too. Since the flavor flag and
> roles ebitmap won't be written into pp while module downgraded for
> compatibility issues, the relationships between role attributes and
> regular roles would be entirely wiped out, no chance could the role
> attributes ever be expanded during link and expansion.
> 
> That's why I've decided not to write role attribute at all for
> downgraded modules.
> 
> Agree?

I missed that this was a limitation only for downgrading modules.  It
makes sense that there isn't anything you can do about this.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
