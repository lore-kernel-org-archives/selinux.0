Message-ID: <422352AE.8070705@redhat.com>
Date: Mon, 28 Feb 2005 12:19:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Problem with mount context.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/beta/show_bug.cgi?id=149815

How useful is the mount fscontext stuff?   Basically trying to get 
policy to work with a non extended attribute file system,
doing a mount fscontext seems like a nice solution.  The problem is that 
the policy does not allow all file types to associate to
themselves. 

SO in the bug above we end up telling the user to mount the directory as 
squid_cache_t and now he has breakage of

kernel: audit(1109609802.473:0): avc:  denied  { associate } for  
pid=4340 exe=/usr/sbin/squid name=00 
scontext=root:object_r:squid_cache_t 
tcontext=system_u:object_r:squid_cache_t tclass=filesystem

What do you think of adding some kind of rule?

allow rwdirs self:fileystem associate;

Then add a this attribute to file_types that allow writing?  Need better 
name for attribute.

Or is this too broad a rule change. 

ideas?

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
