Subject: root and change of passwords
From: DeadManMoving <sequel@neofreak.org>
Reply-To: sequel@neofreak.org
To: sds@epoch.ncsc.mil
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 07 Jan 2005 14:09:00 -0500
Message-Id: <1105124940.27291.20.camel@sequel.info.polymtl.ca>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

i've recently find a bug in the implementation of SELinux in gentoo
(http://bugs.gentoo.org/show_bug.cgi?id=76701) and debian (well, at
least with md5 and shadow password enabled) that let root change other
users passwords even when he's not in sysadm_r:sysadm_t context.

I've then contacted the gentoo hardened team and told them about it.
They've asked me to fill a bug report and told me it was surely a
problem with pam and the SELinux patch for pam.

Willing to try to fix the problem by myself, i've made an ebuild for pam
with the latest SRPM of fedora pam implementation. That did not solve
the problem.

So i went back to the gentoo hardened team and told them my experience
with the fedora pam implementation. They then told me they were now
thinking the problem was with the passwd program from the shadow suite.

That was making a lot of sense since fedora do not use the passwd
program from the shadow suite but instead use the passwd suite (passwd
package and libuser package) from red hat.

Still willing to fix that, i've given the red hat passwd suite a try on
my gentoo installation and yes! it works quite well!

I say quite well (and here's my question) cause i see that root is still
able to change his own password even not in the sysadm_r:sysadm_t
context. Is that a desired behavior? Would that be easy to implement and
more secure if root could only change his own password when in the
sysadm_r:sysadm_t context?

Thanks a lot for your time,

Tony Lapointe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
