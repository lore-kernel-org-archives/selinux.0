Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SJ2UUi030772
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 15:02:30 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SJ3VdF009399
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 19:03:32 GMT
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3SJ2SIi014322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 15:02:29 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3SJ2SuL009224
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 15:02:28 -0400
Message-ID: <4BD88643.5040809@redhat.com>
Date: Wed, 28 Apr 2010 15:02:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com> <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil> <4BD18CAE.4050201@redhat.com> <20100426061848.GS21894@myhost.felk.cvut.cz> <4BD58C7B.1000507@redhat.com> <20100426143933.GU21894@myhost.felk.cvut.cz> <4BD5AF15.8000301@redhat.com> <20100428161813.GC1622@myhost.felk.cvut.cz> <4BD8713A.3060702@redhat.com> <20100428185403.GD1622@myhost.felk.cvut.cz>
In-Reply-To: <20100428185403.GD1622@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/28/2010 02:54 PM, Michal Svoboda wrote:
> Daniel J Walsh wrote:
>> Admin installs a third party app that requires setuid/setgid or some
>> other priv, now he needs to write policy to transition his staff_t to
>> thirdparty_t.  In my scenario, unconfined_t will be able to run the
>> third party app, and will be able to becom confinedadmin_t for some sudo
>> jobs.
> 
> The admin will have a choice to either write that policy or keep the
> users unconfined while sacrificing some security (that setuid example
> AND a lot of others) or to give users two roles for this n that.
> 
> Isn't this feasible?
> 
> 
> Michal Svoboda
> 
Feasable yes and for those uses we have staff_t.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYhkMACgkQrlYvE4MpobOSJACgtibXHeEjgLkYwn7CdAxVcZbb
Sb4AoJkMtbz7/q4PTjZlBGG1MeIwhJIs
=uaA/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
