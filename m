From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
Date: Wed, 7 May 2008 12:48:12 -0400
Cc: "Eric Paris" <eparis@parisplace.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil> <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil> <7e0fb38c0805070829q1bda9233h1f71865634776e71@mail.gmail.com>
In-Reply-To: <7e0fb38c0805070829q1bda9233h1f71865634776e71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805071248.13439.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 07 May 2008 11:29:36 Eric Paris wrote:
> On Wed, May 7, 2008 at 11:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >  On Wed, 2008-05-07 at 11:17 -0400, Eric Paris wrote:
> >  > >  I assume we do NOT want to use this variant interface when getting
> >  > >  contexts to display in audit messages, as we want the audit
> >  > > messages to correspond to the actual denial and to yield proper
> >  > > policy if turned into an allow rule.
> >  >
> >  > Is there any way we could get them both displayed if there is a
> >  > denial?  Might be interesting to know both that the denial was
> >  > actually unlabeled_t object but also what the 'incorrect' label
> >  > was.....
> >
> >  Easy to do kernel-side, but requires a new avc audit field that won't
> >  cause any complaints by audit userland or tools like audit2allow.

What would be the proposed name of this new field? Would it hold just a 
context string? FWIW, audit user land doesn't really care except that we 
don't have name collisions on fields.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
