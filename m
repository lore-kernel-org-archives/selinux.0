Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99NHc9t031246
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 19:17:38 -0400
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99NHc8h027838
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 23:17:38 GMT
Cc: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <668EB1B5-63B3-4491-8904-619127F6DE67@nall.com>
From: Joe Nall <joe@nall.com>
To: Joshua Brindle <method@manicmethod.com>
In-Reply-To: <48EE688E.8040507@manicmethod.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: per role template confusion
Date: Thu, 9 Oct 2008 18:17:35 -0500
References: <00473A36-B9E3-4481-A2AC-7D5623741AB5@nall.com> <48EE688E.8040507@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 9, 2008, at 3:24 PM, Joshua Brindle wrote:

> Joe Nall wrote:
>> Can someone explain the per role template implementation? I am  
>> confused.
>>
>> During policy compilation, a .mod.role file is created that just  
>> references the roles in /usr/share/selinux/devel/include/rolemap  
>> regardless of the roles defined via semanage. Should semanage add  
>> roles to rolemap? Is there additional magic in semodule?
>>
>> joe
>
> Roles aren't created by semanage, only user->role mappings. The  
> per_role_template creates derived types for each role (eg.,  
> staff_mozilla_t, sysadm_mozilla_t). These roles are defined in the  
> policy only.

Ok. I thought the role statement just did type mapping and did not  
realize there was an implicit role declaration.

I would still like an explanation of how this works and if/how new  
roles are handled with respect to per role templates.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
