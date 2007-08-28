Message-ID: <46D44F53.1010507@redhat.com>
Date: Tue, 28 Aug 2007 12:37:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Todd Miller <tmiller@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon replacement
References: <20070815204411.705994826@tresys.com>	 <1187190639.2674.51.camel@localhost.localdomain>	 <46C31BD0.5060200@tresys.com>	 <1187192832.2674.74.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>	 <1187205378.2838.12.camel@localhost.localdomain>	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>	 <1187209022.2838.38.camel@localhost.localdomain>	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>	 <1187210504.2838.56.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>	 <1187212166.2838.73.camel@localhost.localdomain>	 <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>	 <46D30EE7.3030401@redhat.com>  <46D42F5F.203@tresys.com> <1188312373.19198.14.camel@localhost.localdomain>
In-Reply-To: <1188312373.19198.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl MacMillan wrote:
> On Tue, 2007-08-28 at 10:21 -0400, Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Finally catching up on Email after vacation.
>>>
>>> genhomedircon lists the entire list of passwords in order to figure out
>>> where home directories are.  Not just the contents of the seusers.
>>>
> 
> And this will simply not work with LDAP infrastructure - iterating over
> tens-of-thousands of users on _every_ workstation is not acceptable.
> 
>> Is there an implementation error in the new genhomedircon?
>>
>>> At RedHat we have about 50 different root home directories
>>>
>>> /home/location/dwalsh
>>>
>>> We need to know this in order to have restorecon work properly.
>>>
>>> Labeling of the homedir for things like .mozilla .gnome2 and .ssh
>>> is still needed, but differentiating them on Roles does not make sense
>>> in a distributed world.  Where if dwalsh logs into a kiosk machine he
>>> might be xguest_t, on a terminal server guest_t, on his local machine
>>> unconfined_t and on the security machine staff_t.  If his home directory
>>> is the same on all of these, SELinux is in trouble.
>> So, it doesn't make sense for your specific infrastructure, that doesn't 
>> mean it doesn't make sense ever. And this is a policy issue really, 
>> genhomedircon just does what its told.
>>
>>
> 
> Can we turn the question around then? Where would this behavior be
> useful? And would the per-user labeling and constraints I suggested work
> in those situations as an alternative? Again, we can leave genhomedircon
> for all I care, I just want to have the defaults work in most
> situations.
> 
> Karl
> 
> 
I believe ldap will stop you from returning the entire database anyways,
 Since it is threshold limited.  I had bugreports of genhomedircon
taking forever to run with large password database > 100,000.  This is
where the compiling of the regex saved tons of time.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG1E9SrlYvE4MpobMRAl+BAKCJ+tDpVFIo2e+TPzbCOBhqKzV/pwCgzlOY
ILOHuv1SxKFdxSVEh+yjOc0=
=hEyU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
