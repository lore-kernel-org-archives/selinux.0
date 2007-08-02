Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72HhEE6009617
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 13:43:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72Hh6ev029281
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 17:43:06 GMT
Message-ID: <46B21774.4070809@redhat.com>
Date: Thu, 02 Aug 2007 13:42:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: strict/targeted merge snag
References: <1186069401.4015.81.camel@gorn.columbia.tresys.com>	 <46B20032.60203@redhat.com> <1186073552.4015.88.camel@gorn.columbia.tresys.com>
In-Reply-To: <1186073552.4015.88.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 12:02 -0400, Daniel J Walsh wrote:
>   
>> Christopher J. PeBenito wrote:
>>     
>>> If you're not familiar, the Reference Policy project is in the process
>>> of merging the strict and targeted policies so that they no longer are
>>> build options.  The idea behind this is that a user can incrementally
>>> confine their system until they finally arrive at what is currently
>>> considered the strict policy, without completely replacing the policy.
>>>
>>> The way it works now is that if the unconfined module is not included in
>>> the policy, the policy will be just like the strict policy now.  Once
>>> the unconfined module is inserted, the policy will be similar to the
>>> targeted policy now, with some differences.  Instead of using only one
>>> role for the entire system, the confined roles (staff_r, sysadm_r, etc)
>>> remain, and a new unconfined role is added.  This allows a mix of
>>> confined and unconfined users on the system.  A handfull of domains will
>>> also become unconfined, just like the targeted policy.
>>>
>>> The issue that I just ran into has to do with the file contexts.
>>> Currently most of the per_role_templates() have a corresponding set of
>>> file contexts with HOME_DIR as part of the file specification.  In the
>>> past, this has not been a problem since they are ifdef'ed out on the
>>> targeted policy, and the per_role_templates() are expanded for each of
>>> the user roles in the strict policy.  However, now strict and targeted
>>> are the same policy, so if you map a linux user to unconfined_u,
>>> genhomedircon expands out all of the HOME_DIR lines for unconfined, and
>>> only a couple of the contexts are valid.
>>>
>>> This will also be more of an issue going forward since additional user
>>> roles are desired, and would like the per_role_templates() to be
>>> explicitly called rather than done under the hood, so that the user
>>> roles can be specified with a subset of the available
>>> per_role_templates().
>>>
>>> Thoughts?
>>>
>>>   
>>>       
>> genhomedircon now checks if the contexts are valid before assiging 
>> them.  So if it
>> thinks you need a xyz_gnome_t and the kernel says that does not exist, 
>> genhomedircon
>> throws it away.  Been that way in Fedora for a while,
>>     
>
> Its not in the stable branch.  Also asking the kernel is not the correct
> solution if libsemanage is working on a policy thats not active.
>
>   

I am not sure genhomedircon is doing the right thing on the inactive 
policies now.  Since it is calling out to the system to get the policy 
path.  genhomedircon uses libselinux to find current policy not relying 
on libsemanage for this info.

Since this is advanced policy work, shouldn't you use the development 
policycoreutils?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
