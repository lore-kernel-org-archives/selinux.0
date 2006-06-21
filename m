Subject: Re: [RFC][PATCH] selinux: add an unlink permission on keys
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <29242.1150904799@warthog.cambridge.redhat.com>
References: <1150901165.3256.46.camel@moss-tarheels.epoch.ncsc.mil>
	 <29242.1150904799@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 12:11:58 -0400
Message-Id: <1150906318.3256.61.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-21 at 16:46 +0100, David Howells wrote:
> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 
> > @@ -932,7 +942,18 @@ int keyring_clear(struct key *keyring)
> > -		if (klist) {
> > +
> > +		if (klist && klist->nkeys > 0) {
> 
> I'd rather you didn't do that.  The for-loop will just do nothing if nkeys is
> zero.
> 
> > +			int loop;
> > +
> > +			for (loop = klist->nkeys - 1; loop >= 0; loop--) {
> > +				/* check unlink permissions */
> > +				ret = security_key_unlink(klist->keys[loop],
> > +							  keyring, current);
> 
> I think clearing a keyring should filter out the unlinkable keys rather than
> returning an error if one of them is unlinkable.

I had attempted to do that initially, but it gets really messy.  You
have to keep a list of the keys that need to be deleted, separate from
both the old and new keylists that keyring_clear produces.  That
involves changing the keylist structure to point to a list of keys to be
deleted instead of a single key, which ripples through a number of other
routines.  If you'd still like those semantics in light of the overhead
that's required, I'd be glad to adapt the patch to them...

> 
> > @@ -246,6 +248,11 @@ static int install_session_keyring(struc
> >  	/* install the keyring */
> >  	spin_lock_irq(&tsk->sighand->siglock);
> >  	old = tsk->signal->session_keyring;
> > +	if (old) {
> > +		ret = security_key_unlink(old, NULL, current);
> > +		if (ret < 0)
> > +			goto error2;
> > +	}
> 
> I'm tempted to say that should be a separate security op since it's really a
> different operation.

You're right, there's never any parent keyring involved in this
operation.  However, I personally think this permission check has
similar semantics to the previous checks.  In all of these cases, we
don't want a keyring owner to arbitrarily unlink some key or keyring
provided by a different context, perhaps replacing it with one of their
own design.  It doesn't really matter if the key/ring in question has a
true parent keyring, or if it's linked to some predefined location.  I'm
also a little concerned about "hook bloat", perhaps Steve should suggest
what to do with this.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
