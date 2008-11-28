Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mASCYkPD013858
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2008 07:34:46 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mASCYkbZ012521
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2008 12:34:46 GMT
Message-ID: <492FE563.2040808@redhat.com>
Date: Fri, 28 Nov 2008 07:34:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Dominick Grift <domg472@gmail.com>
Subject: Re: user guide draft: "Booleans for Users Executing Applications"
References: <492F6CF4.3080405@redhat.com>
In-Reply-To: <492F6CF4.3080405@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Hi,
> 
> In the "Confined and Unconfined Users" section[1], the confined user
> table states that guest_u, xguest_t etc. can not execute applications in
> ~/ or /tmp. I have changed the "no"'s and "yes"'s to "optional", with a
> link to the following section that appears at the end of the "Confining
> Users" chapter[2]:
> 
> Booleans for Users Executing Applications
> 
> By default, Linux users in the guest_t and xguest_t domains can not
> execute applications in their home directories or /tmp/, preventing them
> from executing applications (which inherit users' permissions) in
> directories they have write access to. This helps prevent flawed or
> malicious applications from modifying files users' own.
> 
> The setsebool command must be run as the Linux root user. The setsebool
> -P command makes persistent changes. Do not use the -P option if you do
> not want changes to persist across reboots:
> 
> guest_t
> 
> To allow Linux users in the guest_t domain to execute applications in
> their home directories and /tmp/:
> 
> /usr/sbin/setsebool allow_guest_exec_content on
> 
> xguest_t
> 
> To allow Linux users in the xguest_t domain to execute applications in
> their home directories and /tmp/:
> 
> /usr/sbin/setsebool allow_xguest_exec_content on
> 
> user_t
> 
> To prevent Linux users in the user_t domain from executing applications
> in their home directories and /tmp/:
> 
> /usr/sbin/setsebool allow_user_exec_content off
> 
> staff_t
> 
> To prevent Linux users in the staff_t domain from executing applications
> in their home directories and /tmp/:
> 
> /usr/sbin/setsebool allow_staff_exec_content off
> 
> Thanks.
> 
> 
> [1]
> <http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/sect-Security-Enhanced_Linux-Targeted_Policy-Confined_and_Unconfined_Users.html>
> 
> 
> [2]
> <http://docs.fedoraproject.org/selinux-user-guide/f10/en-US/chap-Security-Enhanced_Linux-Confining_Users.html>
> 
Ok looks good.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkv5WMACgkQrlYvE4MpobNGdACeJ6NSPNZJH4V6eEcPgSkXxn37
oksAoK0pHIKQotXe6r9k0cku+9Y9WqOe
=jMMt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
