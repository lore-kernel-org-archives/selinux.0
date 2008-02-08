Message-ID: <47AC57F3.4010509@redhat.com>
Date: Fri, 08 Feb 2008 08:24:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Marshall Miller <mmiller@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: fixfiles: broken option processing?
References: <20080206154957.GA28647@bobek.pm.i.cz> <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil> <20080208082922.GA26640@bobek.pm.i.cz>
In-Reply-To: <20080208082922.GA26640@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Václav Ovsík wrote:
> On Thu, Feb 07, 2008 at 04:28:03PM -0500, Stephen Smalley wrote:
>> Hmm..the shifting of arguments was introduced in r2699 from Dan Walsh
>> (cc'd), diff is below.  Also relevant are r2736, r2750 and r2760.
>>
>> I'd agree that we don't want to break existing usage, but I'm not sure
>> what the least intrusive and cleanest fix is.
> 
> Ok. What about this patch :)
> 
> The interpreter is changed to /bin/bash.  There are bashisms (getopts,
> PIPESTATUS...), so this can't be interpreted by /bin/sh.
> 
> Regards
> 
This looks good to me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkesV/IACgkQrlYvE4MpobMndQCfRC9x2SUT/wwZmIAX2JlubED/
3LAAniOtNSEEldpmXGX/2vubL27yvezh
=1tZw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
