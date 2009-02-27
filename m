Message-ID: <49A83A41.50601@redhat.com>
Date: Fri, 27 Feb 2009 14:08:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: PHP/SELinux: libselinux wrappers
References: <48C61A84.9010001@ak.jp.nec.com>	 <49A63527.2020104@ak.jp.nec.com> <1235659159.13059.91.camel@localhost.localdomain> <49A6ADE2.8040602@redhat.com> <06A6610D4F464D4EBEAFBF2C5F86911EE74492@exchange2.columbia.tresys.com> <49A74EB1.80508@ak.jp.nec.com>
In-Reply-To: <49A74EB1.80508@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KaiGai Kohei wrote:
> Joshua Brindle wrote:
>>> -----Original Message-----
>>> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
>>>
>>> I would rather package this up as part of libselinux, perhaps
>>> libselinux-php, rather then make a new package.
>>
>> The last time I used PHP (admittedly years ago) most if not all bindings
>> were included in the upstream PHP distribution.
> 
> At least, most of PHP extensions has php-* naming convension, like:
>   php-mysql, php-mbstring, php-ldap, ...
> 
> Most of major extensions are distributed as subpackages of php itself,
> but some of extensions are not distributed as separated package.
> (Please find php-* on the list of Fedora SRPMs.)
> 
> I don't think we need to wait for it get merged into the core PHP,
> to release php-selinux package.
> 
> Thanks,
Ok then fine leave it as a separate package.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmoOkEACgkQrlYvE4MpobNNlQCeJ5g1p/1Kt5dmbV/9Zv6J21kK
v3gAoNUFJHabexiVCCVDch/cEooK9s1W
=Nxx7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
