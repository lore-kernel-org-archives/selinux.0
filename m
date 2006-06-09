Subject: Re: General security concerns with the key subsystem
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <29985.1149847894@warthog.cambridge.redhat.com>
References: <1149802915.2580.62.camel@moss-tarheels.epoch.ncsc.mil>
	 <29985.1149847894@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 09:14:04 -0400
Message-Id: <1149858844.2497.63.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-09 at 11:11 +0100, David Howells wrote:
> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 
> We can restart that discussion if you wish.  Do you agree with the idea of
> simply adding a new security op that takes { task, keyring, key } and says
> whether the task is allowed to unlink that key from that keyring?
> 

That's a reasonable approach that has some real advantages, but it's not
consistent with the rest of the subsystem.  I was thinking more along
the lines of using your existing permission checking system, and simply
adding an unlink permission to keys.  Thus, to unlink a key, you would
need write permission on the keyring and unlink permission on the key.
As we discussed earlier, this permission wouldn't even necessarily be
accessible to your discretionary (pugo) system.

(((from past discussion)))

(1) Key displacement.  How do you deal with a new link that's being made
     displacing an old link that would otherwise be refused unlink
permission?
     It might be sufficient to do the check in advance and assume that
things
     won't then change whilst we create a new key, except that there's a
race
     between two processes both trying to displace the same link in the
same
     keyring.

     The alternative for new key addition is to do the check at the
point of
     link creation, and just accept that we'll not create a link if we
can't
     displace the old key.

     It would also be possible to store a bit of information with each
pointer
     in the keyring if that would be useful.  The problem with caching
can
     you/can't you data in the keyring is that it very much depends on
who's
     asking.

it seems reasonable to check for the unlink permission just before a key
is unlinked, and cause the link operation to fail if necessary.

 (2) Permission percolation over keyrings.  What do you do about a
keyring
     that contains a key that you're not permitted to unlink?  Does the
     keyring itself become unlinkable?  What about session keyrings?

It would be somewhat strange to possess a keyring that contains
permanent keys, but nothing logically precludes such an arrangement.  I
don't think we have to implicitly propagate the unlink permission
upwards through the hierarchy, and that would probably be confusing and
inefficient.  If the entity that installed the non-unlinkable key is
concerned about parent keyrings being unlinked, it should also set them
to be non-unlinkable.

I just noticed that there are no permission checks on
join_session_keyring.  Thus, if an non-unlinkable key were placed on the
session keyring, the task could circumvent our controls by joining a new
session keyring.  We should probably put another hook there, similar to
my proposed request_key hook that restricts some contexts from joining
new keyrings.  Otherwise, we could use the (lack of the) unlink
permission on session keyrings to indicate that they can't be replaced.
This seems logically consistent.


> I wouldn't have any objection with some other way of allocating key IDs.  The
> rb-tree is used to look up keys by ID and to prevent duplicate numbers
> cropping up.  Using incremental allocation provides a simple way of finding a
> unique key.  I'm not sure what the best way of getting random numbers would be
> though.
> 

I'll look around.  I know other aspects of the kernel are randomized to
some degree, so it shouldn't be too difficult.


> If the attacker can load custom kernel modules, you've pretty much already
> lost...
> 
> I'm not sure what you're trying to defend against here.
> 

I was concerned about innocuous modules, loaded by the administrator,
that could be abused by an attacker.  Theoretically, these aren't really
of interest to us, but they could arise in practice.

> > I think it might be useful to add another hook in
> > __request_key_construction to at least regulate which contexts are
> > permitted to request keys in the first place.  This would probably
> > eliminate most of these concerns without disrupting users of the key
> > subsystem.  For example, the only kernel feature that currently uses
> > keys, ecryptfs, only requests keys during the mount process.
> 
> That would be reasonable, but remember request_key() is more likely in general
> to be called from open(), creat(), mkdir(), rmdir(), etc. than from mount
> since you ideally want your mountpoints to be user agnostic if possible.

Then I don't see how an administrator could reasonably restrict access
to request-key.  Perhaps we should have mandatory controls over which
types of keys each context can request.  It's quite likely that
administrators would decide to grant all contexts access to all types of
keys, since the insecure module was installed for some functional
purpose.  However, this would at least force the administrator to
acknowledge that information can be pushed through this mechanism using
some newly-installed type.

> You require SETATTR permission to modify the timeout on a key, and so it will
> invoke SE Linux to do a permissions check.
> 

Maybe that's sufficient.  However, afaict, none of the other attributes
can be used to open a channel between a process with SETATTR permissions
and a process with SEARCH permissions on the parent keyring and the keys
being manipulated.  Thus, it may be desirable to allow some processes to
modify all attributes except the timeout.  I understand that this would
confuse the meaning of SETATTR to some degree, since it would no longer
convey the authority to modify all attributes, but I doubt that such
confusion would be very severe or persistent.

Actually, an alternative way of looking at this is that w.r.t. the
expiry attribute, a process possessing the SEARCH permission on the key,
but not the VIEW permission, can gain some information about the expiry
attribute that the administrator didn't explicitly authorize.  Perhaps
we should require both VIEW and SEARCH permissions on any keys
discovered by a search, since the expiry attribute is being read
implicitly.

A final alternative would be to document this channel, explaining that
the SEARCH permission on keys implies VIEW on the expiry attribute, and
depend on administrators to be careful with the SEARCH permission.

> Permitting an expired key to be rejuvenated by updating it with add_key()
> seemed reasonable, but that possibility can be eliminated if you'd prefer.
> 
> Revoked keys must be replaced.

> /proc/keys is a debugging option, and should be disabled on production
> systems.

Fair enough.  But what if it's not disabled on a production system? ;-)
I know at that point it's not really our problem, but it wouldn't be
that hard to add just a little more protection.

By the way, did you get a chance to review my keycreate patch?  It's
pretty trivial, but I need you to sign off on it.  Thanks!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
