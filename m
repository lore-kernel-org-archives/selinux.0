Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3QCqEHV022857
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 08:52:14 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3QCpdZ6000602
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 12:51:39 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3QCqCgu018052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 08:52:12 -0400
Received: from localhost.localdomain (vpn-8-67.rdu.redhat.com [10.11.8.67])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3QCqBeJ022364
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 08:52:11 -0400
Message-ID: <4BD58C7B.1000507@redhat.com>
Date: Mon, 26 Apr 2010 08:52:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com> <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil> <4BD18CAE.4050201@redhat.com> <20100426061848.GS21894@myhost.felk.cvut.cz>
In-Reply-To: <20100426061848.GS21894@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/26/2010 02:18 AM, Michal Svoboda wrote:
> Daniel J Walsh wrote:
>> One possible use case would be.  I want to allow a user to login as
>> unconfined_t and only be able to become root as webadm_t through sudo.
>>
>> If webadm_t has setattr on /var/www, he can cp /bin/sh /var/www/sh,
>> chcon 4755 /var/www/sh, exit webadm_t and as unconfined_t become root
>> using /var/www/sh.
> 
> Isn't this just a side effect of the 'unconfined' philosophy? I've
> always been taught (and taught others) that with proper MAC controls you
> can have as many setuid shells as you like.
> 
> You already give all your trust to the user by giving him unconfined.
> Placing setuid controls in place is curing only (one of many) symptoms,
> not the cause.
> 
> Michal Svoboda
> 
First my example was sort of a gross oversimplification.  It would not
only effect unconfined_t but any other domain that could use the setuid
bit to gain additional privs.

unconfined_t to a user means, give him all the power of a normal user
with SELinux disabled.  You are still protected by DAC.  I would argue
that you want to make sure there are limited setuid apps around when
running with unconfined_t.  But if you give him unconfined_t and "chcon
4755"  as a confined user running as root, then you make it easy for him
to become unconfined_t running as UID=0.

If we want people to experiment with confined admins, allow unconfined_t
- -> sudo_exec_t -> confined_admin_t is a good thing.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVjHsACgkQrlYvE4MpobOm9ACfZfmZfoTmD2In2wSC5+asiQUU
AmEAnjgC7RlRt2xtdUAm/t7gzYHMqBG9
=miW8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
