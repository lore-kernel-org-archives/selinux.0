Subject: promoting printk for FS mounting back from KERN_DEBUG
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 27 Mar 2007 15:52:42 -0400
Message-Id: <1175025162.13618.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So with my recent printk demotions lots of thing were made KERN_DEBUG
from INFO.  The whole reason for the patch was the messages in hooks.c
were spamming people's logs when they had lots of auto fs mounts coming
and going.  Relevant code to the discussion below:

 303 static char *labeling_behaviors[6] = {
 304         "uses xattr",
 305         "uses transition SIDs",
 306         "uses task SIDs",
 307         "uses genfs_contexts",
 308         "not configured for labeling",
 309         "uses mountpoint labeling",
 310 };

 655         if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) {
 656                 printk(KERN_ERR "SELinux: initialized (dev %s, type %s), unknown behavior\n",
 657                        sb->s_id, sb->s_type->name);
 658         }
 659         else {
 660                 printk(KERN_DEBUG "SELinux: initialized (dev %s, type %s), %s\n",
 661                        sb->s_id, sb->s_type->name,
 662                        labeling_behaviors[sbsec->behavior-1]);
 663         }

I think that marking all of these behaviors as KERN_DEBUG is right
except maybe when sbsec->behavior == 5 ("not configured for labeling").
Do we want to warn users that they are mounting a FS we know nothing
about?  If we do want to promote that message do we want to give more
descriptive output so the user knows what to do?  Possibly suggest to
them to include the FS in their policy or use a context mount?  If so
any suggestions on wording that message?  Maybe we want to still print
the same debug but att a new printk just for the behavior == 5 case?

This comes about because as more and more fuse FS's get used we hit more
and more FS's which don't have defined labeling behavior in policy.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
