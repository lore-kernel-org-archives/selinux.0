Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KOWXZ029893
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:24:32 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KOVfG007178
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:24:32 GMT
Date: Mon, 1 Nov 2004 20:35:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Morris <jmorris@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, samba-technical@samba.org,
   tng-technical@samba-tng.org
Subject: Re: dynamic context transitions
Message-ID: <20041101203524.GJ9643@lkcl.net>
References: <418662EE.5090001@trustedcs.com> <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 03:10:41PM -0500, James Morris wrote:
> On Mon, 1 Nov 2004, Darrel Goeddel wrote:
> 
> > James,
> >      I am hoping that this response will also address your question of 
> > applicability outside of the MLS policy.
> 
> > I have looked back on the threads involving smbd and famd and it does indeed 
> > seem that dynamic transitions may help to bring those applications to a 
> > "SELinux-aware" state.
> 
> Is there any reason why smbd can't exec a simple helper application in the 
> required context which only does what needs to be done?
 
 no there is no reason why [a helper application should] not [be used].
 
 i am not sure if the simple solution [that andrew and russell
 came up with] was fully enumerated: it involves exec'ing a
 per-user helper application which does a setuid.
 
 the helper application opens files as-and-when they are needed,
 [and also does mkdirs? and rmdirs?] and then passes the file
 descriptor over a unix-domain-socket to the smbd process,
 which NEVER itself does file opens under a user context.

 i believe it then no longer becomes necessary for smbd to
 call become_user().

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
