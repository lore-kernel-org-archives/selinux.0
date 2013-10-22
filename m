Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MHCWtr006977
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 13:12:32 -0400
Message-ID: <5266B1EB.50206@redhat.com>
Date: Tue, 22 Oct 2013 13:12:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: hoefer@ieee.org, selinux@lists.fedoraproject.org,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Need information for building embedded system.
References: <24010477.117631.1382460349532.JavaMail.root@vms170025>
In-Reply-To: <24010477.117631.1382460349532.JavaMail.root@vms170025>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/22/2013 12:45 PM, Don Hoefer wrote:
> We are building an embedded system where the customer is requiring SELinux.
> It is our own hardware so we build our own kernel and drivers and use the
> ext2, jfs and tempfs file systems.  This is not new for us, but
> incorporating SELinux is.
> 
> Does anyone know of a good knowledge resource for building embedded
> systems with SELinux?
> 
> We are currently plowing through a frustrating step ahead/step back
> process.  We have SELinux running but it seems to be broken, for example
> one of our problems is that ls -Z shows "?" for SELinux file contexts: 
> root@generic-powerpc:/#getfattr -m . -d var # file: var 
> security.selinux="system_u:object_r:var_t"
> 
> root@generic-powerpc:/# ls -Z ? bin  ? boot  ? dev  ? etc  ? home  ? lib
> ?lost+found  ? media  ? mnt  ? proc ? sbin  ?selinux  ? share  ? sys  ? tmp
> ? usr  ? var  ?www
> 
> We were unsuccessful building policies on any of our development systems 
> (Ubuntu/Debian based) but we are now using a Fedora 19 system and that is 
> looking promising.
> 
> Any pointers or help would be appreciated.
> 
> Don Hoefer
> 
> 
> 
> -- selinux mailing list selinux@lists.fedoraproject.org 
> https://admin.fedoraproject.org/mailman/listinfo/selinux
> 

You really should ask this question on the upstream SELinux
<selinux@tycho.nsa.gov> list.

The reason the ls -Z command might not be working, is you have MLS turned on
and are missing the s0, so your label is seen as invalid.

On Fedora 21.
# getfattr -m . -d /var
getfattr: Removing leading '/' from absolute path names
# file: var
security.selinux="system_u:object_r:var_t:s0"


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJmsesACgkQrlYvE4MpobN4AACgrijpvSMl1/zDRbUvP3UnAZsj
5CMAoLfZ+ySGbO5/cLW8HCVtJPyjeXzo
=plDG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
