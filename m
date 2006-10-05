Subject: MLS login (Was: Re: newrole - adding capabilities for
	polyinstantiation)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Eric Paris <eparis@redhat.com>, Russell Coker <russell@coker.com.au>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20061005160810.GB28525@w-m-p.com>
References: <451AEC39.2090409@us.ibm.com>
	 <200610040952.07843.russell@coker.com.au>
	 <20061004202041.GC10204@w-m-p.com>
	 <200610051045.41833.russell@coker.com.au>
	 <20061005160810.GB28525@w-m-p.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:04:37 -0400
Message-Id: <1160075077.2132.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 11:08 -0500, Klaus Weidner wrote:
> On Thu, Oct 05, 2006 at 10:45:35AM +1000, Russell Coker wrote:
> > On Thursday 05 October 2006 06:20, Klaus Weidner <klaus@atsec.com> wrote:
> > > But that's not supposed to work, see:
> > > 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200110
> > > and the thread that Stephen Smalley also referred to:
> > > 	http://www.redhat.com/archives/redhat-lspp/2006-July/msg00024.html
> > >
> > > The communication between the master and slave ends of the pty violates
> > > the MLS policy, and makes it easy for unprivileged users to violate the
> > > policy restrictions.
> > 
> > How is ssh supposed to work then?
> 
> I think the sane behaviors for MLS login would be any of the following:
> 
> - for local VTs or serial terminals, login at the default level,
>   and permit using newrole to change level (or role). newrole relabels
>   the tty device to match. Alternatively, choosing a context when
>   logging in would be ok.
> 
> - when using SSH with labeled networking, the network connection has a
>   MLS label corresponding to the sending process (ssh client), and the
>   login session gets this MLS level if it's within the user's clearance
>   range, otherwise the session is rejected.

Just to be clear, this behavior would only occur if running sshd under
xinetd, right?  So that the sshd instance is run in the peer's range and
is already bound by it?  Otherwise, the normal sshd selinux support will
just select a default context for the user without consideration of the
peer label.

>  Newrole is not useful for
>   changing levels since the input or output stream won't be permitted
>   to communicate over the socket, but newrole can be used for launching
>   noninteractive programs that don't need to communicate with the pty.

Not sure that will work presently without some changes to newrole.

> - when using SSH over unlabeled networks (which is of course a leak for
>   MLS information), newrole can relabel the pty. Alternatively, choosing
>   a context when logging in would be ok.
> 
> For SSH with labeled networking, since you don't get to choose the level
> you want to work at, your ssh client needs to be at the correct level
> already. This means that you need to be logged in at the local machine at
> the appropriate level, or use a MLS capable GUI desktop with a terminal
> window at the right level. The GUI version doesn't work (yet) for Linux,
> but it could be a legacy trusted OS that uses CIPSO to communicate.
> 
> Maybe the easiest way to get this behavior is to ensure that relabeling
> one end of a pty pair automatically relabels the other end too. Of
> course, trusted apps can use MLS overrides, but sshd should not do so.

I think sshd_t gets MLS overrides in policy, like other login-like
domains, since it can create user sessions at various levels and sets
the pty labels accordingly.

> For the MLS levels, it shouldn't be necessary to modify sshd to support
> the restrictions - on the contrary, the restrictions should happen
> automatically since sshd doesn't have MLS override capabilities.

...except I think it does.  The discussion seems a bit divorced from
reality.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
