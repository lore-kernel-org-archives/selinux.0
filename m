Message-Id: <200603231923.k2NJNMNq014574@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] extending the libsepol API
Date: Thu, 23 Mar 2006 14:23:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1143123154.28120.300.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am bringing this discussion back on list so Ivan can join in when he
returns.

> On Thu, 2006-03-23 at 08:52 -0500, Kevin Carr wrote:
> > We can't use the key model elsewhere in the library, so moving forward
> it
> > can no longer be something that is consistent across the entire API.
> 
> It isn't clear to me that the key model can't be used, just that you
> don't want to use it.  In any event, that discussion should go back on
> list.  I took my reply off list since I don't think we'll make much
> headway here until Ivan returns.

Keys are not sufficient to help us with rule searches.  Imagine that we want
to find all the rules that have a certain subset of permissions.  The key
would have the source, target, and class right?  Thus we cannot construct a
key for what we want.  What we really need is a way to access all the rules
independent of some search criteria so that we can do complex rule matching
outside of libsepol.

> 
> > Also iterators can be used consistently across the
> > entire API and every usage is the same as far as the user is concerned.
> 
> You still have to know what kind of object you are processing, so what
> does this buy you?

Yes, of course the user will have to know what type of object he's
accessing, this is the only thing that's ever different when using
iterators.

> > I understand this has been discussed in the past but I think it needs to
> be
> > discussed again as we are talking about building a much more extensive
> API.
> > We need to add a lot in order to integrate with setools and this is the
> best
> > time to fix things that were done incorrectly in the past especially
> because
> > we are talking about a relatively small amount of code to replace.  We
> are
> > prepared to make the appropriate changes.
> 
> It is much easier to invent your own API than to try to work within the
> constraints of the existing one - I understand that.  But it isn't good
> practice, and it creates a not-inaccurate perception that SELinux is
> never stabilizing, always in flux, never presenting a stable interface
> for users and application developers.  Constant churn.

I agree that SELinux needs to become more stable and I believe that is what
we are trying to do right now.

> > We agree 100% that tools compiled for the old functions need to continue
> > working correctly.  We want to replace the current functions with
> something
> > better but leave the old ones around for compatibility and leave them in
> the
> > ABI.
> 
> Which becomes a) a maintenance nightmare - keeping the old functions
> working forever even as we rework the internals over time and stop using
> them in our own code, b) a source of bloat in the library, and c) a
> source of confusion to users who are presented with a confusing array of
> different APIs.  Much better if we can just avoid the need to deprecate
> the existing functions in the first place.

a) I think the maintenance will be minimal.  An option might be to
re-implement the existing functions, by using the new ones.  Then just
maintaining the new ones would suffice indefinitely.  b) I don't think that
there is ever a reason to keep the functions in the library if no one is
using them, in that long-term case, they should be removed.  c) I don't
think this will cause any confusion to developers as anything that is
deprecated should be clearly marked as such, either in the documentation or
with attributes in the source.

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
