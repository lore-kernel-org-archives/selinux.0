Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95G8Efl024853
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 12:08:14 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95G6xqJ023631
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 16:07:00 GMT
Date: Thu, 5 Oct 2006 11:08:10 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Russell Coker <russell@coker.com.au>
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole - adding capabilities for polyinstantiation
Message-ID: <20061005160810.GB28525@w-m-p.com>
References: <451AEC39.2090409@us.ibm.com> <200610040952.07843.russell@coker.com.au> <20061004202041.GC10204@w-m-p.com> <200610051045.41833.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610051045.41833.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 05, 2006 at 10:45:35AM +1000, Russell Coker wrote:
> On Thursday 05 October 2006 06:20, Klaus Weidner <klaus@atsec.com> wrote:
> > But that's not supposed to work, see:
> > 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200110
> > and the thread that Stephen Smalley also referred to:
> > 	http://www.redhat.com/archives/redhat-lspp/2006-July/msg00024.html
> >
> > The communication between the master and slave ends of the pty violates
> > the MLS policy, and makes it easy for unprivileged users to violate the
> > policy restrictions.
> 
> How is ssh supposed to work then?

I think the sane behaviors for MLS login would be any of the following:

- for local VTs or serial terminals, login at the default level,
  and permit using newrole to change level (or role). newrole relabels
  the tty device to match. Alternatively, choosing a context when
  logging in would be ok.

- when using SSH with labeled networking, the network connection has a
  MLS label corresponding to the sending process (ssh client), and the
  login session gets this MLS level if it's within the user's clearance
  range, otherwise the session is rejected. Newrole is not useful for
  changing levels since the input or output stream won't be permitted
  to communicate over the socket, but newrole can be used for launching
  noninteractive programs that don't need to communicate with the pty.

- when using SSH over unlabeled networks (which is of course a leak for
  MLS information), newrole can relabel the pty. Alternatively, choosing
  a context when logging in would be ok.

For SSH with labeled networking, since you don't get to choose the level
you want to work at, your ssh client needs to be at the correct level
already. This means that you need to be logged in at the local machine at
the appropriate level, or use a MLS capable GUI desktop with a terminal
window at the right level. The GUI version doesn't work (yet) for Linux,
but it could be a legacy trusted OS that uses CIPSO to communicate.

Maybe the easiest way to get this behavior is to ensure that relabeling
one end of a pty pair automatically relabels the other end too. Of
course, trusted apps can use MLS overrides, but sshd should not do so.

> Currently the sshd code for selecting roles is being discussed.  I never 
> expected the sshd upstream people to include that at the first pass and 
> considered that they might refuse to ever include it.  This is not a big deal 
> IMHO as patching base SE Linux support in the openssh source tree to have 
> more features is less work and less risk than patching in SE Linux support 
> where previously there was none.
> 
> If sshd role selection support is maintained and if it's then extended to 
> support a selection of MLS/MCS ranges then what restrictions will be placed 
> on the range selected?  Is the aim to make sshd use labeled networking 
> features to enforce a range that matches the client end?  If so then newrole 
> should be prevented on ssh sessions (IE all pty sessions).

The main focus for the LSPP projects is MLS labels, and there isn't a
requirement that roles and types get synchronized and type enforced
across the network.

For the MLS levels, it shouldn't be necessary to modify sshd to support
the restrictions - on the contrary, the restrictions should happen
automatically since sshd doesn't have MLS override capabilities.

Using sshd modifications or PAM modules to support context selection
sounds like a nice feature for non-MLS uses, but it is not required (or
useful) for the case of ssh login over a MLS labeled network.

> If the ssh client should be permitted to select the role and range then there 
> is little extra vulnerability in also permitting the newrole program to 
> perform the operations being discussed as the user could always cat the file 
> from one ssh session and then proxy it to a cat command in another session at 
> a different level.  This issue may still apply if the ssh client can not 
> select the level as the user may have multiple Unix accounts on the server 
> that have different levels.

See my latest update to the bug quoted above, this proxying isn't
supposed to be possible, and it would not happen if ptys have sane
relabeling behavior - meaning that either both ends always have the same
label, or alternatively (if they have different labels) the MLS
constraints are applied to the data flow.

> It seems to me that the minimal solution to this problem of data relabeling is 
> to prevent newrole from accessing regular pty devices (*) and to prevent ssh 
> logins unless the labeled networking functionality is enabled, the client 
> process is at the same level, and the client computer has the same level of 
> integrity and the same meanings for MLS levels.

I don't think it's necessary to be this restrictive. We don't need to
stop people from using ssh over unlabeled networks if that's what they
want to do (this may be perfectly appropriate for a less paranoid MCS
system). The expectation is that there's a single switch to disable
unlabeled network communication for people who need MLS enforced
networking, and then the MLS restrictions would do the right thing
without needing to modify programs. Admins could assign MLS overrides to
processes that need them.

> (*) This can be achieved by having more types for tty devices, we have 
> user_devpts_t for ptys created by the user and we could have 
> user_system_devpts_t for ptys created for the user by sshd or similar 
> programs.  Then newrole could operate on ptys created by sshd but not on 
> those created by the user.  This also means that newrole in an xterm would be 
> impossible, but given the issues related to capturing data from an xterm this 
> is a good thing.  It would be quite easy to have the default policy have such 
> types and have a boolean to determine whether newrole_t can access 
> user_devpts_t.

I think that's a slippery slope, and it would be better to properly
enforce the MLS constraints rather than patching up gaps using type
enforcement.

> When we get SE-X going we could have an X enabled version of newrole that 
> spawns an xterm in the new context.

Yes - then that would be the recommended way to handle multilevel access.
If you want to ssh to a system at "secret" level, you'd first open a
"secret" xterm, then do plain ssh to the remote system and you'd be
logged in as "secret" there to match the socket label.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
