Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1DxZXZ025900
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 08:59:35 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1DwECC027300
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:58:14 GMT
Date: Mon, 1 Nov 2004 14:10:26 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041101141025.GZ8897@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 08:20:15AM -0500, Stephen Smalley wrote:
> On Sat, 2004-10-30 at 05:06, Luke Kenneth Casson Leighton wrote:
> >  the bit that i don't like is the possibility of a process giving itself
> >  an uncontrolled amount of access rights.
> > 
> >  what guarantees can you offer that a process can only escalate to a
> >  specific alternative set of access rights?
> > 
> >  e.g. is your proposal a bit like the file_contexts "alternate"
> >  keyword idea, where the policy contains a different context that
> >  the process can flip to?
> 
> If you look at the patch, it includes an oldcontext-to-newcontext
> dyntransition permission check for these dynamic context transitions, so
> you can control the set of domains which can be reached via dynamic
> transitions from any given domain.
 
 ... where in those domains there may or may not be the permission to
 make a transition.

 SO.

 this proposal is a little bit like seteuid-for-selinux, only not
 really, because seteuid has the ability to switch to any uid and then
 to any uid after that, ad infinitum.

 i wonder if it would help at all with samba's predicament?

 would it be possible to use this to have an smbd process
 transition to a user-based-file-access-only-context and then
 back-to-"root-like"-with-no-file-access-allowed?

	 reminder: samba's predicament is that processes on
	 a per-computer basis tend not to die, plus they can
	 be heavily reused (particularly in Terminal Server
	 situations) where one TCP connection to one smbd
	 process manages several multiplexed user requests
	 with _totally_ different user contexts.

	 [yes i know samba is badly designed in this respect:
	  it REALLY needs a threaded or threaded-like
	  architecture: a threaded client application gets
	  given a single server-side process for its remote
	  file access, which results ultimately in client-side
	  thread blocking - but leaving that aside]


 and also would it be possible to use this proposal to track
 what famd does, too?

	 [reminder: famd doesn't spawn per-user processes to
	  see what files need monitoring on a per-user basis,
	  it uses seteuid instead, just like samba (or maybe
	  setfsuid)].

 
  not that my opinion has any weight in
  these matters, but i still vastly prefer the
  "force-app-rewrites-to-make-significant-use-of-exec()"
  principle over this proposal, but i believe the proposal
  _does_ make "tracking" of existing application design
  much easier.

  whether said application design is any _good_ - samba's
  single-blocking-server-process serving
  multiple-threaded-multiple-user-context-clients multiplexed
  onto a single TCP connection being a notable example - is
  debatable.

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
