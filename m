Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8TEbGsJ012076
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 10:37:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8TEbFCG001158
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 14:37:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h8TEbFqJ001153 for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 14:37:15 GMT
Subject: Re: unlabeled_t and assert.te
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>, Howard Holm <hdholm@epoch.ncsc.mil>,
   James Morris <jmorris@redhat.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <200309272054.50553.russell@coker.com.au>
References: <200309272054.50553.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1064846219.10464.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 10:36:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-27 at 06:54, Russell Coker wrote:
> But it occurs to me that this may be a symptom of an error in design.  An 
> unlabeled process is quite a different thing from an unlabeled file.  
> Allowing read access to unlabeled files and directories on a file system has 
> different implications than allowing "ps" to show unlabeled processes.  I 
> think that the correct solution to this requires a kernel change to have 
> unlabeled_process_t and unlabeled_file_t (or other names as considered 
> appropriate).

Ordinarily, this distinction is handled by the security class, and does
not require a different type.  However, /proc/pid is a special case, as
it exports process state via files and is labeled with the same label as
the corresponding process (and hence its domain).

One possibility would be to define derived types for the /proc/pid files
for each domain and label these inodes with these derived types rather
than the domains (by calling security_transition_sid in
security_task_to_inode, and defining type transition rules in the
policy).  This would eliminate the use of domains as types for files
from the policy entirely, so you would never have a domain associated
with a file security class in the policy.

I doubt we really want to introduce separate initial SIDs for unlabeled
instances of each class of object.  However, as a separate issue, it
would be desirable to rework the initial SID support to allow easier
extension.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
