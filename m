Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EEUV3D016205
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 10:30:31 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EETxln020862
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 14:30:00 GMT
Message-ID: <4BC5D183.20403@redhat.com>
Date: Wed, 14 Apr 2010 10:30:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jimi@sngx.net
CC: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net>
In-Reply-To: <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/13/2010 07:00 AM, James Cammarata wrote:
> 
> On Wed, 14 Apr 2010 08:35:56 -0400, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
>> sudo in RHEL6 and F11 and beyond added newrole type functionality to
>> sudo.  This package will not be back ported to RHEL5.  (Sorry).
>> One option would be to add newrole to a shell script executed by sudo.
>>
>> sudo audit.sh
>>
>> cat audit.sh
>> newrole -r auditadm_r -t auditadm_t COMMAND
>>
>> Then add pam_rootok to /etc/pam.d/newrole
> 
> That's a bit of a bummer.  I had seen your discussions with the sudo devs
> that was about a year or more old, so I was hoping this had found its way
> into RHEL already.  I'll test this workaround today and see if it does what
> I want.
> 
> Thanks!
> 
> James C.
> 
We are very careful of what we backport and sudo has not come up on the
priority list.  With Shipping versions of RHEL we are hesitant to make
major modifications that could cause a regression.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvF0YMACgkQrlYvE4MpobPGzgCfQ3u1wyKbY1WPe+fRag26LJOJ
P+cAoJn25VdzqcmshsjbF8u/cSGkQkli
=4jz7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
