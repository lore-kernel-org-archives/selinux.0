Subject: Re: SEL+RHEL4+Amanda, targeted policy 18, enforcing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Brad Willson <bwil150n@u.washington.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <440DC850.8070105@u.washington.edu>
References: <440D21C1.30401@u.washington.edu>
	 <1141737506.19447.214.camel@moss-spartans.epoch.ncsc.mil>
	 <440DC850.8070105@u.washington.edu>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:43:43 -0500
Message-Id: <1141757023.19447.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-07 at 09:52 -0800, Brad Willson wrote:
> That depends on the machine.  One box reports no 'avc:  denied' messages 
> whatsoever while on another there are over 4000 entries, both using 
> policy.18.  Is there a quick and dirty way of turning on auditing?  
> Neither machine has an audit.log.

That's fine; you only need the avc messages from /var/log/messages then.
If you had been running auditd, then they would have gone to audit.log
instead, and possibly been supplemented with syscall audit records, but
that isn't required.

Ultimately you want to resolve all of the avc messages, but possibly you
should just start by posting the first few or the ones that seem most
relevant to amanda itself (but try to avoid duplicates).

Note that since you are using RHEL, you should also be reporting this to
Red Hat so that any ultimate fix can be included in a RHEL update;
otherwise you may end up hitting the problem repeatedly.  Filed a
bugzilla there yet? 

> Strict/enforcing has the amanda policy, but it locked root out of bash 
> (not a happy situation) so that's not an option on the remote machines.  
> The other edge of the sword is targeted/enforcing is running on a 
> firewall; I don't want to drop guard on that one albeit relaxed from 
> strict.  I have to resolve backup, monitoring, public services, and 
> remote access issues before I unleash this on the firewalls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
