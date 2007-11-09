Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9Ka4mJ017346
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 15:36:04 -0500
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lA9Ka0uu024053
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 20:36:00 GMT
Date: Fri, 9 Nov 2007 12:35:33 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [Fwd: type class key]
To: Stephen Smalley <sds@tycho.nsa.gov>, David Howells <dhowells@redhat.com>
Cc: Stefan Schulze Frielinghaus <stefan@seekline.net>, selinux@tycho.nsa.gov
In-Reply-To: <1194638426.624.91.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <280071.88616.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-11-09 at 14:51 -0500, Stephen Smalley wrote:
> > On Fri, 2007-11-09 at 19:48 +0000, David Howells wrote:
> > > Okay, it looks like it's probably the problem I'm thinking of.  If it is,
> I
> > > need to think carefully about how to deal with it.
> > > 
> > > Stephen: Would it be possible for me to create the per-UID keyring
> without
> > > reference to the security label of the current process?
> > > 
> > > The other alternative is to accept that if the label can't be linked
> because
> > > of a security label disagreement than that's that, and we don't give an
> error.
> > > 
> > > I don't like that second option, though, because that can seriously limit
> the
> > > utility of the per-UID keyring by it being a lottery as to what label it
> gets
> > > created with - basically who gets to try creating it first.
> > > 
> > > Any suggestions?
> > 
> > (taking discussion back on list)
> > 
> > We already provide a way to create a key with a specified label other
> > than the current process, via setkeycreatecon(3) aka writing the label
> > to /proc/self/attr/keycreate before allocating the key.
> > 
> > So why can't the userland code that is allocating these per-uid keyrings
> > use that interface to set the context appropriately for the actual user
> > rather than defaulting to its own context?
> 
> Ah, wait - this is an automatic allocation of a per-uid keyring upon a
> setuid() call, right?
> 
> So here we have a kernel-internal allocation of the keyring (so userland
> doesn't know it needs to setkeycreatecon, and requiring it to do so
> seems a bit clunky), yet on the other hand, we don't presently have a
> way to map a Linux uid automatically to a SELinux security context in
> the kernel - that's managed in userspace, and a single Linux uid might
> ultimately have a number of SELinux security contexts running on its
> behalf.

This is going to be a problem with any MAC scheme, or at least
any that allows a uid to use more than one label. There is a
faction that will shout "Polyinstantiation!" at this point,
advocating that there be a key for each uid/label pair. I can't
claim to understand how the keyring is used well enough to
say if this is a good idea or a bad one.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
