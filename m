Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <200805071248.13439.sgrubb@redhat.com>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
	 <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil>
	 <7e0fb38c0805070829q1bda9233h1f71865634776e71@mail.gmail.com>
	 <200805071248.13439.sgrubb@redhat.com>
Content-Type: text/plain
Date: Wed, 07 May 2008 13:20:42 -0400
Message-Id: <1210180842.6434.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-05-07 at 12:48 -0400, Steve Grubb wrote:
> On Wednesday 07 May 2008 11:29:36 Eric Paris wrote:
> > On Wed, May 7, 2008 at 11:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >  On Wed, 2008-05-07 at 11:17 -0400, Eric Paris wrote:
> > >  > >  I assume we do NOT want to use this variant interface when getting
> > >  > >  contexts to display in audit messages, as we want the audit
> > >  > > messages to correspond to the actual denial and to yield proper
> > >  > > policy if turned into an allow rule.
> > >  >
> > >  > Is there any way we could get them both displayed if there is a
> > >  > denial?  Might be interesting to know both that the denial was
> > >  > actually unlabeled_t object but also what the 'incorrect' label
> > >  > was.....
> > >
> > >  Easy to do kernel-side, but requires a new avc audit field that won't
> > >  cause any complaints by audit userland or tools like audit2allow.
> 
> What would be the proposed name of this new field? Would it hold just a 
> context string? FWIW, audit user land doesn't really care except that we 
> don't have name collisions on fields.

If we did this (not part of my current patch, but can be done as a
follow-on), then we'd need to define two new fields, one to correspond
to the real/raw context string corresponding to the scontext and one to
correspond to the real/raw context string corresponding to the tcontext.
And they would only be present if the scontext and/or tcontext happened
to be invalid under current policy.  Maybe "rscontext" and "rtcontext"
if we don't think that will confuse existing userspace
(audit2allow/sepolgen, setroubleshoot, seaudit, ...).
   
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
