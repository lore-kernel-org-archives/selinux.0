Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:24:01 -0400
Message-Id: <1120073041.20484.70.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > > The file contexts serves a different purpose.
> > > I agree with you in that I don't like having hundreds of files there,
> > > but at the same time I don't see an alternative.
> > 
> > Polyinstantiate every user home directory ;)
> > Anyone following up on Chad Seller's work there?
> > Then you have dynamically created per-role home directories
> > transparently mounted on the user's home directory for whatever role the
> > user happens to be logged in as.
> > 
> 
> Perfect! 

Can you explain how this would work a bit?
How would matchpathcon work on a polyinstantiated directory?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
