Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7VFeNmP017813
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 11:40:23 -0400
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7VFe8jc028315
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 15:40:08 GMT
Date: Fri, 31 Aug 2007 08:39:43 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: SELinux security and passed file descriptors
To: Stephen Smalley <sds@tycho.nsa.gov>, David Howells <dhowells@redhat.com>
Cc: viro@ftp.linux.org.uk, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1188572504.26572.459.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <642474.66018.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-08-31 at 15:32 +0100, David Howells wrote:
> > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> > > That's how mandatory access control is supposed to work; otherwise, a
> > > flaw in A can leak the descriptor to B at will in violation of security
> > > policy.
> > 
> > Yeah, but by making it impossible to have the flaw, you've also made it
> > impossible for A to validly pass to B a file descriptor B wouldn't
> otherwise
> > be able to access directly, but should be able to access on behalf of A.
> 
> Let me say it again:  that's how mandatory access control is supposed to
> work.  A program (or user) isn't supposed to be able to delegate access
> under a mandatory policy.

Stephen is correct. Some of the Unix MLS systems went so far as to
prohibit passing file descriptors all together. The ability to pass file 
descriptors is one of those things that make one wonder what could
possibly have been going through the mind (or bloodstream) of the
original author. Yes, I understand that it is useful. It is also one
of those fringe cases that makes it really hard to protect a system
against clever programmers. SELinux currently treats the mechanism
with more respect than it needs to. I expect that in the grand scheme
of things we'd all be better off if the mechanism where abandoned
before the exploits get too thick and someone adds a half dozen layers
of complexity to address the issues one by one.

But, that's just me.





Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
