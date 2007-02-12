Subject: Re: su and context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Ted X Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <45D09836.5060007@us.ibm.com>
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 11:53:20 -0500
Message-Id: <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 10:39 -0600, Michael C Thompson wrote:
> Ted X Toth wrote:
> > Why doesn't my context change when I 'su' to a different user?
> 
> I'm pretty sure su isn't SELinux aware like newrole is -- not 
> investigated the source enough to save 100%, but pretty sure.
> 
> Is there a reason why you would want it to affect your context?
> 
> DAC and MAC are not intended to be related I thought.

The behavior has actually changed over time; you'll find discussions
about it in the mailing list archives.  The original SELinux kept su
separate from security context changes.  Earlier versions of Fedora (and
RHEL 4) integrated them (via pam_selinux) in an effort to provide
greater transparency, but this caused its own set of problems (e.g. use
of su from init scripts, losing continuity of context across su when you
want it for roles and levels).  More recent versions of Fedora (and RHEL
5) split them back out again.  One might add an option to su to support
simultaneous newrole, but you don't want it by default.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
