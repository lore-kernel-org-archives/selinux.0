Date: Tue, 22 Feb 2005 14:52:43 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points (user@ip or net_context with setcon)
Message-ID: <20050222145243.GB30826@lkcl.net>
References: <20050221134124.GR14038@lkcl.net> <1109080870.2256.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109080870.2256.66.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 22, 2005 at 09:01:10AM -0500, Stephen Smalley wrote:
> On Mon, 2005-02-21 at 13:41 +0000, Luke Kenneth Casson Leighton wrote:
> > e.g. oh i dunno, being able to lock down the priv_sep sshd,
> > and the monitor process, because they would have distinct
> > selinux domains?
> 
> Being able to assign different permissions (particularly different
> capabilities) to the listening sshd, parent monitor process, and
> unprivileged child process seems useful.  But that doesn't require
> anything per-user and can be done _before_ the user identity is even
> acquired from the client.  

 yes.

> It would be better to switch domains prior to
> processing input from the client (other than the initial connection) to
> reduce the likelihood of exploitation prior to the domain switch.

 i anticipate that this would be a multi-stage approach, requiring
 several distinct domains, to mirror the fact that sshd itself is
 a multi-stage paranoid demon [no, that's not a spelling mistake].

 even though it's the "later" stages that i [personally] am
 more interested in, i think it'd be a case of "in for a penny
 in for a pound" so the use of several setcon() calls to mirror
 each fork() plus set[e]uid() would be required.

 so there's quite a bit involved, hence reasons like "nice" don't
 quite cut it.  "defense in depth" is a good reason, but not enough
 of one to justify the client paying for the work to be done.

 *hand-waving* something along the lines of AllowUsers not showing
 up in the avc audit logs?  doesn't cut it because the authentication
 failure from a different location would appear in the auth logs
 instead.

 *more-hand-waving* sshd's multi-stage approach isn't tracked well
 enough by the selinux strict policy yet?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
