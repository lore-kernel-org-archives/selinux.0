Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m49EHNo7008713
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 10:17:23 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m49EHM3F000880
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 14:17:22 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m49EHLSG004221
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 10:17:21 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m49EHLQD031342
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 10:17:21 -0400
Received: from localhost.localdomain (vpn-14-235.rdu.redhat.com [10.11.14.235])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m49EHJ6k014083
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 10:17:20 -0400
Message-ID: <48245CD6.2060206@redhat.com>
Date: Fri, 09 May 2008 10:16:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I think this is a bug in the kernel
References: <4824560E.8060500@redhat.com>
In-Reply-To: <4824560E.8060500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
| https://bugzilla.redhat.com/show_bug.cgi?id=445709
|
| libvirtd is clearly not ptracing the unconfined_t domain.  It is
| problably looking under /proc for some information about the app that is
| communicating with it.  It might be reading unconfined_t environment.  I
| am not sure, but we generate a ptrace and stop the app from working.  My
| only choice is to allow virtd to ptrace unconfined_t processes which is
| not a good idea.  This has to be fixes in the kernel.
|
| Dan

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

Replying to my own email...

Looks like the kernel has it on its todo list...

~ *  Finer-grained proc checking (so that we don't require full ptrace
permission just to read process state),

Well I think we need to jump the priority here.

User apps seem to be doing things like looking at the remote end of the
socket and checking the environment for special cookies in the case of
consolehelper/policykit.  Or may looking to see where the kerberos
tickets are located.  Whether this is a legitimate use or not, it is
being done.  So we need to handle it.  But I have a real concern about
allowing virtd_t to ptrace unconfined_t process.

Basically in order to allow virtd_t to verify the unconfined_t process
that is trying to communicate with it, we need to allow it to read the
memory of every unconfined_t process on the system.  Not good.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgkXNYACgkQrlYvE4MpobOC4ACcChtet42S8Y7ffL0l82Eb4FDM
zJEAn2Kxb9sx2SXP87kTUMvbiIurarH8
=3qY6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
