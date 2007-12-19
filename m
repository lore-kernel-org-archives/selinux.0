Subject: Re: avc:  granted null messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <Xine.LNX.4.64.0712191107170.22567@us.intercode.com.au>
References: <1198014552.11568.49.camel@moss-spartans.epoch.ncsc.mil>
	 <47685BBB.7060308@tycho.nsa.gov>
	 <Xine.LNX.4.64.0712191107170.22567@us.intercode.com.au>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 11:15:06 -0500
Message-Id: <1198080906.19081.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-19 at 11:09 +1100, James Morris wrote:
> On Tue, 18 Dec 2007, Eamon Walsh wrote:
> 
> > Stephen Smalley wrote:
> > > If a (buggy) caller passes a requested permission value of zero to
> > > avc_has_perm, it correctly returns a permission denial (if enforcing),
> > >   
> > 
> > Now I'm questioning why we don't just return success.  Doesn't everyone have
> > permission to do nothing?  It seems odd to think that a process could receive
> > "granted" for a set of permissions A, but "denied" for a subset of A.
> 
> Given that the caller is buggy, we don't really know what it's trying to 
> do, so denying access seems prudent.
> 
> Can we get the audit log to produce something unparseable by audit2allow, 
> as we don't _want_ policy being generated in response to a buggy caller ?

At present, it generates no avc message in permissive (avc_audit entered
with requested == 0 and result == 0) and a misleading avc message in
enforcing (avc_audit entered with requested == 0 and result < 0),
neither of which will generate any policy.

If we change it to consistently generate an:
	avc:  denied null for scontext=...
then audit2allow would try to create an allow rule like:
	allow a_t b_t:class null;
which would compile but fail when one tries to insert the module, since
null is not a defined permission in the base policy.

I don't think we want to generate an unparseable avc message, whatever
that might mean, as that too could potentially break audit2allow and in
a less understandable way, and we want these failures to be noticeable,
just not immediately fatal to the system (ala BUG_ON or assert).

> > 
> > 
> > > but avc_audit will report it as a granted message with a "null" access
> > > vector (also if enforcing) due to the way in which avc_audit checks for
> > > the denied case.  This was reported for nscd in
> > > https://bugzilla.redhat.com/show_bug.cgi?id=352601,
> > > but applies to both the libselinux AVC and the kernel AVC.
> > >
> > > In permissive mode, avc_has_perm permits the operation, and avc_audit
> > > reports nothing at all.
> > >
> > > So the question is how do we want to handle this case?
> > >
> > > It is a bug in the caller, but making it a BUG_ON() in the kernel and an
> > > assert() in libselinux doesn't seem very graceful, especially if in
> > > permissive mode.
> > >
> > > We could easily adjust avc_audit() to report it as a denied message with
> > > a 'null' access vector, although running audit2allow on that output will
> > > yield a broken policy module.
> > >
> > >   
> > 
> > 
> > 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
