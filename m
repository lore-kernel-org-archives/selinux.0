Message-Id: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <gyurdiev@redhat.com>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Wed, 29 Jun 2005 15:04:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1120071221.3553.177.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Wednesday, June 29, 2005 2:54 PM
> To: gyurdiev@redhat.com
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> On Wed, 2005-06-29 at 14:46 -0400, Ivan Gyurdiev wrote:
> > > More importantly, we have just decided to remove specific user information
> from
> > > the policy and leaving it in the file contexts seems strange.
> >
> > The file contexts serves a different purpose.
> > I agree with you in that I don't like having hundreds of files there,
> > but at the same time I don't see an alternative.
> 
> Polyinstantiate every user home directory ;)
> Anyone following up on Chad Seller's work there?
> Then you have dynamically created per-role home directories
> transparently mounted on the user's home directory for whatever role the
> user happens to be logged in as.
> 

Perfect! 

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
