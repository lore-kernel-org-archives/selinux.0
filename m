Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6VIOxTr013868
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2008 14:24:59 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6VIOv0w023575
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2008 18:24:57 GMT
Message-ID: <48920374.50508@kutulu.org>
Date: Thu, 31 Jul 2008 14:24:52 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy patch, second try] samba policy updates
References: <488DED3A.1030005@kutulu.org>	 <1217342823.4934.42.camel@defiant.pebenito.net>	 <488F5590.6060908@kutulu.org> <1217361293.5525.13.camel@gorn.pebenito.net>	 <488F8A31.8070301@kutulu.org>	 <1217509017.4114.40.camel@gorn.columbia.tresys.com>	 <4891E7FA.9040807@kutulu.org> <1217527566.4114.59.camel@gorn.columbia.tresys.com>
In-Reply-To: <1217527566.4114.59.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2008-07-31 at 12:27 -0400, Mike Edenfield wrote:
>> Christopher J. PeBenito wrote:
>>
>>> Interfaces should not have side effects.  If you have a create interface
>>> and it does something else like filetrans, filetrans is a side effect.
>>> The tunable should be:
>>>
>>> tunable_policy(
>>>   unprivuser_create_home_dirs()
>>>   unprivuser_home_filetrans_home_dir()
>>> )
>> Ok, I think I get it now.  Sorry for being kinda dense :)
>>
>> So, what I should have dome is something like this:
>>
>> tunable_policy (
>>    unprivuser_home_filetrans_home_dir()
>>    unprivuser_create_home_dir()
>>    unprivuser_add_entry_home_dir()
>> )
>>
>>
>> with two new interfaces:
>>
>> unprivuser_create_home_dir (
>>    allow user_home_dir_t:dir create_dir_perms
>> )
>>
>> unprivuser_add_entry_home_dir (
>>    allow user_home_dir_t:dir add_entry_dir_perms
>> )
> 
> Why do you need the add_entry?  You just want to create
> the /home/foouser directory right?  Add_entry is for when you want to
> create an object in that type of directory.

Well, I do actually want to create objects in the new home directory. 
It needs to be populated from /etc/skel (which the PAM module does 
automatically).

But it turns out that the existing samba policy already takes care of 
this, *if* you also turn on "enable_home_dirs", so its not needed here. 
  It does mean that the "create" tunable, without the "enable" tunable, 
creates an empty home directory, which I was trying to minimize.  But as 
I think about it, it probably doesn't make sense to have Samba create 
user home directories if you're not going to allow Samba to share them 
out, so it's probably ok.

New patch coming up.

--Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
