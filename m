Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KBgTbu013197
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 07:42:29 -0400
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5KBgRAt016028
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 11:42:27 GMT
Received: by nz-out-0506.google.com with SMTP id v1so156436nzb
        for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 04:42:27 -0700 (PDT)
Message-ID: <4679122C.7030006@gmail.com>
Date: Wed, 20 Jun 2007 19:40:28 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: three problems about normal user login in strict policy
References: <4667F878.9030805@gmail.com>	 <1181223271.11979.4.camel@moss-spartans.epoch.ncsc.mil>	 <1181224077.6578.92.camel@sgc.columbia.tresys.com>	 <1181224459.11979.7.camel@moss-spartans.epoch.ncsc.mil>	 <1181242131.6578.96.camel@sgc.columbia.tresys.com>	 <46778C6B.50307@gmail.com> <1182253877.15064.13.camel@moss-spartans.epoch.ncsc.mil> <4678C6A4.4070306@gmail.com> <4679037B.7090908@redhat.com>
In-Reply-To: <4679037B.7090908@redhat.com>
Content-Type: text/plain; charset=gb18030
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Ken YANG wrote:
>> Stephen Smalley wrote:
>>  
>>> On Tue, 2007-06-19 at 15:57 +0800, Ken YANG wrote:
>>>    
>>>> Christopher J. PeBenito wrote:
>>>>      
>>>>> On Thu, 2007-06-07 at 09:54 -0400, Stephen Smalley wrote:
>>>>>        
>>>>>> On Thu, 2007-06-07 at 13:47 +0000, Christopher J. PeBenito wrote:
>>>>>>          
>>>>>>> On Thu, 2007-06-07 at 09:34 -0400, Stephen Smalley wrote:
>>>>>>>            
>>>>>>>> On Thu, 2007-06-07 at 20:22 +0800, Ken YANG wrote:
>>>>>>>>              
>>>>>>>>> i studied the point from walsh about non-root X login,
>>>>>>>>> see details in following thread:
>>>>>>>>>
>>>>>>>>> http://marc.info/?l=selinux&m=118050940823692&w=2
>>>>>>>>>
>>>>>>>>> when i login with normal user(user_u), i have some questions:
>>>>>>>>> (i'm in fc7 with strict-mcs policy at svn version 2301)
>>>>>>>>>
>>>>>>>>> 1
>>>>>>>>> when i login as user_u, i find i can not switch to staff_u
>>>>>>>>> through su,
>>>>>>>>> but i notice that there is corresponding line in
>>>>>>>>> "default_contexts" file:
>>>>>>>>>                 
>>>>>>>> The su / pam_selinux integration was reverted a while ago, so su no
>>>>>>>> longer changes contexts at all, just like in the original
>>>>>>>> SELinux.  Thus, the SELinux user identity is once again stable
>>>>>>>> for the entire
>>>>>>>> session, and you have to use newrole to switch roles.  And
>>>>>>>> user_r isn't
>>>>>>>> generally allowed to switch to staff_r; you need to map your
>>>>>>>> Linux user
>>>>>>>> identity to staff_u via semanage.
>>>>>>>>               
>>>> sorry for reply so late, i just covered walsh's blog, and
>>>> reviewed some points about selinux user, but i still had 2
>>>> questions:
>>>>
>>>> now that su/pam_selinux will not change selinux user id,
>>>> and user_r cannt switch to staff_r, what is the function
>>>> of "user_r:user_su_t:s0 staff_r:staff_t:s0..." line in
>>>> "default_context", and where is it used?
>>>>       
>>> They are obsolete and can be removed, unless they are just being left
>>> for compatibility in case someone wants to re-insert pam_selinux
>>> into /etc/pam.d/su.
>>>     
>>
>> thanks, smalley and pebenito.
>>
>> BTW, as you know, i am not English-native, and know little about
>> english culture, so i'm not sure is it appropriate to call your
>> first name directly? if impolite, please correct me
>>
>>   
> First names are fine.

thanks.

at first, i think i should call you first name, because foreign
friends in our country often call me the first name(ken).

but many people will call the president of US "bush"(as i know,
bush is his last name), and when i am watching NBA, you call
"Ming YAO" as YAO (Ming YAO is a chinese basketball player,
YAO is his last name), so i change to call you last name,
but i am afraid i will offend some people if i call the
wrong name.

anyway, i know this isn't appropriate place to discuss this topic.
thanks

BTW, walsh, your blog is fantastic, i subscribe your blog and
learn a lot from it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
