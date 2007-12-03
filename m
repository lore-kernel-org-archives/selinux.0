Message-ID: <47546249.5000606@redhat.com>
Date: Mon, 03 Dec 2007 15:08:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage patch
References: <4754599A.8060605@redhat.com> <6FE441CD9F0C0C479F2D88F959B0158801455C46@exchange.columbia.tresys.com> <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil> <6FE441CD9F0C0C479F2D88F959B0158801455C55@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801455C55@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Miller wrote:
> Stephen Smalley wrote:
>> Given that getline() returns the length read (not to be confused with
>> the buffer length), why not just:
>> 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
>> 		if (temp[len-1] == '\n') temp[len-1] = 0;
> 
> That is probably the simplest fix.
> 
>  - todd
Fine with me,  Do you want another patch.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVGJJrlYvE4MpobMRApYvAJ9IVdhR+SwUqZVdaTSayldB0LwQoACgyK4y
JovC/Zp6veX/jbP2m+qPbv0=
=5Azc
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
