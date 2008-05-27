Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RCHPJH012069
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 08:17:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RCHPXs008157
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 12:17:25 GMT
Message-ID: <483BFB76.2050306@redhat.com>
Date: Tue, 27 May 2008 08:15:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: anebi@iguanait.com
CC: selinux@tycho.nsa.gov
Subject: Re: Problem with multisame specification warning messages RHEL 5
References: <1211791497.5210.21.camel@hugo.iguanait.com>
In-Reply-To: <1211791497.5210.21.camel@hugo.iguanait.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ali Nebi wrote:
| Hi,
|
| we have installed RHEL 5 and after update we get these warnings:
|
| /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
| specifications for /usr/local/lost\+found/.*.
| /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
| specifications for /usr/local/\.journal.
| /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
| specifications for /usr/local/lost\+found.
|
| I tried to remove these with semanage tool this way:
|
| semanage fcontext -d "/usr/local/lost\+found/.*"
|
| /usr/sbin/semanage: File context for /usr/local/lost\+found/.* is
| defined in policy, cannot be deleted
|
| I got the error above, that i can't delete this policy, because it is
| defined in policy. How can i fix this problem? If i edit manually user
| definitions file, will it be generated automatically after restart and i
| will get the same warnings?
|
| There is already a bug report in centos bugzilla. But i would like to
| find out how to fix this problem.
|
| Please help me for this.
|
| Thanks in advanced!
|
|
| --
| This message was distributed to subscribers of the selinux mailing list.
| If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
| the words "unsubscribe selinux" without quotes as the message.

This usually means the system thinks you have a user account home
directory in /usr/local,  If there is a system account in /usr/local
make sure its shell is /sbin/nologin or /bin/false and then run semodule -B

To regenerate the home directory file context.

If you have real users with the home directory in /usr/local, you need
to move them in order for SELinux to get the file labelling correct.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkg7+3UACgkQrlYvE4MpobO1kwCfR1a+RaI0l5bTqvqwiKx/OHqA
AoQAoM0RJN5atVpEseTgnHzxkXRCuZCj
=30dH
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
