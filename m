Subject: Re: root and change of passwords
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: sequel@neofreak.org
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1105124940.27291.20.camel@sequel.info.polymtl.ca>
References: <1105124940.27291.20.camel@sequel.info.polymtl.ca>
Content-Type: text/plain
Message-Id: <1105451963.20566.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 11 Jan 2005 08:59:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-01-07 at 14:09, DeadManMoving wrote:
> i've recently find a bug in the implementation of SELinux in gentoo
> Still willing to fix that, i've given the red hat passwd suite a try on
> my gentoo installation and yes! it works quite well!
> 
> I say quite well (and here's my question) cause i see that root is still
> able to change his own password even not in the sysadm_r:sysadm_t
> context. Is that a desired behavior? Would that be easy to implement and
> more secure if root could only change his own password when in the
> sysadm_r:sysadm_t context?

Dan Walsh implemented the modifications to passwd in Fedora, so I've
cc'd him.  Those modifications were similar (but not identical) in
functionality to earlier wrappers for passwd and similar programs used
in the pre-Fedora upstream SELinux.  IIRC, the Fedora passwd program
obtains the caller's security context, extracts the user identity from
it, and checks a SELinux permission if attempting to change the passwd
information for a user other than the caller.  Note that the user
identity in the security context can only be set by processes allowed to
do so by SELinux policy and is not necessarily the same as the Linux
uid, so a rogue uid 0 process cannot arbitrarily assume the SELinux user
identity of "root".  Fedora also includes similar checking elsewhere,
e.g. pam_rootok, libuser, etc.

Hence, gaining uid 0 is not sufficient by itself to use passwd to change
root's password - you must also obtain the SELinux user identity of root
or have appropriate permission in the SELinux policy.

Whether or not passwd should require root to be in sysadm_r to change
his own password is another question.  If root is starting in user_r,
then he is already exposed to other user_t processes, so requiring him
to newrole to sysadm_r first isn't going to help.  root (and other
administrative users) should typically only run in staff_r or sysadm_r,
not user_r, as they are otherwise exposed to tampering/interference by
user_t processes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
