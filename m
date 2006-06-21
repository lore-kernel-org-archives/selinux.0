Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
	socket when they are created
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        kmacmillan@tresys.com, jmorris@namei.org,
        Michael LeMay <mdlemay@epoch.ncsc.mil>
In-Reply-To: <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
References: <1150902506.27852.35.camel@localhost.localdomain>
	 <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 15:46:32 -0400
Message-Id: <1150919192.18657.164.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-21 at 12:03 -0400, Stephen Smalley wrote:
> On Wed, 2006-06-21 at 11:08 -0400, Eric Paris wrote:
> > Below is a patch to add a new /proc/self/attr/sockcreate
[cut]
> /proc/self/attr/keycreate is in -mm, so this patch won't apply relative
> to it.  Permission definition also has to be regenerated relative to the
> keycreate refpolicy patch, as that took the same permission slot.

I'm going to need a patch for refpolicy that has the the final ordering
of permissions with key and sockcreate patches.  I haven't added the key
class at all yet since I have been waiting for the perm set to finalize.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
