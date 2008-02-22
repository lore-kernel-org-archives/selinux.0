Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MKloDl005720
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 15:47:50 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MKlliH027208
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 20:47:47 GMT
Message-ID: <47BF347C.4090006@redhat.com>
Date: Fri, 22 Feb 2008 15:45:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Not that anyone would ever run in permissive mode but...
References: <47BF1EBD.6050603@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880195C742@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880195C742@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> This patch is needed for sudo.
>>
>> Also added setkeycreatecon, although this will not work the way the
>> code is currently.
>>
>> Pam activity should probably be happening after setkeycreatecon and
>> setexeccon
>>
>> But I am not sure how pam_keyinit should work here any ways.
>>
>> Currently you loose access to your keying material when you su or
>> sudo. 
>>
>> These things will not be labeled corectly as currently used.
> 
> Thanks, I've merged that into the sudo tree.  I think I understand
> why setkeycreatecon and setexeccon ought to be called before PAM.
> 
> I am correct in believing that the tty does _not_ need to be relabeled
> before calling PAM since the conversation function runs in the current
> context?
> 
>  - todd
Yes the problem is there is no good solution to this.  Since in some
cases you want jobs to run in the current context and others you want
them in the users context.

Same problem as DAC though.

Should pam_session be run in UID 0 or in my UID.  No good answer.

pam_keyinit is removing the current keyring and creating a new one.  In
the login programs this is happing after pam_selinux open so they get a
keyring labeled user_t or staff_t.  But sudo closes these and opens one
labeled staff_sudo_t.  If the setkeycreate call happened before the
pam_session it would be webadm_t.  But fixing this here would help, but
su has the same problem, and su has no selinux awareness.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke/NHwACgkQrlYvE4MpobOmKwCgwUlu3/ImJh6ib71naqOnCaS8
QtYAoJXiHksHBYUyKMsbcv0Ny3ArhoZD
=okAi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
