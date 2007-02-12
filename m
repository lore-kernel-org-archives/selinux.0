Subject: Re: su and context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ronan Waide <waider@amazon.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1171301899.20328.29.camel@waider.desktop.amazon.com>
References: <45CDEDEE.4050205@gmail.com>  <45D09836.5060007@us.ibm.com>
	 <1171299200.5265.34.camel@moss-spartans.epoch.ncsc.mil>
	 <1171301899.20328.29.camel@waider.desktop.amazon.com>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 12:59:15 -0500
Message-Id: <1171303155.24318.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-12 at 17:38 +0000, Ronan Waide wrote:
> On Mon, 2007-02-12 at 16:53, Stephen Smalley wrote:
> > The behavior has actually changed over time; you'll find discussions
> > about it in the mailing list archives.  The original SELinux kept su
> > separate from security context changes.  Earlier versions of Fedora (and
> > RHEL 4) integrated them (via pam_selinux) in an effort to provide
> > greater transparency, but this caused its own set of problems (e.g. use
> > of su from init scripts, losing continuity of context across su when you
> > want it for roles and levels).  More recent versions of Fedora (and RHEL
> > 5) split them back out again.  One might add an option to su to support
> > simultaneous newrole, but you don't want it by default.
> 
> On the subject of interaction between "old" and "new" security, I was
> briefly stumped in my quest to create a bind role account by the fact
> that the rndc binary (on FC6) is not actually executable by anyone other
> than root, so granting rndc_exec_t doesn't help unless you also change
> the binary's permissions. Is this intentional? I had hoped that SELinux
> rather than the filesystem would be taken as authoritative on who gets
> access, but I can see reasons why this maybe shouldn't be the case, and
> perhaps the 'bug' is with the installed permissions?

It is intentional; we didn't want SELinux to expose the system to
greater risk, so it only further restricts access (and that is
conventional for MAC).  Some people have experimented with modified
forms of SELinux where it is authoritative or selectively authoritative,
but you have to be careful there about your policy configuration and
userland assumptions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
