Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB23K4OW028563
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 22:20:04 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kB23JNd3013762
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 03:19:23 GMT
Message-ID: <4570F0F9.7080509@tresys.com>
Date: Fri, 01 Dec 2006 22:20:25 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Linda Knippers <linda.knippers@hp.com>, James Antill <jantill@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <1165003691.18588.103.camel@code.and.org> <457094DA.4080704@hp.com> <200612021121.45703.russell@coker.com.au>
In-Reply-To: <200612021121.45703.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 02 December 2006 07:47, Linda Knippers <linda.knippers@hp.com> 
> wrote:
>   
>>> 1. Have an option for useradd to call semanage to add the selinux user,
>>> and then do the restorecon.
>>>       
>> I think useradd should be able to either create the selinux user or map the
>> linux user to an existing selinux user.  Right now you can't create an
>> selinux user without a linux login
>>     
>
> I think that this is a bug.  You should be able to create SE Linux users 
> without Linux logins, if only for the case of a NIS/LDAP server being down at 
> SE Linux user creation time.
>
>   
You can create them all you want, you just can't log in with a user that 
has a matching selinux user without a login mapping the linux user to 
the selinux user, this is by design, we don't want the implicit mapping.

>> but I think I ought to be able to create 
>> the selinux users separate and them map one or more linux login to each
>> one, or have useradd create a unique linux user for me if I choose.  And if
>> I don't choose, the linux user should end up with the correct home
>> directory based on the default selinux user.
>>     
>
> I think that part of the solution is to have semanage call useradd.
>
>   
no. semanage is managing selinux and selinux resources, not logins, not 
system resources.
>>> 2. Have semanage do the equivalent of a restorecon when doing an
>>> add/modify (or just add) of SELinux user information.
>>>       
>> If the semanage is done after the useradd (could be weeks after), the
>> user could have files that live outside the home directory (I think
>> Dan pointed this out to me) so what files and directories would you
>> run restorecon on?
>>     
>
> Also for a MLS environment you can't just relabel the files unless the new 
> sensitivity label dominates the old.  For a strict policy system it's 
> generally acceptable for relabel the files, but for MLS that won't work.
>
>   
you can if the thing relabeling is mls privileged, the useradd program 
or whatever labels the home directory would have that privilege
>>> 3. Have some kind of wrapper that does:
>>> 	i. useradd
>>> 	ii. semanage
>>> 	iii. restorecon
>>>       
>> I don't like the wrapper idea because if we can do it in a wrapper,
>> we can do it in useradd.
>>     
>
> Or semanage, or do it in both and give the sys-admin a choice.
>   
semanage does not manage system resources.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
