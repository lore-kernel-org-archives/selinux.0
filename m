Subject: Re: [ SEPOL ] Reorganize users.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4357F5DF.30905@cornell.edu>
References: <4357F5DF.30905@cornell.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:10:38 -0400
Message-Id: <1129839038.2375.507.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 15:54 -0400, Ivan Gyurdiev wrote:
> Okay, I need to clean up and stabilize my parts of the sepol API.
> This is a small patch that works toward that goal.
<snip>
> - figure out whether or not clean_unused_users actually works, how it 
> works (hey... I stole most of it from genusers - I'm still not clear on 
> how this "defined" stuff works entirely)...  and probably get rid of it.

I thought delete was going away from sepol, as all local customizations
outside of policy modules will be add-or-modify or modify-if-exists.  

For genusers, we processed both system.users (generated from the policy
users file) and local.users, marking each user in the policydb as
defined if it had an entry in either of those files, and then (if
delusers was enabled) purged users that had no definition at all in the
flat files.  Hence, you could remove a user by modifying a flat file.
However, as that was viewed as too dangerous (risk of losing your
system_u, user_u, and root entries), it was disabled by default.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
