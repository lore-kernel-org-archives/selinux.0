Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p666A0gl004244
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 02:10:00 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6669xL7021753
	for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2011 06:09:59 GMT
Received: by eyh5 with SMTP id 5so2480707eyh.12
        for <selinux@tycho.nsa.gov>; Tue, 05 Jul 2011 23:09:59 -0700 (PDT)
Subject: Re: Best base policy to use
From: Dominick Grift <domg472@gmail.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 06 Jul 2011 08:09:56 +0200
In-Reply-To: <CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
References: 
	<CAJstirQ5iUsEtEyVmcBJ4Q3jnBy+ESRXeJT9-_vgqKkRx-+fPQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/BH49RD27H6+kCJ8wb2E"
Message-ID: <1309932598.2498.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/BH49RD27H6+kCJ8wb2E
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2011-07-05 at 17:11 -0500, Jeremiah Jahn wrote:
> So I'm in the process of Upgrading my servers from RHEL5 to RHEL6. On my
> RHEL5 system I had to build the reference policy from scratch in order to
> prevent users from being able to  transition to init_t through initrc_t.
> Basically, I want systems that have to be rebooted in order to restart
> certain services, like auditd, or at least be able to split those duties
> into different roles. One role can edit a file or install something, but =
a
> different role must restart it. Because life the universe and everything
> goes through initrc_t, just about anything on the system running as root =
can
> mess with services. I'd like to highly limit things, and haven't  really
> looked at any new developments in selinux for about 4 years. What's the b=
est
> way/place to start removing domain transitions and requiring additional
> roles.

Main difference between el5 and el6 policy is that el6 policy is a
hybrid policy of the old targeted and strict policy. (strict policy was
merged into targeted policy)

You  can now tune your policy to make it behave like the old strict
policy by removing or disabling the unconfined and unconfineduser
modules.

In Redhat policy only unconfined_t can transition directly to initrc.
Sysadm_t needs to use run_init to transition to initrc_t in the system_r
role.

el6 policy allows you to easily create new roles.

So what you could do in my view is, disable or remove both unconfined
and unconfineduser modules and then create your own roles, selinux user
identities and logins.

In that regard el6 policy has pretty much the same properties as current
reference policy.

> thanks,
> -jj-

--=-/BH49RD27H6+kCJ8wb2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk4T/DQACgkQMlxVo39jgT/upwCfTHSVVf7MvRy9YVZOfrIXcIHx
1zUAoMn3YlNvJOn6Vc0lEn8hGjJYN8If
=/aE9
-----END PGP SIGNATURE-----

--=-/BH49RD27H6+kCJ8wb2E--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
