Message-ID: <484FDD0C.2010708@redhat.com>
Date: Wed, 11 Jun 2008 10:11:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Chad Hanson <chanson@TrustedCS.com>,
        Joshua Brindle <method@manicmethod.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: releasibility in mcstransd
References: <484D91BB.3080904@manicmethod.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F23@HAVOC.tcs-sec.com> <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com>
In-Reply-To: <0D76DBC9-5AF4-43C4-8F38-3B7BAD9F2A1F@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joe Nall wrote:
|
| On Jun 9, 2008, at 4:04 PM, Chad Hanson wrote:
|
|>
|> Seems reasonable to me unless you want to create a nice new encoding
|> language ;)
|>
|> How would the user process translate, eg, s0:c102.c128, just s0?
|>
|> -Chad
|
| Attached is a source rpm based on the mcstransd we are using internally.
| It can translate ranges that look like:
|
| Secret Releasable to USA/FRA/DEU/ZWI
| Confidential Rel GBR
| Secret A
| Secret Noforn
| Secret Rel to USA/GBR-Secret Noforn
| Restricted Handle Via Iron,Plastic,Copper Pipes Only-Restricted Handle
| Via Iron Pipes Only
| ...
|
| It supports the idea of default inverse bits, multiple domains of
| translation (still needs some protocol support) and aliases for levels
| and compartments. The example setrans.conf include an implementation of
| releasabilities based on ISO 3166 three letter country codes and FIPS-10
| two letter country codes pulled from the CIA World Factbook. Any
| combination or permutation of releasabilities with arbitrary prefix and
| suffix is supported.
|
| There is an include mechanism to allow segregating category
| configuration into separate files of related words and a python test
| harness with the tests in separate files.
|
| We have used the code internally to translate the US CAPCO markings
| standard (minus the words with '-' in them).
|
| I've been meaning to release it for the better part of a year and Josh's
| email persuaded me to go ahead even though there are a number of things
| remaining on the TO DO list:
|  - a simple constraints language so you can say that categories foo and
| bar can not be in the same level together.
|  - finish the multiple domain of translation support (multiple languages
| and paragraph markings)
|  - more hardening
|  - better first translation performance (subsequent translations are
| cached)
|  - words with embedded '-'
|  - man pages :(
|
| There is a README in the conf directory describing the configuration
| file format and a number of examples in the sample configuration and
| test files.
|
| To install and test (as root in MLS/Permissive)
|
| rpm -ivh mcstrans-0.3.0-1.jnall.src.rpm
| rpmbuild -bb /usr/src/redhat/SPECS/mcstrans.spec
| rpm -Uvh /usr/src/redhat/RPMS/*/mcstrans-*.rpm
|
| cd /usr/src/redhat/BUILD/mcstrans-0.3.0/conf
| cp -rp setrans.conf setrans.d /etc/selinux/mls/
| restorecon -rv /etc/selinux/mls
| service mcstrans restart
|
| cd /usr/src/redhat/BUILD/mcstrans-0.3.0/utils
| make test
|
| joe
|
Please review this patch, the people who understand it  :^(.  And I will
update the Fedora package if it works for everyone.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhP3QsACgkQrlYvE4MpobM+VACgpDenfOo53Yca6FdI8j3tnoKl
qjEAoJUg/D09b7vmaMuDO3qKoxC3TcYk
=wSch
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
