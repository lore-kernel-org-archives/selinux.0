Subject: Re: dynamic context transitions
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Frank Mayer <mayerf@tresys.com>,
   "'Darrel Goeddel'" <dgoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>,
   "'Chad Hanson'" <chanson@TrustedCS.com>
In-Reply-To: <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
References: <000501c4bf9b$a157d2e0$6701a8c0@columbia.tresys.com>
	 <1099316236.21386.31.camel@moss-spartans.epoch.ncsc.mil>
	 <4186DCE7.9030401@tresys.com>
	 <1099409596.31739.150.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 12:39:15 -0500
Message-Id: <1099417155.23756.112.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 10:33 -0500, Stephen Smalley wrote:
> On Mon, 2004-11-01 at 20:03, Karl MacMillan wrote:
> > Is it possible to build a reasonable system without any of these 
> > features? I don't see how SELinux could be made acceptable to the linux 
> > world without policy reloading and file relabeling,  but it seems clear 
> > that a reasonable system can be built without dynamic context 
> > transistions. Feel free to beat me up about what a "reasonable" system is.
> 
> Yes, I think one could build a "reasonable" system without support for
> runtime policy reloading or file relabeling.  Further, in the absence of
> complete revocation support, one could argue that the system should omit
> these operations since it cannot guarantee their safety.  You might
> argue that a "general purpose" system needs such operations.
> 

Right - SELinux is all about hitting the right compromise between
functionality and security. I don't think it is entirely clear where the
correct compromise is.

> Are dynamic context transitions necessary for acceptability?  I don't
> know the answer, but I do know that we have received far more requests
> for that functionality on this list (just to support legacy Unix/Linux
> applications) than we have ever received for conditional policy support.
> 

Well, conditional policies are no worse (and arguably better) than
policy reloads, so it is an easier case to make for acceptance. The use
of this feature for legacy Unix/Linux is what is concerning. Again, it
is that same question of how far are we willing to go to support legacy.
As you point out below, not whether we are willing to make compromises,
but which ones are we willing to make.

> > All of these mechanism are present to allow integration of SELinux with 
> > existing linux, and prehaps solaris, concepts and practices. The 
> > question is, how far are we willing to go to preserve backwards 
> > compatibility and when is it valuable to force a certain model? I think 
> > it is valuable to force an exec model of domain transitions because it 
> > requires applications to conform to a sound security architecture. TCS 
> > and others with a large body of existing code probably have a different 
> > view.
> 
> Yet even the exec-based transitions are strongly influenced by
> application compatibility concerns; otherwise, we would be purging the
> entire environment, resetting the namespace, etc.  Some would argue that
> exec-based transitions are fundamentally flawed in any case where the
> new domain is more privileged than the calling domain due to the ability
> of the caller to influence the new domain via the implicitly inherited
> state, and an IPC-based model would be preferable so that all
> untrustworthy input is explicitly passed and can be vetted rather than
> implicitly conveyed and so that the initial state of the more trusted
> domain is always setup by a trustworthy process.  But we obviously
> aren't going to mandate that model in the mechanism.
> 

This is all true - the major difference is that in the exec model it is
possible to strictly control what code executes in a domain. The dynamic
context transitions can't make that claim - code in one domain that can
transition to a different domain can execute arbitrary code in that new
domain. That is a much more direct path than influencing known code
through environment or arguments. That makes dynamic context transitions
a practical security measure, like dropping capabilities, but the
domains are for all purposes equivalent.

> > Everyone seems to agree that dynamic context transitions are useful only 
> > to support legacy applications that should be rewritten to an exec 
> > model. Will dynamic context transitions therefore be removed at some 
> > point in the future? It seems that if this is accepted not only will it 
> > remain forever to support legacy, but new applications will be written 
> > that use this capability.
> 
> We have the same concern, although I'm not certain that "everyone"
> agrees on the first point - my impression is that the Samba developers
> viewed our lack of a setfsuid-like operation as a defect in SELinux, and
> that TCS doesn't think that it is _always_ better to convert to an
> exec-based transition (and I would agree that you have to think about
> the trust boundary in doing so, as just splitting the code into a helper
> that is still completely controlled by inputs provided by the caller has
> only limited benefit).

I admit that I was really trying to make it clear that this isn't a
transition mechanism, but something that would stay if introduced. Also,
where would you put the trust boundaries if not at process boundries? Is
it possible to truly reduce the trust between two sections of code in
the same process image? [these are not rhetorical questions - I'm really
asking for some clarification]

> On the other hand, what happens if we simply
> reject this functionality?  Will the developers of all of these "legacy"
> applications rush to restructure their applications to better support
> least privilege and isolation for SELinux?  Or will they just leave them
> as they are, either not running on SELinux at all or running in a single
> domain with the maximal set of permissions required for operation all
> the time?  Is that truly preferable?
> 

It is not a straightforward answer I don't think. One reason I am able
to work on SELinux is because of the compromises made to make this a
workable system for general purpose. My concern is that dynamic context
transitions will give people a false sense of security. I don't think
that it is necessarily the case that it is worse to run in a domain with
the maximal set of permissions. What are the real benefits to converting
samba, for example, to use dynamic context transitions instead of making
it a user-space object manager? It doesn't seem to reduce the amount of
trust placed in samba, but I may be missing something.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
