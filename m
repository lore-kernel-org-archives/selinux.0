Subject: Re: Loadable Modules and RPM
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeremy Katz <katzj@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   James Morris <jmorris@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1128721870.8393.33.camel@bree.local.net>
References: <4346D351.3070202@redhat.com>
	 <1128720632.1450.130.camel@moss-spartans.epoch.ncsc.mil>
	 <1128721870.8393.33.camel@bree.local.net>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 18:04:21 -0400
Message-Id: <1128722661.1450.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-07 at 17:51 -0400, Jeremy Katz wrote:
> And then you end up with separate packages with the policy for every
> package shipped in the distribution.  Which is just absurd.  The
> problems with keeping things in sync get massively more complicated in
> addition to the cost of adding lots of packages

Hmmm...I thought someone had mentioned that a similar system is used for
translation strings, but possibly not (or possibly you don't want to
make it worse).

> When you put it like that, it sounds more and more like a bug which
> should be fixed.  If you load a new policy, then I'd think that anything
> which was unlabeled should definitely be re-evaluated.  Otherwise, you
> have a large potential for problems if you boot with a "wrong" policy
> and try to fix without a reboot.

You can still fix from userspace by relabeling the affected files
(although in the past, userspace has gotten confused about what the
actual label is on the file, but James' recent patch queued up for
2.6.15 addresses that issue).  Having the kernel walk the incore inode
lists on every policy reload seems fairly painful for what is
essentially a policy mistake.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
