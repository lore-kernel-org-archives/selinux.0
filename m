Message-ID: <43D1553B.3090701@tresys.com>
Date: Fri, 20 Jan 2006 16:25:15 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>	<1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>	<1137784500.31152.6.camel@twoface.columbia.tresys.com> <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-01-20 at 14:14 -0500, Joshua Brindle wrote:
> 
>>attached patch addresses all of the concerns with the prior patch. The
>>main change is to make a function called semanage_access_check that
>>returns error, existance, readable or writable. Depending on where the
>>check is done test against one of them. 
>>
>>I am now able to query the store as a non-root user after giving read
>>access to /modules and /modules/active{,/*} and read/write to
>>modules/semanage.read.LOCK
>>
>>as expected I can query the store but not write to it, I also added a
>>check for writability at the beginning of begin_transaction so that the
>>user gets a nicer error when this happens.
> 
> 
> Better, but a few lingering issues/questions:
> 1) Running semanage as a non-root user with existing default modes on
> the policy module tree yields "SELinux policy is not managed."
> So we aren't quite providing the right information to the user yet.
>
if the user can't stat the module directory how do we know whether or 
not it is a managed system?


> 2) I'm still not sure about the check on the binary policy install
> directory; not all "write" operations truly require rebuilding the
> kernel binary policy, and we already have rollback code if that
> installation fails, so I suspect that the writability check on the
> active module store is good enough here.
> 
Only seuser doesn't require a policy rebuild, though I guess you could 
build in alternate stores without installing..

I guess that can be removed.

> 3) I normally would have expected checking write access to the container
> directory for the lock file rather than checking access to the lock file
> itself, but I suppose since you create the lock file on the first
> transaction and never remove it and use lockf for locking, it should
> always exist if the store itself has been initialized?
> 
the lock files are generally persistent, the current locking mechanism 
uses lockf instead of just testing for existence since lockf will 
release the lock on application exit.

I'd rather not give read only clients access to write to the module 
directory, even though it shouldn't matter as long as the active and 
previous directories are protected.

As far as querying goes read/write on the lock file is the absolute 
minimum required, so if that works they'll be able to query the store, 
which is what the access check should be checking. The only permission 
really needed to query the store could be lock but since the open call 
tries to create it if it doesn't exist, and also truncate then we have 
to allow read and write (also access doesn't have the ability to just 
test for lock)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
