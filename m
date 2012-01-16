Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0GEl6Kn011597
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2012 09:47:06 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0GEl4bE027340
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2012 14:47:04 GMT
Message-ID: <4F143862.9050107@redhat.com>
Date: Mon, 16 Jan 2012 09:46:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: SELinux with initramfs
References: <20120114142001.GA5632@siphos.be> <20120114143421.GB5632@siphos.be> <4F11A36F.1050001@gentoo.org>
In-Reply-To: <4F11A36F.1050001@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/14/2012 10:46 AM, Chris PeBenito wrote:
> On 1/14/2012 9:34 AM, Sven Vermeulen wrote:
>> On Sat, Jan 14, 2012 at 03:20:02PM +0100, Sven Vermeulen wrote:
>>> An initramfs' /init will run in the kernel_t domain (and
>>> unconfined until load_policy is called ?)
>> 
>> Not unconfined, permissive.
> 
> It will run in the kernel initial SID ("kernel") until a policy is 
> loaded.  Before the policy is loaded, it isn't permissive per se,
> as there is nothing to enforce.  SELinux is disabled in the "no
> policy loaded" sense (as opposed to the kernel command line
> selinux=0, unregistered SELinux LSM sense).  Once the policy is
> loaded, all of the labels will be set based on their initial SID;
> thus, the "kernel"-labeled processes get the kernel initial SID in
> the policy, kernel_t, and the initial enforcing/permissive state
> will be set based on the kernel command line enforcing= option,
> /etc/selinux/config, or kernel compiled-in default.
> 
In RHEL and Fedora, we relabel the parts of /dev that are created in
the initramfs and restart udev so it is a child of init/systemd.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8UOGIACgkQrlYvE4MpobMdlACgvXdEx/wUtQjYu57ZePozHjuB
UUoAn2a55fOXacNqJfn5bwxN2ADs41eD
=Obn1
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
