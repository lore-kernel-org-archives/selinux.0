Message-ID: <4880D3F0.4030507@redhat.com>
Date: Fri, 18 Jul 2008 13:33:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Critical bug in semanage
References: <487F93C3.1040701@redhat.com>  <4880B872.20202@manicmethod.com> <1216402217.17602.324.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1216402217.17602.324.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-07-18 at 11:36 -0400, Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> homedirs in /var and /usr/local were not being matched, causing bad
>>> context to be added.
>>>
>>> genhomedircon port problem.
>>>
>>> An extra / at the end of the regex was causing the problem
>>>
>>> Geesh I love 'C'.  :^P
>> It has less to do with C and more to do with crazy string libraries :)
>>
>> I'm not sure what the intention is here though, the comment directly below your patch says
>> " 	/* Append pattern to eat up trailing slashes */"
>>
>> How is that not what you are trying to do?
> 
> Trailing / in the pathname regex versus trailing / in the pathname being
> matched, IIUC.
> 
Yes the problem wat the tool was not matching

/var/.* system_u:object_r:var_t:s0

Ended up trying to compare
/var/ to /var

And failing to see the similarities.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiA0/AACgkQrlYvE4MpobMG0ACfSKO9rfQC9iB44zxC5mrIMqKF
anIAn1pKhwbklwdVUPtAElYjEoN6s4t1
=hEeI
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
