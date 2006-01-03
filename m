Subject: Re: Documentation, anyone?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   Ivan Gyurdiev <ivg2@cornell.edu>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1136133436.27906.56.camel@wintermute.xmldesign.de>
References: <1136133436.27906.56.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 11:47:40 -0500
Message-Id: <1136306860.27632.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-01-01 at 17:37 +0100, Erich Schubert wrote:
> Hi,
> Recent changes broke lots of stuff on my system.
> For example, genhomedircon no longer reads my local.users file...
> It seems that this is somehow related to semanage changes...
> Which doesn't work for me, and I can't find *any* documentation on it.
> So the current SELinux shape is IMHO really bad... no current
> documentation, and even those who have working installations (like me)
> have no idea how to get the latest stuff working... :-(

Hmmm....details?  genhomedircon is supposed to fall back to the original
behavior as long as policy is not managed via libsemanage (i.e. policy
is still built as a monolithic policy and not as a module), so I
wouldn't have expected any breakage in Debian unless the Debian policy
package has been converted to modular policy.  I didn't expect that to
happen yet because Debian policy tracks strict policy only, and
refpolicy development has focused on getting targeted policy working
first since it is the default in Fedora.  genhomedircon is known to not
yet support ROLE expansion when using managed policy, and this has been
noted on the list previously.  But it should work fine for monolithic
policies.

> I have a user role "netuser" who is allowed to use the network to a
> larger extend (e.g. bind to port_t). I'd like to make that the default
> role for certain unix accounts...
> 
> $ semanage user --add -s netuser_u -R netuser_r erich
> ['netuser_r']
> libsemanage.assert_init: A direct or server connection is needed to use
> this function - please call the corresponding connect() method
> libsemanage.enter_ro: could not enter read-only section
> /usr/sbin/semanage: Seuser lerich already defined
> 
> I couldn't find an example for /etc/selinux/seusers, I guessed it looks
> like
> "lerich:netuser_u" but that didn't work either...

seusers is only meaningful if your userland has been updated to the
latest SELinux patches present in Fedora development.  Otherwise, it
won't be used; it requires changes to pam_selinux and others as I noted
in the release announcement.  

> I've also investigated "genhomedircon", and what strikes me as really
> bad code is that it keeps on calling an external "grep" on just about
> everything.
> Loading a file and applying a regexp is really easy in Python, you
> know...

Patches accepted ;)  genhomedircon was contributed by Red Hat.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
