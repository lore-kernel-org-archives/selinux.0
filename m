Subject: Re: SEL+RHEL4+Amanda, targeted policy 18, enforcing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: bradw@genetests.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <440D21C1.30401@u.washington.edu>
References: <440D21C1.30401@u.washington.edu>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 08:18:26 -0500
Message-Id: <1141737506.19447.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-06 at 22:01 -0800, Brad Willson wrote:
> Running SELinux enforcing mode does not allow amanda to connect and do
> backups.
> 
> I'm a newbie at SELinux in dire need of some straightforward answers.

What 'avc:  denied' messages are you getting in /var/log/messages
or /var/log/audit/audit.log?

> Following the logic that named.fc needs a companion named.te, the first
> thing I have noticed is the lack of an amanda.te file in this particular
> distribution.  What I find odd is there are several diffs on this list
> specifically for amanda.te.  I have located what appears to be a
> complete amanda.te file from another distribution, but when I try to
> recompile the policy, it spews errors then fails, e.g.

RHEL4 targeted policy didn't include the amanda policy.  Targeted policy
started as a very small subset of the overall example policy, but has
grown significantly since RHEL4 was released (but those changes are
feeding into Fedora and should be included in future RHEL releases, not
RHEL4 updates, IIUC).  See 
http://fedoraproject.org/wiki/SELinux/

> Building file_contexts ...
> /usr/bin/checkpolicy -o policy.18 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> domains/program/amanda.te:143:ERROR 'syntax error' at token
> 'can_network_server' on line 4181:

This reflects the fact that the amanda.te file you grabbed uses a macro
(can_network_server) that didn't exist in the policy at the time RHEL4
was created.

> Since the first send bounced back, I also tried strict/enforcing and 
> found myself in even deeper trouble, but still without a successful 
> backup.  My next test is to relax targeted policy to permissive so I can 
> audit the errors for clues.

Just check for avc denied messages in your logs and report them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
