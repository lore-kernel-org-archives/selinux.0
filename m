Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3FK8LZ6020135
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 16:08:21 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3FK9GaX004947
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2010 20:09:16 GMT
Message-ID: <4BC77231.7010108@redhat.com>
Date: Thu, 15 Apr 2010 16:08:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jimi@sngx.net
CC: Selinux <selinux@tycho.nsa.gov>
Subject: Re: sudo + selinux
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net> <4BC5D183.20403@redhat.com> <3acfd6eb614d7ebec2d3c10d98940708@sngx.net> <4BC5F226.5090006@redhat.com> <34f60e632890202669f67e9498c0fa9e@sngx.net> <4BC7511F.90100@redhat.com> <6ca2b6d9d71e1b8e0b6f4b2656d924c2@sngx.net> <43c51087c230c590d8eadc3b58fbbc07@sngx.net>
In-Reply-To: <43c51087c230c590d8eadc3b58fbbc07@sngx.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/14/2010 12:37 PM, James Cammarata wrote:
> 
> On Wed, 14 Apr 2010 11:16:56 -0500, James Cammarata <jimi@sngx.net> wrote:
>>>>
>>> Does this work in permissive mode?
>>
>> Actually, no, it doesn't, but I think I found the problem.  I was
> assuming
>> all I needed at the end of newrole was --, but the man page says to use
> "--
>> -c", which does seem to be working now.  Turning enforcing back on:
>>
>> [test@kvm001 ~]$ sudo /usr/bin/audit.sh echo "hi there"
>> Password:
>> hi there
>>
>> So, that seems to be good, but it's still asking for the password for the
>> selinux user.  Is pam_rootok not doing what it's supposed to?
The problem is rootok requires and SELinux priv to work also.  So this
will not work unless you add the rootok to your default userdomain.

allow staff_t self:passwd rootok;

> 
> Something else weird... I added a shebang line to the top of the audit.sh
> script, and now when I run it I don't get prompted for a password, but it
> fails with this message:
> 
> [test@kvm001 ~]$ sudo /usr/bin/audit.sh echo hi
> Could not determine enforcing mode.
> 
> Once again, there are no AVC's in the audit.log.  I did have to add this to
> my custom policy though:
> 
> allow staff_sudo_t newrole_exec_t:file { execute execute_no_trans };
> 
> 

Add an id -Z to the top of audit.sh
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvHcjEACgkQrlYvE4MpobN31ACfYdQCBQmXVWjPINEa5q3Y1/Nc
l2gAoN29FupLNXfkgWZTwceeHKSWG2/1
=o+05
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
