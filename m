Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4HKKXlv002325
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 16:20:33 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4HKLkof028997
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 20:21:46 GMT
Message-ID: <4BF1A50C.3020001@redhat.com>
Date: Mon, 17 May 2010 16:20:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Two constraint violations
References: <5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/17/2010 03:11 PM, Alan Rouse wrote:
> 1.  When I boot to a desktop as user_t, then open a terminal, and execute 'su' to login as root, a file is created in the /root directory called .xauth0SiF7t.  That produces the following AVC:
> 
> type=AVC msg=audit(1274122005.740:4): avc: denied { create } for pid=4410 comm="su" name=".xauth0SiF7t" scontext=user_u:user_r:user_su_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
> 
> Audit2allow generates the an allow rule but tells me it is a constraint violation.
> 
> allow user_su_t default_t:file create;
> 
> Any insights into why this is happening / what I should do to fix it?
> 
> 2.  Note, I'm still also getting this AVC during system boot, for which audit2allow also generates a rule which is a constraint violation:
> 
> type=AVC msg=audit(1274121983.953:3): avc: denied { relablefrom } for pid=4335 comm="restorecond" name=".xsession-errors" dev=sda3 ino=127759 scontext=user_u:user_r:user_t:s0 tcontext=system_u:object_r:xauth_home_t:s0 tclass=file
> 
> Any insights into why this is happening / what I should do to fix it?
> 
> 
> 
> 
> 
> 
/root is mislabeled.  It should not be default_t.

Also user_t should probably not be allowed to run su.  Since it is a non
admin user.

In Fedora Policy, staff_t and user_t can not run su.  They need to use
sudo.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvxpQwACgkQrlYvE4MpobMPEwCfW9BVnCHfM6C1ZoHDJoQc8eGT
Yw4AniwXwMaewllrqic6dJgZ+FQg9n3I
=9gF5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
