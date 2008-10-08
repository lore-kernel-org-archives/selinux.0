Message-ID: <48ECC291.7050305@redhat.com>
Date: Wed, 08 Oct 2008 10:24:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Alain Reguera Delgado <alain.reguera@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: Customizing SELinux Policy
References: <4c7a4b910810060614p3511ea1bv21a601069a6cf01c@mail.gmail.com>
In-Reply-To: <4c7a4b910810060614p3511ea1bv21a601069a6cf01c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alain Reguera Delgado wrote:
> Hi,
> 
> After some months with SELinux in Permesive mode
> ... Some avc:  denied messages were recorded ... I thought it was
> time for SELinux Enforcing mode in a CentOS-5.2 server with
> mail(postfix+cyrus+sasl), web, snmp with mrtg, squid ... it also has a
> local TLS configured for webmail access ...
> 
> I took a look to the RedHat Deployment Guide about how to do it ...
> and tried to build modules with audit2allow from the /var/log/message
> to allow some denied messages so the applications could work on a
> SELinux Enforcing mode (is that ok ?).
>
Yes although I would examine the generated rules to see if they don't
open a security hole.  You can always ask others to examine your
generated policy.

> The created modules seem to work fine, because old avc denied messages
> desappeard ... but some messages like the following appear at
> /var/log/messages when I do use a semodule -i modulename.pp or
> semodule -r modulename :
> 
> Oct  5 20:16:11 orion kernel: : exe="?" (sauid=81, hostname=?, addr=?,
> terminal=?)'
> Oct  5 20:16:11 orion kernel: audit(1223252171.572:8): policy loaded
> auid=4294967295 ses=4294967295
> Oct  5 20:16:41 orion kernel: audit(1223252201.673:9): user pid=2172
> uid=81 auid=4294967295 subj=system_u:system_r:system_dbus d_t:s0
> msg='avc:  received policyload notice (seqno=3)
> Oct  5 20:16:41 orion kernel: : exe="?" (sauid=81, hostname=?, addr=?,
> terminal=?)' Oct  5 20:16:41 orion kernel: audit(1223252201.676:10):
> policy loaded auid=4294967295 ses=4294967295
> Oct  5 20:17:51 orion kernel: audit(1223252271.462:11): user pid=2172
> uid=81 auid=4294967295 subj=system_u:system_r:system_dbu sd_t:s0
> msg='avc:  received policyload notice (seqno=4)
> Oct  5 20:17:51 orion kernel: : exe="?" (sauid=81, hostname=?, addr=?,
> terminal=?)' Oct  5 20:17:51 orion kernel: audit(1223252271.464:12):
> policy loaded auid=4294967295 ses=4294967295
> Oct  5 20:19:06 orion kernel: audit(1223252346.208:13): user pid=2172
> uid=81 auid=4294967295 subj=system_u:system_r:system_dbu sd_t:s0
> msg='avc:  received policyload notice (seqno=5)
> Oct  5 20:19:06 orion kernel: : exe="?" (sauid=81, hostname=?, addr=?,
> terminal=?)' Oct  5 20:19:06 orion kernel: audit(1223252346.211:14):
> policy loaded auid=4294967295 ses=4294967295
> Oct  5 20:19:11 orion kernel: audit(1223252351.331:15): user pid=2172
> uid=81 auid=4294967295 subj=system_u:system_r:system_dbu sd_t:s0
> msg='avc:  received policyload notice (seqno=6)
> 
> What does it means ?
> 
These are not denial messages.  Any time a policy is updated the audit
system gets notified that there has been a change.  In this case the
kernel is reporting that policy was updated and dbus is acknowledging
that it got the policy reload message.
> Also, in the /var/log/httpd/ssl_error_log the following messages begin
> to appear :
> 
> [Sun Oct 05 19:58:19 2008] [warn] RSA server certificate is a CA
> certificate (BasicConstraints: CA == TRUE !?)
> [Sun Oct 05 19:58:19 2008] [warn] RSA server certificate CommonName
> (CN) `example.com' does NOT match server name!?
> 
> Really rare because that name `example.com' is the
> actual server hostname. When try to connect to the webmail through
> https:// can't connect to it, the browser reports connection failed
> after a waiting of a few seconds. http:// works as expected.
> 
Nothing to do with SELinux I believe
> This machine is CentOS-5.2:
> 
> Linux example.com 2.6.18-92.1.13.el5 #1 SMP Wed Sep 24
> 19:33:52 EDT 2008 i686 i686 i386 GNU/Linux
> 
> Could you help me understand what's going on here ?
> 
> Thank you very much,
> al.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjswpEACgkQrlYvE4MpobO/TACgoG5jmFIAfjK/qYpuK1CJtkzY
/sEAnAwXnl/A9hcCMZzGQSDilULDf2kt
=C3L2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
