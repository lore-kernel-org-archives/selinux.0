Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CDQWgj012689
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 09:26:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CDQVMM007728
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 13:26:31 GMT
Message-ID: <4E9589F9.3090006@redhat.com>
Date: Wed, 12 Oct 2011 08:37:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Writing a program to monitor the SELinux log
References: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
In-Reply-To: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/2011 11:07 PM, Jason Axelson wrote:
> Hi,
> 
> I am writing a program that will monitor the SELinux log for AVC
> violations and deal with them appropriately. Currently I am looking
> at approaches to monitor the SELinux log.
> 
> One approach is to do raw monitoring of /var/log/audit/audit.log
> with something like: tail -f /var/log/audit/audit.log | ausearch -m
> avc
> 
> A second approach may be to implement an SETroubleShoot plugin: 
> https://fedorahosted.org/setroubleshoot/wiki/SETroubleShoot%20Overview
>
>  I'm kind of leaning towards an SETroubleShoot plugin since it
> seems like less new development and the infrastructure seems to be
> already there.
> 
> Is this a valid approach? Is there a better way?
> 
> Thanks, Jason
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
I would say either just write an setroubleshoot plugin or copy the
code in sedispatch from setroubleshoot to build your own audit
dispatcher, that watches for SELinux messages.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6VifkACgkQrlYvE4MpobM27QCcCOIwbMVqj4sdBmhwOuUZ0G1f
jOYAoKtoyaQVKo04heYaRAfoI2QMNKfw
=0DCd
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
