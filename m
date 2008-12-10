Message-ID: <493FE9FA.1030805@redhat.com>
Date: Wed, 10 Dec 2008 11:10:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org
Subject: Re: [PATCH] SELinux: open perms on sockets, AF_UNIX
References: <1228865476.3737.13.camel@localhost.localdomain>	 <1228916038.23307.1.camel@localhost.localdomain> <1228917917.3524.2.camel@localhost.localdomain>
In-Reply-To: <1228917917.3524.2.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------090809020403040002050903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090809020403040002050903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Paris wrote:
> On Wed, 2008-12-10 at 08:33 -0500, Stephen Smalley wrote:
> 
>>> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
>>> index c0c8854..31df1d7 100644
>>> --- a/security/selinux/include/av_perm_to_string.h
>>> +++ b/security/selinux/include/av_perm_to_string.h
>>> @@ -24,6 +24,7 @@
>>>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
>>>     S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
>>>     S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
>>> +   S_(SECCLASS_SOCK_FILE, SOCK_FILE__OPEN, "open")
>>>     S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
>>>     S_(SECCLASS_FD, FD__USE, "use")
>>>     S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
>>> @@ -152,6 +153,7 @@
>>>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write")
>>>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_RELAY, "nlmsg_relay")
>>>     S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READPRIV, "nlmsg_readpriv")
>>> +   S_(SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_TTY_AUDIT, "nlmsg_tty_audit")
>> Unrelated diff?  Defined in refpolicy yet?
> 
> Defined in policy, I'll run down if it is in refpolicy or only in the
> fedora policy (diff was created using fedora's latest policy).  Either
> way I think I need to get it fixed in refpolicy (and make use of it in
> upstream kernel but obviously that's another patch.)
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

You mean this patch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkk/6foACgkQrlYvE4MpobOS4gCfToVdCVOeOol52v46C4kOyCDx
CDgAoJ9Za1wHSEq6dvn46IggC1ZIARwN
=PcJV
-----END PGP SIGNATURE-----

--------------090809020403040002050903
Content-Type: text/plain;
 name="flask_access_vectors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="flask_access_vectors.patch"

--- nsaserefpolicy/policy/flask/access_vectors	2008-10-17 08:49:14.000000000 -0400
+++ serefpolicy-3.5.13/policy/flask/access_vectors	2008-11-24 10:49:49.000000000 -0500
@@ -616,6 +616,7 @@
 	nlmsg_write
 	nlmsg_relay
 	nlmsg_readpriv
+	nlmsg_tty_audit
 }
 
 class netlink_ip6fw_socket

--------------090809020403040002050903
Content-Type: application/octet-stream;
 name="flask_access_vectors.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="flask_access_vectors.patch.sig"

iEYEABECAAYFAkk/6foACgkQrlYvE4MpobOjlwCcC1wBE4L5g+i9GI8c/vy9MLF9ZF0An0Es
KeI9IolTUHcyWVlxStSvqmjk
--------------090809020403040002050903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
