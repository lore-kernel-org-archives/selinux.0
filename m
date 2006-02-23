Subject: Re: policycoreutils latest diffs.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43FCAC3F.3010202@redhat.com>
References: <43FCAC3F.3010202@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:02:14 -0500
Message-Id: <1140703334.21179.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-22 at 13:23 -0500, Daniel J Walsh wrote:
> audit2allow -
> 
> Added (-R/--reference) to audit2allow.  This basically greps through 
> reference policy and finds all  matches for a particular
> access.  Then outputs them.  It attempts to find the best match.  This 
> makes updating reference policy a lot easier.
> 
> Changed load_policy to be looked at regardless of the granted flag.

Is this to catch reloads that occur in permissive mode?
Going forward, you should be able to key off the new audit messages
added by Steve Grubb for policy reloads, as they will indicate when a
reload actually occurred (vs. just a permission check for them).

> Add some checks to semanage and seobject.py to turn off processing on 
> non MLS/MCS machines.
> (These are untested on a Non MLS/MCS machine, since I do not have access.) 

Doesn't quite work yet.

# semanage login -l
Login Name                SELinux User

Traceback (most recent call last):
  File "/usr/sbin/semanage", line 219, in ?
    OBJECT.list(heading)
  File "/usr/lib/python2.4/site-packages/seobject.py", line 375, in list
    print "%-25s %-25s %-25s" % (k, ddict[k][0])
TypeError: not enough arguments for format string

That one is easy to fix:
--- seobject.py.0	2006-02-23 08:54:12.000000000 -0500
+++ seobject.py	2006-02-23 08:54:16.000000000 -0500
@@ -372,7 +372,7 @@ class loginRecords(semanageRecords):
 			if heading:
 				print "\n%-25s %-25s\n" % ("Login Name", "SELinux User")
 			for k in keys:
-				print "%-25s %-25s %-25s" % (k, ddict[k][0])
+				print "%-25s %-25s" % (k, ddict[k][0])
 
 class seluserRecords(semanageRecords):
 	def __init__(self):

Then login -l works, but:
# semanage login -a sds
libsemanage.validate_handler: MLS is disabled, but MLS range  was found for Unix user sds
libsemanage.validate_handler: seuser mapping [sds -> (user_u, )] is invalid
libsemanage.dbase_llist_iterate: could not iterate over records
/usr/sbin/semanage: Could not add login mapping for sds

So it looks like semanage (util) is passing libsemanage an empty string
rather than a NULL?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
