Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2FatXZ006588
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:36:55 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2FZY4G014903
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 15:35:34 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   "'Chad Hanson'" <chanson@TrustedCS.com>
In-Reply-To: <4186DCE7.9030401@tresys.com>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
	 <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
	 <4186DCE7.9030401@tresys.com>
Content-Type: text/plain
Message-Id: <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 10:33:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 20:03, Karl MacMillan wrote:
> Is it possible to build a reasonable system without any of these 
> features? I don't see how SELinux could be made acceptable to the linux 
> world without policy reloading and file relabeling,  but it seems clear 
> that a reasonable system can be built without dynamic context 
> transistions. Feel free to beat me up about what a "reasonable" system is.

Yes, I think one could build a "reasonable" system without support for
runtime policy reloading or file relabeling.  Further, in the absence of
complete revocation support, one could argue that the system should omit
these operations since it cannot guarantee their safety.  You might
argue that a "general purpose" system needs such operations.

Are dynamic context transitions necessary for acceptability?  I don't
know the answer, but I do know that we have received far more requests
for that functionality on this list (just to support legacy Unix/Linux
applications) than we have ever received for conditional policy support.

> All of these mechanism are present to allow integration of SELinux with 
> existing linux, and prehaps solaris, concepts and practices. The 
> question is, how far are we willing to go to preserve backwards 
> compatibility and when is it valuable to force a certain model? I think 
> it is valuable to force an exec model of domain transitions because it 
> requires applications to conform to a sound security architecture. TCS 
> and others with a large body of existing code probably have a different 
> view.

Yet even the exec-based transitions are strongly influenced by
application compatibility concerns; otherwise, we would be purging the
entire environment, resetting the namespace, etc.  Some would argue that
exec-based transitions are fundamentally flawed in any case where the
new domain is more privileged than the calling domain due to the ability
of the caller to influence the new domain via the implicitly inherited
state, and an IPC-based model would be preferable so that all
untrustworthy input is explicitly passed and can be vetted rather than
implicitly conveyed and so that the initial state of the more trusted
domain is always setup by a trustworthy process.  But we obviously
aren't going to mandate that model in the mechanism.

> Everyone seems to agree that dynamic context transitions are useful only 
> to support legacy applications that should be rewritten to an exec 
> model. Will dynamic context transitions therefore be removed at some 
> point in the future? It seems that if this is accepted not only will it 
> remain forever to support legacy, but new applications will be written 
> that use this capability.

We have the same concern, although I'm not certain that "everyone"
agrees on the first point - my impression is that the Samba developers
viewed our lack of a setfsuid-like operation as a defect in SELinux, and
that TCS doesn't think that it is _always_ better to convert to an
exec-based transition (and I would agree that you have to think about
the trust boundary in doing so, as just splitting the code into a helper
that is still completely controlled by inputs provided by the caller has
only limited benefit).  On the other hand, what happens if we simply
reject this functionality?  Will the developers of all of these "legacy"
applications rush to restructure their applications to better support
least privilege and isolation for SELinux?  Or will they just leave them
as they are, either not running on SELinux at all or running in a single
domain with the maximal set of permissions required for operation all
the time?  Is that truly preferable?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
