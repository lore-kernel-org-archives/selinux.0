Subject: RE: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885146C1@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885146C1@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 18:11:39 -0500
Message-Id: <1162336299.6131.68.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-10-28 at 13:58 -0400, Joshua Brindle wrote:
> > From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 
> > The application does own the objects and the runtime labels 
> > of those objects.  But the mapping that produces the labels 
> > should be owned by the security administrator.
> 
> Why? First of all, there are cases where runtime and initial contexts
> aren't different (policy server, dbus). So in that case do you concede
> that the application should own the runtime labels? Do you think it
> would be valid for the postgres schema to contain the initial labels?
> That would clearly not be stored with the rest of these contexts with
> the policy. I don't think it violates any fundamental security
> principles though..

I don't quite understand the meaning of "initial" and "runtime" here. 

> > - N different configuration file formats that the security 
> > administrator now has to be aware of and have permission to edit.
> 
> Which is obviously non-ideal and unscalable. These need infrastructure
> to manage or noone will ever use them.

And this is precisely what I am proposing.  That we standardize a file
format for storing string -> context mappings, install them all
somewhere in /etc/selinux where they are accessible to the security
administrator only, and provide a matchpathcon-type interface in
libselinux, indexed by object class, for use by userspace object
managers to query them. 

I'm not arguing that the mapping files have to ship in the policy
package.  If you want to ship them (and policy modules) in the
individual application packages, that's fine. 

> 
> > - N different service administrators who now have the ability 
> > to mess up the security configuration on the system.  This is 
> > very DACish.
> 
> Not really. Individual enforcers can still control who can change them,
> as well as MAC on the files (or whatever) containing the labels. 

Not if the labels are stored in the same config file with the rest of
the application configuration.  Which is why I want them broken out into
separate files.  And once you do that, you might as well stick it
under /etc/selinux, and symlink to it from /etc/httpd or whatever if
necessary so that the service administrator knows about it.

Again, I don't care which package it goes in.

> 
> > - N different upstream projects that you have to convince to 
> > accept not only the userspace object manager code, but also 
> > new SELinux-specific configuration parameters.  Imagine if we 
> > had to convince the coreutils or tar people to incorporate 
> > the file contexts mapping.
> 
> Except neither of those need mappings, they aren't enforcers. Enforcers
> need configuration parameters to work, upstream should understand that
> the code being added (the object manager code) has configuration
> parameters, this is not a stretch I don't think.

For the specific case of string -> context mappings, I think they should
be handled through libselinux as described.  I think it would simplify
the upstreaming job and do a lot to make selinux "work behind the
scenes" like it does in the kernel.

> 
> > - N different packages that have to be updated when the next 
> > policy package comes out (since the valid set of types _is_ 
> > in kernel policy).
> 
> Ah! So now we are getting to a good issue. There is nothing preventing
> the user object manager from being packaged with its own policy module
> that defines the types used by that UOM. In fact, I think this is what
> we want, once we have dynamic object class discovery we can even add
> classes and permissions in modules so any UOM policy can be completely
> independent of the running policy on the system. 

I'm not arguing that we can't do this.


> > You'd have to ship apache-targeted, apache-strict, 
> > apache-mls, etc. to match the installed policy, and you'd 
> > have dependencies like
> > apache-targeted-1.2.3-54 requires selinux-policy-targeted == 
> > 1.2.3-1234.
> > 
> 
> I don't think that's true, there is nothing preventing an application
> from installing its policy into
> /usr/share/selinux/<policytype>/apache.pp and letting the selinux
> infrastructure figure out how to handle it, in fact I think that is
> precisely what we want.

...and this is precisely what I want, except for the mapping files
instead (or in addition to) the policy modules.  (assuming
that /usr/share/selinux is restricted to the security admin).

Something like the following (notice the by-class structure):

/u/s/selinux/<policytype>/mappings/vhost/apache.map
/u/s/selinux/<policytype>/mappings/vhost/lighttpd.map
/u/s/selinux/<policytype>/mappings/xextension/xserver-extensions.map
/u/s/selinux/<policytype>/mappings/property/xserver-properties.map
/u/s/selinux/<policytype>/mappings/dbus/dbus-channels.map

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
