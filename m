Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5K6KDkE031802
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 02:20:13 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5K6KCrK001122
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 06:20:12 GMT
Received: by py-out-1112.google.com with SMTP id u52so188519pyb
        for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 23:20:12 -0700 (PDT)
Message-ID: <4678C6A4.4070306@gmail.com>
Date: Wed, 20 Jun 2007 14:18:12 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: three problems about normal user login in strict policy
References: <4667F878.9030805@gmail.com>	 <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>	 <1181224077.6578.92.camel@sgc.columbia.tresys.com>	 <1181224459.11979.7.camel@moss-spartans.epoch.ncsc.mil>	 <1181242131.6578.96.camel@sgc.columbia.tresys.com>	 <46778C6B.50307@gmail.com> <1182253877.15064.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1182253877.15064.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=GB18030
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-06-19 at 15:57 +0800, Ken YANG wrote:
>> Christopher J. PeBenito wrote:
>>> On Thu, 2007-06-07 at 09:54 -0400, Stephen Smalley wrote:
>>>> On Thu, 2007-06-07 at 13:47 +0000, Christopher J. PeBenito wrote:
>>>>> On Thu, 2007-06-07 at 09:34 -0400, Stephen Smalley wrote:
>>>>>> On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
>>>>>>> i studied the point from walsh about non-root X login,
>>>>>>> see details in following thread:
>>>>>>>
>>>>>>> http://marc.info/?l=selinux&m=118050940823692&w=2
>>>>>>>
>>>>>>> when i login with normal user(user_u), i have some questions:
>>>>>>> (i'm in fc7 with strict-mcs policy at svn version 2301)
>>>>>>>
>>>>>>> 1
>>>>>>> when i login as user_u, i find i can not switch to staff_u through su,
>>>>>>> but i notice that there is corresponding line in "default_contexts" file:
>>>>>> The su / pam_selinux integration was reverted a while ago, so su no
>>>>>> longer changes contexts at all, just like in the original SELinux.  
>>>>>> Thus, the SELinux user identity is once again stable for the entire
>>>>>> session, and you have to use newrole to switch roles.  And user_r isn't
>>>>>> generally allowed to switch to staff_r; you need to map your Linux user
>>>>>> identity to staff_u via semanage.
>> sorry for reply so late, i just covered walsh's blog, and
>> reviewed some points about selinux user, but i still had 2
>> questions:
>>
>> now that su/pam_selinux will not change selinux user id,
>> and user_r cannt switch to staff_r, what is the function
>> of "user_r:user_su_t:s0 staff_r:staff_t:s0..." line in
>> "default_context", and where is it used?
> 
> They are obsolete and can be removed, unless they are just being left
> for compatibility in case someone wants to re-insert pam_selinux
> into /etc/pam.d/su.

thanks, smalley and pebenito.

BTW, as you know, i am not English-native, and know little about
english culture, so i'm not sure is it appropriate to call your
first name directly? if impolite, please correct me


> 
>> another question is:
>>
>> i declared a user in policy:
>>
>> gen_user(ken, user, user_r, s0, s0)
> 
> Unnecessary - you should be mapping Linux usernames to SELinux users via
> semanage login.  The mapping is then stored
> in /etc/selinux/$SELINUXTYPE/seusers.  It is not necessary anymore to
> add the Linux usernames to the kernel policy; you can just map them to
> SELinux users already defined in the kernel policy, where those SELinux
> users are generic ways of identifying authorized role sets.

i understand what you mean, originally, i want to validate my guess,
but as you said, it is unnecessary. anyway, thanks

> 
>> "ken" is my linux login user, i think if login program find the
>> same SELinux user and linux user identity, it will use the "ken"
>> in the context for the initial shell process, but after i login
>> through tty2, and execute "id -Z", i found my user in context
>> was still user_u, i.e. user_u:user_r:user_t:s0.
>>
>> is there something i missing?
> 
> Yes, seusers.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
