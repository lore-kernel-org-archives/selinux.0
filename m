Message-ID: <47C33D84.8060909@redhat.com>
Date: Mon, 25 Feb 2008 17:13:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        selinux <selinux@tycho.nsa.gov>, jmorris@namei.org,
        method@manicmethod.com, Karl MacMillan <kmacmillan@tresys.com>,
        setools <setools@tresys.com>, pmoore@hp.com
Subject: Re: how to implement permissive domains + an old bug
References: <1203097803.2843.49.camel@localhost.localdomain> <1203099272.16038.223.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880181FACF@exchange.columbia.tresys.com> <1203101867.16038.251.camel@moss-spartans.epoch.ncsc.mil> <1203104633.2843.72.camel@localhost.localdomain> <1203105260.16038.280.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880181FB16@exchange.columbia.tresys.com> <1203947476.2804.168.camel@moss-spartans.epoch.ncsc.mil> <47C2CA26.4070800@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880195C806@exchange.columbia.tresys.com> <1203968898.2804.220.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B015880195C8B8@exchange.columbia.tresys.com> <1203973402.32061.158.camel@gorn> <6FE441CD9F0C0C479F2D88F959B015880195C8D7@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195C8D7@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Christopher J. PeBenito wrote:
>> I don't like the magic attributes as permissive is a mechanism option.
>> It has no meaning in the policy, only in the enforcement.  I'd really
>> prefer some other option in selinuxfs or a proc/pid/attr, but since
>> that doesn't seem to be an option, I'd rather have a policy primitive.
> 
> To my mind the important thing to decide is whether permissive domains
> should be persistent in the policy or not.  If not, then an entry in
> selinuxfs would be appropriate.  If we do want it to be persistent,
> our options include making it a policy primitive, a magic type
> attribute, or an semanage option.  Of those, only the policy primitive
> requires changes to the policy parser.
> 
> I don't have a strong opinion on this myself, though my gut reaction is
> that persistence is a useful property.
> 
>  - todd
They have to be persistent, as I would figure on domains being run in
permissive mode for many months if the chance of the confined domain
going down would be costly.  Personally I would like to put out every
new confined domain in permissive mode for a few weeks until we get out
the bugs in policy. (qemu a couple of weeks ago.)  It would also be
helpful if an administrator could quickly turn a broken domain
permissive rather then putting the entire machine in permissive mode.

I could see the situation of temporarily turning the domain permissive
when the admin suspects SELinux is causing problems with an app, in
order to prove/disprove SELinux is the problem.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfDPYMACgkQrlYvE4MpobMTJwCdFt5eOlgSJpLY7SvSom5764XX
8r4An0fzWB3477QCF3tfV/iA5w+0dpG5
=TVJo
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
