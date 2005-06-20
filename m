Subject: Re: dumb newbie questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <1119281369.30000.56.camel@rodan.ncc.com>
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com>
	 <1119210718.17213.6.camel@localhost.localdomain>
	 <1119213695.17213.29.camel@localhost.localdomain>
	 <1119238487.5253.23.camel@localhost.localdomain>
	 <200506200445.j5K4jbRc007280@turing-police.cc.vt.edu>
	 <1119278717.30000.10.camel@rodan.ncc.com>
	 <1119280474.2766.9.camel@celtics.boston.redhat.com>
	 <1119281369.30000.56.camel@rodan.ncc.com>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 11:56:41 -0400
Message-Id: <1119283001.24129.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-20 at 10:29 -0500, R. Steven Rainwater wrote: 
> What I wasn't understanding is why selinux thinks it's an httpd script.
> It seemed like a pretty generic "hello world" program to me. I'm
> assuming now, that selinux makes guesses about what sort of program it
> is by where it's located? My hello world program works in my home
> directory but not in the httpd perl directory. I still don't entirely
> understand why this should be but at least I know about it now and can
> look out for it.

SELinux performs security transitions upon execve() based on the
security context of the program file, where the security context of the
file is an attribute associated with the file's inode similar to the
file's owner/group/mode information (but stored via extended attributes,
man 5 attr, as with ACLs).  To initialize the security context when a
file is installed, there is a file_contexts configuration file that
specifies file security contexts based on pathname regular expressions.
Programs like rpm and install know to set the inode attribute at
install-time based on this configuration.  restorecon can also be used
to manually reset the inode attribute to the one specified in the
file_contexts configuration.  But in general, after initialization, the
inode attribute should be maintained through a combination of policy
rules and (when necessary for fine-grained labeling) security-aware
applications so that it reflects the real security state of the inode.
At runtime, we don't want to base security decisions on pathnames, which
are merely a way (among potentially many different ways) to refer to the
object and don't reflect the real security state of the referenced
object.  We instead want to base decisions on the security attribute of
the object, which is properly stored (or at least associated) with the
inode.  At install-time, we can infer some aspects of the security
properties of the file from its location under the assumption of secure
development and distribution.  After installation, we want to track the
real security state of the system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
