Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KMcIi015850
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:22:38 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KKwPU022750
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:21:01 GMT
Message-ID: <41B8B409.4070807@redhat.com>
Date: Thu, 09 Dec 2004 15:22:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Russell Coker <rcoker@redhat.com>
CC: Colin Walters <walters@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
References: <20041207000805.GH3678@jmh.mhn.de>	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>	 <41B8826D.30105@redhat.com>	 <1102613299.10785.21.camel@nexus.verbum.private>	 <1102615344.4509.39.camel@aeon>  <41B8AB69.1060805@redhat.com> <1102623195.4509.86.camel@aeon>
In-Reply-To: <1102623195.4509.86.camel@aeon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Thu, 2004-12-09 at 14:45 -0500, Daniel J Walsh wrote:
>  
>
>>>A bug IMHO.  If we have two roles that become almost equivalent then the
>>>sensible thing to do is remove one.  If we decide that for Fedora strict
>>>policy we don't want to have any regular users be denied the ability
>>>perform administrative tasks then the correct thing to do is to make
>>>staff_r the default user role.
>>>
>>>      
>>>
>>I want to go back to the separation between user and staff without the 
>>differences in file system.
>>    
>>
>
>That's impossible.  If you can write to someone's .bashrc file or
>similar then you can get their privs.
>  
>
So we either go to full MAC which few people will use, or we have to 
rely partially on DAC for protection.
I am looking for a way to raise the bar on policy without making a multi 
use machine unmanageable. 


BTW I like the idea of defaulting to staff_r.  I think we should do that 
and turn off user_canbe_sysadm.

>  
>
>>>It's easy enough for anyone to add a new role if they need more roles
>>>than the default policy provides.
>>>
>>>      
>>>
>>Not without relabing the file system.
>>    
>>
>
>The expected practice should be to create the role before creating the
>user who will have it.  This means that there should not be a need to
>relabel.  There is only a need to relabel if you change the roles that
>are permitted after the machine has been running.  But that also means
>you may have to have the user logout first to prevent processes becoming
>unlabeled.
>
>  
>
Yes that is all well in good, but it does not work that way in the real 
world.  Admins
are going to want to be able to change peoples roles.

>>  Currently if I want to add a new 
>>role, say student that has less privs
>>then user,  I need to massively rewrite the policy.  If we came up with 
>>a policy that shared homedir and tmpdir
>>file contexts between all types of users, I could begin to create 
>>additional default roles for people.
>>    
>>
>
>For what benefit?  If they share file types and they share X access
>(with xdm logins) then what benefits can we gain from multiple roles?
>
>Multiple roles will still increase administrative overhead even without
>multiple file types.  So multiple roles with the same types gives you
>some of the overhead with almost none of the benefit.
>
>  
>
Roles can be used to govern which applications can be run.  So I could 
have a student role where only
student applications could be run. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
