Subject: object class discovery userland
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain
Date: Fri, 20 Apr 2007 10:01:57 -0400
Message-Id: <1177077717.15762.32.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have nearly completed the kernel patch for object class discovery
which creates the structure:

/selinux/class/CLASSNAME/index
/selinux/class/CLASSNAME/perms/PERMNAME

so you get the class index number from the index file, and the
permission name file gets the index number of the permission.  I started
looking at the userland side of this, and there are some relevant
functions:

security_class_t string_to_security_class(const char *name);
const char *security_class_to_string(security_class_t cls);

access_vector_t string_to_av_perm(security_class_t tclass, const char *name);
const char *security_av_perm_to_string(security_class_t tclass, access_vector_t perm);

The implementation for the first one is straightforward, just look at
the index file for the class.  The other three are a little more
problematic with the above structure since they use an index, since it
would have to search through the CLASSNAME/index files to find the right
one.

So to get the reverse lookup we could:
1. search /selinux/class/ in the userland code
2. create symlinks /selinux/class, one possible structure:

/selinux/class/1 -> security
/selinux/class/2 -> process
/selinux/class/security/perms/1 -> compute_av
/selinux/class/security/perms/2 -> compute_create

3. stop exporting class and perm indexes outside of the libraries.  Then
the reverse lookup wouldn't be needed.  This would involve some
overhauling of the libraries.

4. other ideas?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
