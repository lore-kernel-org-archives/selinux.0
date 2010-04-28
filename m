Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SHWiRC025167
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 13:32:44 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SHWAgg007483
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 17:32:11 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3SHWgnY032307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 13:32:43 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3SHWgX5032664
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 13:32:42 -0400
Message-ID: <4BD8713A.3060702@redhat.com>
Date: Wed, 28 Apr 2010 13:32:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com> <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil> <4BD18CAE.4050201@redhat.com> <20100426061848.GS21894@myhost.felk.cvut.cz> <4BD58C7B.1000507@redhat.com> <20100426143933.GU21894@myhost.felk.cvut.cz> <4BD5AF15.8000301@redhat.com> <20100428161813.GC1622@myhost.felk.cvut.cz>
In-Reply-To: <20100428161813.GC1622@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/28/2010 12:18 PM, Michal Svoboda wrote:
> Daniel J Walsh wrote:
>> If we went full lock down on every domain then we would not have > 70%
>> of the fedora community running with SELinux enabeled in enforcing
>> mode.
> 
> I hear you and I still believe this was/is a smart choice, but I think
> with your proposal you're not adhering to its spirit.
> 
> If unconfined means equal to DAC then the unconfined user should be able
> to become unconfined root even if via seteuid backdoor. If you want to
> prevent this then you're confining the user. (You're now _targeting_
> that ability.)
> 
> So here's an idea: why not just make an unconfined_user_t that would be
> stripped of root powers so that even if it becomes euid 0 he could not 
> exercise them. Then just control the ways of unconfined_user_t becoming
> unconfined_admin_t (for example, type transition on trusted seteuid
> executable program files).
> 
> Seems to me much simpler and much more bulletbroof than removing _one_
> possible way of many by what you proposed - that is confining an already
> confined admin, which is only very remotely responsible for what you
> want to avoid.
> 
>> This is not default allow.  It is DAC + MAC as opposed to the way most
>> people run, which is just DAC. I am trying to make setattr check better.
> 
> Note that from MAC viewpoint, DAC is remarkably similar to default allow.
> 
> 
> Michal Svoboda


Well in a way this is what staff_t is, a user which can run most apps
without a problem. but when it runs an app that requires capabilities,
it needs to transition to another domain.  staff_t is what I run on my
laptop.  The problem is staff_t < unconfined_t in that it can not run
apps that require capabilities that someone has not written policy for.

Admin installs a third party app that requires setuid/setgid or some
other priv, now he needs to write policy to transition his staff_t to
thirdparty_t.  In my scenario, unconfined_t will be able to run the
third party app, and will be able to becom confinedadmin_t for some sudo
jobs.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvYcToACgkQrlYvE4MpobOlJQCeMYi4JDYBIdlo5hYeA2WZGEPT
NvAAoKta0qd51FFAGJWhB40r1KPQNmTB
=xSvm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
