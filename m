Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94KKj7q031707
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 16:20:45 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94KJX5l004056
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 20:19:33 GMT
Date: Wed, 4 Oct 2006 15:20:41 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Russell Coker <russell@coker.com.au>
Cc: Michael C Thompson <thompsmc@us.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole - adding capabilities for polyinstantiation
Message-ID: <20061004202041.GC10204@w-m-p.com>
References: <451AEC39.2090409@us.ibm.com> <451C3A37.8080509@us.ibm.com> <4522E6DA.1000200@us.ibm.com> <200610040952.07843.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610040952.07843.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 04, 2006 at 09:52:02AM +1000, Russell Coker wrote:
> On Wednesday 04 October 2006 08:40, Michael C Thompson <thompsmc@us.ibm.com> 
> wrote:
> > There are a few concerns which have arisen due to this polyinstantiation
> > and suid newrole work. One such concern is that with labeled networking,
> > using newrole to change your MLS level will not work as intended, since
> > the relabeled tty will not be able to talk to the socket. This would
> > limit using newrole to manipulate our MLS to the console, and would
> > leave newrole capable of only changing the role and type on network
> > connections.
> 
> What do you mean?
> 
> You have sshd talking to /dev/ptmx and the shell talking to /dev/pts/X.  
> If /dev/pts/X is relabeled to a different range then sshd will still keep 
> talking to /dev/ptmx without any change (in fact sshd can't conveniently know 
> about this change).

But that's not supposed to work, see:

	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200110

and the thread that Stephen Smalley also referred to:

	http://www.redhat.com/archives/redhat-lspp/2006-July/msg00024.html

The communication between the master and slave ends of the pty violates
the MLS policy, and makes it easy for unprivileged users to violate the
policy restrictions.

LSPP is not concerned with covert channels, but the pty hole isn't
covert, it's a direct use of official interfaces according to their
specification, and that's not acceptable for an evaluation.

Unfortunately this means that the current system will make "newrole -l"
essentially useless over ssh sessions, and since there is no support for
selecting a level at login time it may be necessary to use workarounds,
such as creating multiple Linux usernames mapped to the same UID but with
different default MLS levels (configured via "semanage login"). (I've
just tested that - it works, but I'm not sure if that's how people expect
the system to behave.)

> Also for an X session it's quite viable to ssh to localhost from an xterm to 
> create a session with a different context, and that is no more difficult than 
> running newrole.  I am not advocating doing this, just noting that it is 
> possible.

Well, this should only work if you have a proper MLS aware desktop that
can prevent cut&paste between the sessions at various levels, and would
require MLS override capabilites for the X server and/or window manager.

Currently, even localhost networking is supposed to be labeled, so you
wouldn't be able to use a SSH session running at a different label for
communication.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
