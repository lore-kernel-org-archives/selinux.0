Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52C2qrT003626
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 08:02:52 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i53C2aeD029743
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 08:02:36 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 2 Jun 2004 12:02:50 -0000
Date: Wed, 2 Jun 2004 12:00:16 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: tridge@samba.org
Cc: Volker.Lendecke@sernet.de, Samba-Technical <samba-technical@samba.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: se-samba
Message-ID: <20040602120016.GG2960@lkcl.net>
References: <20040529095153.GB16927@lkcl.net> <200405312249.11522.rcoker@redhat.com> <16571.47722.750708.219840@samba.org> <20040531232931.GE8312@lkcl.net> <1086081794.3268.39.camel@localhost.localdomain> <20040601110924.GE8312@lkcl.net> <1086096477.3268.63.camel@localhost.localdomain> <20040601133547.GU8312@lkcl.net> <E1BV9Yp-0002wU-00@intern.SerNet.DE> <16573.1058.707078.949935@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16573.1058.707078.949935@samba.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 02, 2004 at 08:33:06AM +1000, tridge@samba.org wrote:
> Volker,
> 
>  > It's a), everything is done via a single tcp connection. One reason is that we
>  > want to mirror the behaviour that the server we proxy towards gives us as
>  > closely as possible. Separate smb connections give a difference that might have
>  > influence on the server's behaviour.
> 
> Nope, the we open a new connection for each tree connect in that
> backend.
 
  BRILLIANT.  that's even better.

> It really doesn't matter though, as unless I have completely
> misunderstood se-linux, the TConX behaviour is completely irrelevant
> for the seteuid() problem that se-linux faces. All TConX does is
> establish a connection to a new directory (ignoring ancient share
> level security setups).

 the problem is that SE/Linux doesn't support seteuid.

> The relevant question is how SessionSetup is handled, because that is
> what determines the security context of requests. A client can combine
> SessionSetup with TConX in any way it wants to, with multiple TConX
> per SessionSetup or multiple SessionSetup per TConX. 
> 
> The CIFS proxy backend in Samba4 currently does a fixed SessionSetup
> using domain, username and password from parametric options in
> smb.conf. Andrew Bartlett has talked about adding authentication
> proxying as well, but it isn't done yet. When that is done the whole
> se-linux idea of using a CIFS proxy could be re-visited.
> 
> But really I think the whole idea of using a CIFS proxy for se-linux
> Samba is a non-starter. It would work, but it would be a "party
> trick", not a serious solution. Far better for the se-linux people to
> come up with a more general solution for handling servers that need to
> handle multiple security contexts on one network connection. In
> particular the solution should not be so intimately tied to CIFS.

 the solution is to have one process per security context.

 it is not possible to drop from the equivalent of root into
 the equivalent of a user-security-context (seteuid) and then
 back to the equivalent of root again.

 and SE/Linux is never going to have the equivalent of seteuid added.

 an SMB proxy which de-multiplexes all SMBsessionsetupXs and
 SMBtconXs is the "quickest" way to code up something that
 "works" that fits the requirements.

 it doesn't have to be fast.
 
 it doesn't have to be nice.
 
 it just has to work, and provide the required security semantics.

 "next" version can be an improvement on that.

 and, if i gather this correctly, the required semantics are already
 satisfied by using samba(4)'s SMB proxy and a samba(3) back-end.

 which is _great_.


 now, as i described a couple of times before, the alternatives
 are to write a special samba(4) NT-VFS plugin that communicates
 via a custom-written Inter-Process-Communication system to a
 de-multiplexing filesystem back-end.

 or, to design a back-end that forks() on SMBsessionsetupX
 and then forks() again on SMBtconX, and has some internal logic
 that manages to deal with locking, consistency, and successfully
 manages to communicate SMB requests through the double-layer of
 forks()

 that's a _lot_ more complex a solution than using SMB proxying.


> I would suggest that the se-linux people think about a potential
> user-space NFSv4 server, which faces exactly the same problem. Do the
> constraints imposed by se-linux mean that we will forever have to run
> NFSv4 servers in the kernel? Is that a good idea, given the security
> isolation aims of the project?

 i believe you may be misunderstanding the issues, which are relatively
 straightforward.

 1) root has no special "automatic" privileges, or more specifically,
    the uid "0" has no special "automatic" privileges, in SE/Linux.

	all uids are treated the same, and they only have the privileges
	which they are given, by the sysadmin.
 
 2) processes, which run under user-contexts (uids) have to be given
    permissions to do certain operations, such as execv(), open(),
	read once opened, stat, in fact pretty much everything is
	controlled.

 3) processes can, on creation of a child process make that
    child process "transition" to what they refer to as a new
	"domain".  e.g. auto_trans(samba_parent_t, samba_backend_t)
	and the new domain will of course have its _own_ set of
	capabilities (permissions).

[this is where it gets relevant to se-samba:]

 4) IT IS NOT POSSIBLE FOR A CHILD PROCESS TO RETURN TO THE
    PARENT'S DOMAIN.


 therefore, with the present design of samba(3) which uses
 seteuid() to jump to pretending to be a user context,
 such that file writes are done as that user, and then back to
 root to deal with a different TconX context, that completely
 breaks down.


 
 and yes, famd uses seteuid as well, and needs a total redesign
 along the same lines (multiple forked processes).

 andrew, i'm not entirely sure where you got the impression
 that it is necessary to run a kernel-space service (e.g. a
 kernel-space NFS server) in an SE/Linux environment.

 a user-space file server is perfectly sufficient, and much more
 preferable.


 if it wasn't for the fact that multiple SMB sessions can be made
 over the same TCP connection...

 hey.

 *thinks*.

 could someone please remind me: a Citrix Server does multiple
 SMB sessions over the same TCP connection, doesn't it?

 if that's the case, then... could someone confirm this statement
 for me:
 
 	"the samba(4) NT-VFS SMB proxy will do multiple TCP client
	 connections per SMB session"
	 
	 
 is that statement correct?

 because if so, then if the NT-VFS SMB proxy does multiple TCP
 connections per TConX, then yes, that _is_ a little excessive, but
 it's possible to live with that excess, and it can be solved
 by the libsmbclient supporting multiple TconX connections over the
 same TCP connection.

 the _most_ important thing is to have separate TCP connections
 for every SMBsessionsetupX.


 in case anyone's interested, i believe i may have modified
 samba-tng's libsmbclient code (or maybe the cliffs libsmbclient
 code) to be able to do multiple TconX's per TCP connection.

 it's quite straightforward.
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
