Message-Id: <200509281515.j8SFFZYs010016@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <selinux@tycho.nsa.gov>,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: RE: [PATCH] semanage-functionality 4/17
Date: Wed, 28 Sep 2005 11:15:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1127855418.21671.203.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Tuesday, September 27, 2005 5:10 PM
> To: Karl MacMillan
> Cc: 'Ivan Gyurdiev'; selinux@tycho.nsa.gov; 'Joshua Brindle'
> Subject: RE: [PATCH] semanage-functionality 4/17
> 
> On Tue, 2005-09-27 at 16:38 -0400, Karl MacMillan wrote:
> > These are the stubs that we put in a while ago - we will send a patch to
> > remove those. I would prefer that everything be in semanage.h, however.
> I
> > don't think that it will make the header too long and it will make it
> > clearer I believe.
> 
> Clearer in what sense?  Logically, the module interfaces are distinct
> from the user interfaces, and they will have different clients
> (programs) typically.
> 

Clearer in that the whole API is visible in a single file. I don't feel
strongly about this - it is a matter of preference. I'm in the minority
here, I guess, so I'll go with the separate headers. I would also like to
separate out semanage.c in that case - I do have a preference for c and h
files matching closely unless there is a reason not to.

Karl

> > These also need to be routed through the handle function pointers so
> that
> > alternative implementations for the policy server can be provided.
> 
> Right, the handles have to be common to all, but that can certainly be
> done by a handle.h that is included by the other headers.
> 
> > As above - I disagree. I would prefer a single header for everything
> that
> > works with the transactions. The header will not be that large and it
> makes
> > it easier to see the API as a whole.
> 
> But if the API consists of logically separable components, with
> different clients/users, then why do you want that?
> 
> --
> Stephen Smalley
> National Security Agency

------
Karl MacMillan
Tresys Technology
http://www.tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
