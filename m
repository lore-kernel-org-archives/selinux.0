Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KnlXZ000180
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:49:47 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KnlfG008160
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:49:47 GMT
Date: Mon, 1 Nov 2004 21:00:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
Subject: Re: dynamic context transitions
Message-ID: <20041101210038.GL9643@lkcl.net>
References: <418662EE.5090001@trustedcs.com> <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com> <20041101203524.GJ9643@lkcl.net> <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099340721.21386.223.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 03:25:21PM -0500, Stephen Smalley wrote:

> On Mon, 2004-11-01 at 15:35, Luke Kenneth Casson Leighton wrote:

> >  no there is no reason why [a helper application should] not [be used].
> >  
> >  i am not sure if the simple solution [that andrew and russell
> >  came up with] was fully enumerated: it involves exec'ing a
> >  per-user helper application which does a setuid.
> >  
> >  the helper application opens files as-and-when they are needed,
> >  [and also does mkdirs? and rmdirs?] and then passes the file
> >  descriptor over a unix-domain-socket to the smbd process,
> >  which NEVER itself does file opens under a user context.
> > 
> >  i believe it then no longer becomes necessary for smbd to
> >  call become_user().
> 
> Except that SELinux mediates access to file descriptors upon transfer
> via local socket IPC as well as attempted use for read/write, so SELinux
> is still going to apply a permission check to the parent smbd process in
> that situation.  

 that i would expect.

> Not to mention that this no doubt has a significant
> cost.

 that i was not expecting.

 ... which leaves my original idea as a viable option, and it is one
 that fits the "exec()" principle.
 
 the "front-end" proxy smbd process [doing NT-style network-based
 authentication] i.e. a "Samba 4" server with the example
 VFS SMB-proxy used in a live production environment, and a
 "back-end" "Samba 3.0.X" server doing the actual file access.

 if speed is of the essence [the overhead of an intermediate TCP
 connection is considered to be non-trivial] then an additional
 communication mechanism, just like MySQL does and just like
 X does, can be added: a unix-domain-socket to provide a
 communication path between the front-end and back-end servers.

 the front-end smbd process running in smbd_t context, the
 back-end running in smbd_user_t context, never the twain
 shall meet.

 several front-end smbd processes would need to be triggered -
 one for each SMB user context - something that i believe the
 "Samba 4" VFS SMB-proxy plugin already does [by default /
 lack-of-other-options].


 if the cost of the [permanently established] link between the
 front-end and back-end is expensive on an selinux system [due
 to exactly the same mediation that stephen mentions above],
 how about using shared memory instead?

 it would require a little bit of design thought [or researching
 for existing libraries] - a packet-based transport in shared
 memory that to all external intents and purposes looked like
 a socket (odd!)

 l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
