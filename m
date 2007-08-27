Message-ID: <46D30EE7.3030401@redhat.com>
Date: Mon, 27 Aug 2007 13:50:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>, Todd Miller <tmiller@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon replacement
References: <20070815204411.705994826@tresys.com>	 <1187190639.2674.51.camel@localhost.localdomain>	 <46C31BD0.5060200@tresys.com>	 <1187192832.2674.74.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com>	 <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil>	 <1187205378.2838.12.camel@localhost.localdomain>	 <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil>	 <1187209022.2838.38.camel@localhost.localdomain>	 <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>	 <1187210504.2838.56.camel@localhost.localdomain>	 <6FE441CD9F0C0C479F2D88F959B01588EDEBA9@exchange.columbia.tresys.com>	 <1187212166.2838.73.camel@localhost.localdomain> <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1187280118.909.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Finally catching up on Email after vacation.

genhomedircon lists the entire list of passwords in order to figure out
where home directories are.  Not just the contents of the seusers.

At RedHat we have about 50 different root home directories

/home/location/dwalsh

We need to know this in order to have restorecon work properly.

Labeling of the homedir for things like .mozilla .gnome2 and .ssh
is still needed, but differentiating them on Roles does not make sense
in a distributed world.  Where if dwalsh logs into a kiosk machine he
might be xguest_t, on a terminal server guest_t, on his local machine
unconfined_t and on the security machine staff_t.  If his home directory
is the same on all of these, SELinux is in trouble.

I would be fine with the /tmp differentiation based on role, although I
believe that most machines will have almost everyone using the same role
so you have little separation.  Now that XWindows no longer requires
/tmp.  pam_namespace is a much better solution for this.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG0w7mrlYvE4MpobMRArZ5AJ9epyM+nDcr5ONXr3ZQVOCOyLDUtwCg2hjJ
NVP3ISNd7Fd0jrq4tFh2/eE=
=l+ea
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
