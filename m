Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95M2eu8005256
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 18:02:40 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95M23AE002383
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 22:02:03 GMT
Date: Thu, 5 Oct 2006 17:02:28 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Russell Coker <russell@coker.com.au>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS login (Was: Re: newrole - adding capabilities for polyinstantiation)
Message-ID: <20061005220228.GC28525@w-m-p.com>
References: <451AEC39.2090409@us.ibm.com> <200610040952.07843.russell@coker.com.au> <20061004202041.GC10204@w-m-p.com> <200610051045.41833.russell@coker.com.au> <20061005160810.GB28525@w-m-p.com> <1160075077.2132.181.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160075077.2132.181.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 05, 2006 at 03:04:37PM -0400, Stephen Smalley wrote:
> On Thu, 2006-10-05 at 11:08 -0500, Klaus Weidner wrote:
> > I think the sane behaviors for MLS login would be any of the following:
> > 
> > - for local VTs or serial terminals, login at the default level,
> >   and permit using newrole to change level (or role). newrole relabels
> >   the tty device to match. Alternatively, choosing a context when
> >   logging in would be ok.
> > 
> > - when using SSH with labeled networking, the network connection has a
> >   MLS label corresponding to the sending process (ssh client), and the
> >   login session gets this MLS level if it's within the user's clearance
> >   range, otherwise the session is rejected.
> 
> Just to be clear, this behavior would only occur if running sshd under
> xinetd, right?  So that the sshd instance is run in the peer's range and
> is already bound by it?  Otherwise, the normal sshd selinux support will
> just select a default context for the user without consideration of the
> peer label.

Yes, that's the current plan.

> >  Newrole is not useful for
> >   changing levels since the input or output stream won't be permitted
> >   to communicate over the socket, but newrole can be used for launching
> >   noninteractive programs that don't need to communicate with the pty.
> 
> Not sure that will work presently without some changes to newrole.

It wouldn't be a required feature, I was just bringing it up as an
example of what would be compatible with the restrictions.

> > Maybe the easiest way to get this behavior is to ensure that relabeling
> > one end of a pty pair automatically relabels the other end too. Of
> > course, trusted apps can use MLS overrides, but sshd should not do so.
> 
> I think sshd_t gets MLS overrides in policy, like other login-like
> domains, since it can create user sessions at various levels and sets
> the pty labels accordingly.

Argh, I wasn't aware that sshd has full MLS overrides:

	TYPES:
	sshd_t (11 attributes)
		ssh_server
		domain
		can_change_process_identity
		can_change_process_role
		can_change_object_identity
		mlsfileread
		mlsfilewrite
		mlsfileupgrade
		mlsfiledowngrade
		mlsprocsetsl
		privfd

Doesn't this have even worse consequences? For example when sshd does
port forwarding, does that mean that a client can ask it to connect to
arbitrary ports using sshd's MLS overrides? Of course, the evaluated
config could disable port forwarding, but this makes it doubtful if sshd
is trustworthy in an MLS environment.

> > For the MLS levels, it shouldn't be necessary to modify sshd to support
> > the restrictions - on the contrary, the restrictions should happen
> > automatically since sshd doesn't have MLS override capabilities.
> 
> ...except I think it does.  The discussion seems a bit divorced from
> reality.

Yes, unfortunately reality seems to be deficient :-(

How about a completely different approach for the MLS system
configuration:

- restrict newrole to admins only

- create a new sshd_via_xinetd_t domain with restricted privileges that
  doesn't change contexts and doesn't have general MLS overrides, just
  whatever is necessary to make polyinstantiation work
  
- for regular user console login (or if not enforcing labeled
  networking), create multiple Linux users for each human user that share
  the same uid and home directory, and use "semanage login" to map them
  to appropriate types. So you'd have smith_secret_cat1,
  smith_unclassified and so on.

I know it's ugly, but would this be a strategy to get an LSPP/RBAC
compliant system in the near future without having to rewrite sshd,
newrole, the kernel pty drivers, or the other potentially affected areas?

Comments?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
