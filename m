Subject: Re: [patch 0/4] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Todd Miller <tmiller@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <46E06423.6030707@redhat.com>
References: <20070815204411.705994826@tresys.com>
	 <46C31BD0.5060200@tresys.com>
	 <1187192832.2674.74.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>
	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1187205378.2838.12.camel@localhost.localdomain>
	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>
	 <1187209022.2838.38.camel@localhost.localdomain>
	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1187210504.2838.56.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>
	 <1187212166.2838.73.camel@localhost.localdomain>
	 <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>
	 <46D30EE7.3030401@redhat.com>  <46D42F5F.203@tresys.com>
	 <1188312373.19198.14.camel@localhost.localdomain>
	 <46D44F53.1010507@redhat.com>
	 <1189104699.3617.184.camel@moss-spartans.epoch.ncsc.mil>
	 <1189104986.5251.15.camel@localhost.localdomain>
	 <46E06423.6030707@redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:48:21 -0400
Message-Id: <1189172901.9692.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-06 at 16:33 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Karl MacMillan wrote:
> > On Thu, 2007-09-06 at 14:51 -0400, Stephen Smalley wrote:
> >> On Tue, 2007-08-28 at 12:37 -0400, Daniel J Walsh wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> Karl MacMillan wrote:
> >>>> On Tue, 2007-08-28 at 10:21 -0400, Joshua Brindle wrote:
> >>>>> Daniel J Walsh wrote:
> >>>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>>> Hash: SHA1
> >>>>>>
> >>>>>> Finally catching up on Email after vacation.
> >>>>>>
> >>>>>> genhomedircon lists the entire list of passwords in order to figure out
> >>>>>> where home directories are.  Not just the contents of the seusers.
> >>>>>>
> >>>> And this will simply not work with LDAP infrastructure - iterating over
> >>>> tens-of-thousands of users on _every_ workstation is not acceptable.
> >>>>
> >>>>> Is there an implementation error in the new genhomedircon?
> >>>>>
> >>>>>> At RedHat we have about 50 different root home directories
> >>>>>>
> >>>>>> /home/location/dwalsh
> >>>>>>
> >>>>>> We need to know this in order to have restorecon work properly.
> >>>>>>
> >>>>>> Labeling of the homedir for things like .mozilla .gnome2 and .ssh
> >>>>>> is still needed, but differentiating them on Roles does not make sense
> >>>>>> in a distributed world.  Where if dwalsh logs into a kiosk machine he
> >>>>>> might be xguest_t, on a terminal server guest_t, on his local machine
> >>>>>> unconfined_t and on the security machine staff_t.  If his home directory
> >>>>>> is the same on all of these, SELinux is in trouble.
> >>>>> So, it doesn't make sense for your specific infrastructure, that doesn't 
> >>>>> mean it doesn't make sense ever. And this is a policy issue really, 
> >>>>> genhomedircon just does what its told.
> >>>>>
> >>>>>
> >>>> Can we turn the question around then? Where would this behavior be
> >>>> useful? And would the per-user labeling and constraints I suggested work
> >>>> in those situations as an alternative? Again, we can leave genhomedircon
> >>>> for all I care, I just want to have the defaults work in most
> >>>> situations.
> >>>>
> >>>> Karl
> >>>>
> >>>>
> >>> I believe ldap will stop you from returning the entire database anyways,
> >>>  Since it is threshold limited.  I had bugreports of genhomedircon
> >>> taking forever to run with large password database > 100,000.  This is
> >>> where the compiling of the regex saved tons of time.
> >> Looking at the genhomedircon code, it seems that the only reason
> >> genhomedircon walks the entire user database is to try to find all home
> >> directory path prefixes in order to generate appropriate default
> >> patterns for ordinary user_t users, and that this behavior could be
> >> disabled with the genhomedircon script by passing --nopasswd or -n to
> >> the script, in which case it would only use the default home directory
> >> prefixes defined by /etc/default/useradd and /etc/libuser.conf plus the
> >> hardcoded defaults of /home and /export/home.  In the libsemanage
> >> re-implementation of genhomedircon, this can still be specified by the
> >> caller, but there isn't presently a way to set the desired value in
> >> semanage.conf right now.
> >>
> >> So, the passwd walk has nothing to do with per-role labeling of user
> >> home directories but rather is just about discovering home directory
> >> locations for default labeling, and you need it if you want to ensure
> >> that all user home directories are labeled with appropriate types even
> >> if they all use the same set of types.  So what is your solution again?
> >>
> > 
> > Interesting - thanks for unwinding this. It seems _much_ more reasonable
> > to provide a mechanism for adding home directory locations manually via
> > semanage.
> > 
> > Karl
> > 
> 
> How about we run this one time at install.

If they are using LDAP then it can never be run reliably.

>   And then default to off.
> Allow users to regenerate if they come upon a problem or a full relable?
> 

I think that we have to have some manual way of doing this for systems
that can't iterate over all of the password entries. I also think it
will be important to be able to exclude home directories from relabeling
when we have labeled-nfs - home directories likely shouldn't be
relabeled on every client system.

> BTW, I thought I stated a few weeks ago the purpose of the walk was to
> find home directories.

You did - it didn't occur to me however that meant the walk was needed
even if home directories weren't labeled by role.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
