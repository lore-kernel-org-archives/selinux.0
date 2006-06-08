Subject: General security concerns with the key subsystem
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com
Content-Type: text/plain
Date: Thu, 08 Jun 2006 17:41:55 -0400
Message-Id: <1149802915.2580.62.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

I wanted to follow up on the discussion we started awhile ago, about
whether we should add unlink permissions to the key subsystem.  I'd be
glad to add them wherever they're necessary, if you're in favor of this.

Also, I think this would be a good time to look at the rest of the
subsystem and try to root out any really severe overt or covert
channels, if possible.  Unfortunately, I don't have the time to do a
full, formal information flow analysis on this subsystem (it's more
complex than it first appears), but I think even an ad-hoc run through
the code should help eliminate some potential vulnerabilities.

The most glaring covert channel in the system is the serial number pool.
Not only is it globally shared, but it has a perfectly predictable
generation pattern.  I have a feeling it will be difficult to completely
get rid of this channel without adding a lot of overhead to the system
and requiring some major changes to the key-handling code, but there
must be something we can do about it.  If we randomized the serial
numbers, its bandwidth should drop significantly, and it doesn't look
like that would disrupt your code too much, since you're storing keys in
rb trees that don't really have any dependence on a sequential serial
number layout.

The more I think and write about the following, the less convinced I
become that it's actually a problem SELinux/LSM should defend against,
but I'll throw it out there anyway to see what you think...  I'm a bit
concerned about the whole request_key system, which involves the kernel
invoking an arbitrary callback function.  I know that by default it
simply invokes a helper that runs with root privileges and prompts the
user.  However, it's possible that a new type could define a callback
that could be used to transfer information from one context to another.
An arbitrary string can be passed along as "call info", so this could be
a very high-bandwidth channel.

Of course, this requires collusion from within the kernel, but perhaps
we should still try to guard against it.  The most logical way to
exploit this would be to craft a kernel module that sets up a new key
type with a request callback that shoves information into some
particular task or context, and then have a task in some other context
make requests.  This probably wouldn't provide the attacker with any
additional advantage beyond what she could derive from crafting a module
that directly passes information into some context without traversing
the key subsystem, but perhaps such a module could be inadvertently
created within some otherwise innocuous module and misused in this way.

I think it might be useful to add another hook in
__request_key_construction to at least regulate which contexts are
permitted to request keys in the first place.  This would probably
eliminate most of these concerns without disrupting users of the key
subsystem.  For example, the only kernel feature that currently uses
keys, ecryptfs, only requests keys during the mount process.

I was glad to see that negative keys and missing keys are handled
identically (from the user's perspective) during searches, otherwise the
error values could have been used to form a channel if two contexts
share limited access to a keyring.  However, another way to form a
channel would be to move a key between the negatively and positively
instantiated states, using a fixed description string, and simply check
the outcome of a search using that description.  Fortunately, your
framework uses a ratcheting mechanism to ensure that positively
instantiated keys can't be transformed back into negatively instantiated
keys.  However, an almost identical channel can be formed using the
"expiry" checks.  This would be a fairly low-bandwidth channel, since
the smallest timeout is 1 second.  However, this could become
significant if multiple keys were manipulated simultaneously.  It might
be advantageous for us to restrict the contexts that are allowed to
update the timeouts on keys after they have been instantiated, while
still allowing them to update other attributes.

Finally, if we wish to permit the usage of /proc/keys in a secure
environment, it may be advisable to not list a key unless the current
context has permission to "view" the key.

I hope this all makes sense, let me know what you think.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
