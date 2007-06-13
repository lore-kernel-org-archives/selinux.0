Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5D2Zk7L000668
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 22:35:46 -0400
Received: from wa-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5D2ZiRP015699
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 02:35:45 GMT
Received: by wa-out-1112.google.com with SMTP id j5so65005wah
        for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 19:35:44 -0700 (PDT)
Message-ID: <466F5726.1090901@gmail.com>
Date: Wed, 13 Jun 2007 10:32:06 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: three problems about normal user login in strict policy
References: <4667F878.9030805@gmail.com>	 <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>	 <1181224077.6578.92.camel@sgc.columbia.tresys.com>	 <1181224459.11979.7.camel@moss-spartans.epoch.ncsc.mil> <1181242131.6578.96.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181242131.6578.96.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=GB18030
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


thanks for all of your reply.

i am learning walsh blog, i hope i can figure out all points
about user management in SELinux through all of your replies,
walsh blog, policy source, and etc...

anyway, thanks again


Christopher J. PeBenito wrote:
> On Thu, 2007-06-07 at 09:54 -0400, Stephen Smalley wrote:
>> On Thu, 2007-06-07 at 13:47 +0000, Christopher J. PeBenito wrote:
>>> On Thu, 2007-06-07 at 09:34 -0400, Stephen Smalley wrote:
>>>> On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
>>>>> i studied the point from walsh about non-root X login,
>>>>> see details in following thread:
>>>>>
>>>>> http://marc.info/?l=selinux&m=118050940823692&w=2
>>>>>
>>>>> when i login with normal user(user_u), i have some questions:
>>>>> (i'm in fc7 with strict-mcs policy at svn version 2301)
>>>>>
>>>>> 1
>>>>> when i login as user_u, i find i can not switch to staff_u through su,
>>>>> but i notice that there is corresponding line in "default_contexts" file:
>>>> The su / pam_selinux integration was reverted a while ago, so su no
>>>> longer changes contexts at all, just like in the original SELinux.  
>>>> Thus, the SELinux user identity is once again stable for the entire
>>>> session, and you have to use newrole to switch roles.  And user_r isn't
>>>> generally allowed to switch to staff_r; you need to map your Linux user
>>>> identity to staff_u via semanage.
>>>>
>>>>> user_r:user_su_t:s0     staff_r:staff_t:s0 user_r:user_t:s0
>>>>> sysadm_r:sysadm_t:s0
>>>>>
>>>>> and in the policy, i found the condition of su domain transition have
>>>>> satisfied, including su_exec_t entrypoint and type_transition rules,
>>>>> furthermore, i also meet the constrain conditon in
>>>>> su_per_role_template(), e.g. domain_role_change_exemption($1_su_t),
>>>>> domain_subj_id_change_exemption($1_su_t),
>>>>> domain_obj_id_change_exemption($1_su_t), and etc.
>>>> Hmm...seems like those should be removed from policy (unless some distro
>>>> tunable is set for older fedora or rhel4), as su should no longer be
>>>> making such transitions.
>>> Its in a rhel4 build option.
>> Hmmm...so why is it still showing up in F7 strict policy?
> 
> He's just looking at the su.if header (hence the $1_su_t references),
> which is just copied out of the refpolicy sources as is.  So its in the
> headers, but shouldn't be in the actual policy.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
