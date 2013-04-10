Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3ADhEG6026580
	for <selinux@tycho.nsa.gov>; Wed, 10 Apr 2013 09:43:15 -0400
Message-ID: <51656C66.10202@redhat.com>
Date: Wed, 10 Apr 2013 09:43:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: semanage support for nsswitch
References: <51422EB6.7000807@mthode.org> <CAPzO=NyXe5LyjS_xV68gAJ9oOXiotP0DmDhrqrRrNVgZrP4jvA@mail.gmail.com>
In-Reply-To: <CAPzO=NyXe5LyjS_xV68gAJ9oOXiotP0DmDhrqrRrNVgZrP4jvA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/09/2013 04:32 PM, Sven Vermeulen wrote:
> 
> On Mar 14, 2013 9:18 PM, "Matthew Thode" <mthode@mthode.org 
> <mailto:mthode@mthode.org>> wrote:
>> 
>> I've noticed that semanage does not support nsswitch, is there a reason 
>> for this or am I somehow blind?
> 
> As I'm about to move towards ldap authentication i'm interested in this as
> well. Especially for group information this would be very interesting as I
> can then assign users to their SELinux user counterpart based on the
> primary group (if I read it all well).
> 
semanage uses getpw/getgr calls so it does support nsswitch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFlbGYACgkQrlYvE4MpobOvbwCfejkyGKiKFkjxq+jsNL4kC+pF
FCoAmwaWH4JINdjczVptlhMNjGCNvG00
=cL7B
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
