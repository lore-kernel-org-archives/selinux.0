Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GFDZ5w019051
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 11:13:37 -0400
Message-ID: <4F63589D.7030500@redhat.com>
Date: Fri, 16 Mar 2012 11:13:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Mikhail Efremov <mikhefr@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] policycoreutils: newrole: Fix drop_capabilities().
References: <20120316165040.1509ef42@c203.office.altlinux.ru> <4F634242.6060400@redhat.com> <20120316183001.47f2b13c@c203.office.altlinux.ru>
In-Reply-To: <20120316183001.47f2b13c@c203.office.altlinux.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/16/2012 10:30 AM, Mikhail Efremov wrote:
> On Fri, 16 Mar 2012 09:38:10 -0400 Daniel J Walsh wrote:
>> On 03/16/2012 08:50 AM, Mikhail Efremov wrote:
>>> Hello!
>>> 
>>> The CAP_* constants should not be or'ed, it is the bit numbers.
>>> And grant the access to the audit system too.
>> 
>> I talked to the developer of libcap-ng  (Steve Grubb) and he
>> stated that you are correct but "you should use the 'v' version
>> of update which allows you to update in just 1 library call. The 
>> capabilities should be separated with a comma and to mark the end
>> you put a -1:"
>> 
>> capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, 
>> CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN, CAP_DAC_OVERRIDE,
>> CAP_SETPCAP, CAP_AUDIT_WRITE, - -1);
> 
> Thanks, I didn't notice this function. Here are updated patches.
> 
The other problem I have with newrole is that we probably should not
drop the BOUNDING Set, since after you newrole you should be still
allowed to execute apps that use capabilities.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9jWJwACgkQrlYvE4MpobO7kACgznmNJ1vLL7gnHQx3Nm6JnFRr
Us4AoK93Sgn1USp9PHWr1CXhOE1LBYVu
=2sw5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
