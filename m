Subject: Re: access(2) vs. SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexey S <selinux@udmvt.ru>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20090416064650.GC9889@ruber.office.udmvt.ru>
References: <1239810710.27560.53.camel@localhost.localdomain>
	 <20090416064650.GC9889@ruber.office.udmvt.ru>
Content-Type: text/plain
Date: Thu, 16 Apr 2009 08:51:05 -0400
Message-Id: <1239886265.7591.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-04-16 at 11:46 +0500, Alexey S wrote:
> On Wed, Apr 15, 2009 at 11:51:50AM -0400, Stephen Smalley wrote:
> > Per [1], the fact that SELinux applies the same read/write/execute
> > checks in response to access(2) calls as it does for an actual open(2)
> > for read/write or execve(2) for execute leads to huge numbers of
> > spurious denials for applications such as nautilus that probe all files
> > being listed.  dontaudit'ing of these denials is viewed as unacceptable
> > as Dan wants to be able to see such denials upon the actual open(2) or
> > execve(2) attempts.
> > 
> > If access(2) only returned the result of the DAC access checks and e.g.
> > only checked getattr permission on access(2) calls (similar to stat(2)),
> > then the read/write/execute MAC denials would not happen, but that would
> > likely break the behavior of existing applications/libraries that use
> > access(2) to decide whether to follow a privileged code path or fall
> > back on an unprivileged code path (e.g. kerberos libraries).
> > 
> > Other suggested proposals included:
> > - Using the _noaudit interface to suppress auditing of the
> > read/write/execute checks when checking for access(2), although this
> > requires reworking the underlying implementation so that we can
> > distinguish access(2) from open(2) checking.  However, this could lead
> > to silent failure of applications with no way to obtain any audit
> > messages, and would provide an obvious way to probe for access without
> > triggering audit.
> I'm sure this is the only one correct solution, but it lacks some little piece:
> it needs some global switch somewhere in /proc or /selinux that turns on/off
> generation of audit messages by access(2) testing read/write/execute permissions.
> This is the special case, that deserves it's own config option, IMHO.

I was actually more inclined to the latter option (new permissions for
access(2), with some consistency guarantees provided by the policy
compiler).  Is there some reason you preferred this approach instead?

Yet another approach would be to argue that this is most properly
handled by the system call audit mechanism, which can already
distinguish access(2) from open(2).  However, it cannot distinguish MAC
failures from DAC failures at present as they do not use different errno
values (and doing so would raise issues of its own).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
