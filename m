Message-ID: <43BAA615.9000605@tresys.com>
Date: Tue, 03 Jan 2006 11:28:05 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
   dwalsh@redhat.com
Subject: Re: [SEMANAGE][SEPOL] Enable ports
References: <43ACADB3.7070509@cornell.edu> <43B97823.3080201@tresys.com> <43B9761A.3070504@cornell.edu> <43BA267D.2010905@cornell.edu>
In-Reply-To: <43BA267D.2010905@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>> . Adding the "limited intelligence" with respect to error checking is 
>> much more difficult in libsemanage, and I've wasted lots of time on 
>> this. It's easier to do in the client.
> 
> 
> Actually.... not true. It's difficult to add at the key level, but error 
> checks and warnings and things like that will easily go into a verify 
> run on commit (or possibly in sepol). So, now I think I'll focus on:
> 
Must do it within semanage since sepol won't know where they came from 
and if they are allowed to shadow entries.

> - seuser validation (mls range valid, mls range subset of selinux user, 
> possibly move Unix user check into lib?)
> - file context validation (context valid, maybe regexp valid?)
>    It should be possible to do those two now, after new additions to 
> libsepol interface.
> 
> - ports error checking (warn on shadowing, things like that)
> - also, did you know that if you originally put a file with duplicate 
> records in semanage, it would stay that way, and semanage wouldn't 
> complain (it does no duplicate checking when reading in the file - not 
> sure if that's a problem).
> 
Any local should shadow/override something in the policy without a 
warning, that is the whole point to local settings, particularly with 
ports and interfaces. Any service port (1-1024) will be 'shadowed' by 
something in the policy but should be able to be overridden by ports.local.

> Also, there's issues with the API, which I posted about on 
> SELinux-dev@tresys - if API changes are still allowed I'm considering 
> removing the set function, changing the behavior of add, and compare for 
> each record. See "API message still ok" for details.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
