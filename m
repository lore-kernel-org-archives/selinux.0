Message-ID: <43D50568.3060201@tresys.com>
Date: Mon, 23 Jan 2006 11:33:44 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>	<1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>	<1137784500.31152.6.camel@twoface.columbia.tresys.com>	<1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>	<43D1553B.3090701@tresys.com>	<1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>	<43D4ED7A.3090805@tresys.com>	<1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>	<43D4F8DD.30705@tresys.com> <1138031978.20815.103.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138031978.20815.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-01-23 at 10:40 -0500, Joshua Brindle wrote:
> 
>>speaking of the create_store code path, That function is no longer in 
>>use and it was primarily used for bootstrapping non-managed systems so I 
>>didn't remove it yet but we can probably just require the package 
>>manager or make scripts to initialize the store and remove this from the 
>>library entirely.
> 
> 
> Hmm...I missed that side effect.  Moving aside my module store and
> trying to re-install the base module from /usr/share/selinux does indeed
> fail against the new libsemanage (upon connect).  So the policy package
> would have to pre-create the directory tree and the lock files so that
> the connect could succeed?  I'm not sure that is truly what we want.
> 

Mainly I changed it because if you didn't have write access it would 
spam the user with warnings and return -1. create_store is currently 
checking for R_OK | W_OK | X_OK access even if it is not necessary to 
make the directories. We could change this but that might have other 
side effects.

Further, since we don't know if the system is unmanaged or the modules 
directory is just inaccessible you can't even start a transaction right 
now (I added  if (semanage_access_check(sh) != SEMANAGE_CAN_WRITE) 
return -1 to direct_begintrans).

The main reason for this patch was to let the client give the user nice 
errors in these access cases since Dan's intention by checking for UID 
== 0 was to not spam the user with libsemanage debug messages. I'm not 
sure how to maintain the current behaviour while keeping access messages 
reasonably quiet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
