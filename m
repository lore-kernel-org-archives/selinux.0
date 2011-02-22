Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MERKIE031235
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 09:27:21 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MERJHx011970
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 14:27:20 GMT
Message-ID: <4D63C7C5.3090809@redhat.com>
Date: Tue, 22 Feb 2011 09:27:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Qwyjibo Jones <qwyjibojones@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux MLS and Virtual Machines
References: <AANLkTi=k2d=Tj5vyRyA5nbgNs3-yB-p19UxP4u_X0HHH@mail.gmail.com>
In-Reply-To: <AANLkTi=k2d=Tj5vyRyA5nbgNs3-yB-p19UxP4u_X0HHH@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/22/2011 08:39 AM, Qwyjibo Jones wrote:
> Hello,
> 
> I was poking around in the archives looking for information on running
> Virtual machines on a platform with the MLS policy.
> We have a Solaris TX system that we wanted to run Virtual Box on, but
> Oracle says the combination is not supported.
> 
> Would the combination be possible in the RHEL arena?
> Maybe something like RHEL 6, MLS policy and Xen or the RHEL VM stuff?
> Has anyone heard of such a beast?
> 
> Thanks
> 
We are working on making RHEL6/kvm work with MLS right now.  6.1 should
support this.  You could try it out now.  You should realize that
libvirt/kvm is actually locked down more in targeted policy then it
would be in MLS.

In targeted policy the virtual machines can not attack any other virtual
machine, since each virtual machine runs with a unigue MCS label and the
images match.  In MLS policy a virtual machine would be allowed to
attack any virtual machine that it Dominates.  So two TopSecret Virtual
Machines could attack each other if you had a hypervisor vulnerability.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1jx8UACgkQrlYvE4MpobPWuwCgoCTXcg37GBpsj0rzgI20JPJ3
8DsAmQFMeVXhBYdhvDHkZHoTcwdWGL1m
=ZafC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
