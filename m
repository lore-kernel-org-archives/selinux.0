Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4RKlIxJ010790
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 16:47:18 -0400
Received: from hermod.iguanait.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4RKlG0X013836
	for <selinux@tycho.nsa.gov>; Tue, 27 May 2008 20:47:17 GMT
Message-ID: <20080527224706.82eyd662sggsss0g@hermod.iguanait.com>
Date: Tue, 27 May 2008 22:47:06 +0200
From: Ali Nebi <anebi@iguanait.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problem with multisame specification warning messages RHEL 5
References: <1211791497.5210.21.camel@hugo.iguanait.com>
	<483BFB76.2050306@redhat.com>
In-Reply-To: <483BFB76.2050306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Daniel J Walsh <dwalsh@redhat.com>:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Ali Nebi wrote:
> | Hi,
> |
> | we have installed RHEL 5 and after update we get these warnings:
> |
> | /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
> | specifications for /usr/local/lost\+found/.*.
> | /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
> | specifications for /usr/local/\.journal.
> | /etc/selinux/targeted/contexts/files/file_contexts: Multiple same
> | specifications for /usr/local/lost\+found.
> |
> | I tried to remove these with semanage tool this way:
> |
> | semanage fcontext -d "/usr/local/lost\+found/.*"
> |
> | /usr/sbin/semanage: File context for /usr/local/lost\+found/.* is
> | defined in policy, cannot be deleted
> |
> | I got the error above, that i can't delete this policy, because it is
> | defined in policy. How can i fix this problem? If i edit manually user
> | definitions file, will it be generated automatically after restart and i
> | will get the same warnings?
> |
> | There is already a bug report in centos bugzilla. But i would like to
> | find out how to fix this problem.
> |
> | Please help me for this.
> |
> | Thanks in advanced!
> |
> |
> | --
> | This message was distributed to subscribers of the selinux mailing list.
> | If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> | the words "unsubscribe selinux" without quotes as the message.
>
> This usually means the system thinks you have a user account home
> directory in /usr/local,  If there is a system account in /usr/local
> make sure its shell is /sbin/nologin or /bin/false and then run semodule -B
>
> To regenerate the home directory file context.
>
> If you have real users with the home directory in /usr/local, you need
> to move them in order for SELinux to get the file labelling correct.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkg7+3UACgkQrlYvE4MpobO1kwCfR1a+RaI0l5bTqvqwiKx/OHqA
> AoQAoM0RJN5atVpEseTgnHzxkXRCuZCj
> =30dH
> -----END PGP SIGNATURE-----

Thanks a lot. This solve the problem.

Regards, Ali Nebi!


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
