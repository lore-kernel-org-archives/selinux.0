Subject: Re: root and change of passwords
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: sequel@neofreak.org
Cc: SELinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1105451963.20566.12.camel@moss-spartans.epoch.ncsc.mil>
References: <1105124940.27291.20.camel@sequel.info.polymtl.ca>
	 <1105451963.20566.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1105568098.23136.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 17:14:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-11 at 08:59, Stephen Smalley wrote:
> Hence, gaining uid 0 is not sufficient by itself to use passwd to change
> root's password - you must also obtain the SELinux user identity of root
> or have appropriate permission in the SELinux policy.
> 
> Whether or not passwd should require root to be in sysadm_r to change
> his own password is another question.  If root is starting in user_r,
> then he is already exposed to other user_t processes, so requiring him
> to newrole to sysadm_r first isn't going to help.  root (and other
> administrative users) should typically only run in staff_r or sysadm_r,
> not user_r, as they are otherwise exposed to tampering/interference by
> user_t processes.

The other item to note here is that even if you have both uid 0 and the
SELinux user identity of "root", you still can't run the passwd program
with the necessary privileges to modify /etc/shadow unless your domain
can transition to passwd_t.  That would be true of the user domains, but
not for a number of daemon domains.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
