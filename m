Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2NKbgDo025844
	for <selinux@tycho.nsa.gov>; Wed, 23 Mar 2005 15:37:42 -0500 (EST)
Subject: Re: New policy for pyzor
From: David Hampton <hampton-rh@rainbolthampton.net>
To: jwcart2@epoch.ncsc.mil
Cc: SELinux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
In-Reply-To: <1111605242.3856.24.camel@moss-lions.epoch.ncsc.mil>
References: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net>
	 <1111605242.3856.24.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-VZANxfGIl4UT55yqs0oG"
Date: Wed, 23 Mar 2005 15:37:33 -0500
Message-Id: <1111610253.26996.16.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VZANxfGIl4UT55yqs0oG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-23 at 14:14 -0500, James Carter wrote:
> >From pyzor.te:

> Why home_domain_access()?

If you don't specify a directory with the --homedir argument, pyzor
creates a ~/.pyzor directory to store its files.  I've had them created
as both /root/.pyzor and /home/david/.pyzor depending upon which uid I
use to run the applications.  Try something like:

  cat virus-20050321-104527-01034-08 | pyzor check

as various users.

> There is no sysadm_pyzor_home_t defined, so it causes an error.

Oops.  That would be because I forgot to include a diff to
base_user_macros.te.  Attached below.

David


--=-VZANxfGIl4UT55yqs0oG
Content-Disposition: attachment; filename=base_user_macros.diffs
Content-Type: text/x-patch; name=base_user_macros.diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: macros/base_user_macros.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/macros/base_user_macros.te,v
retrieving revision 1.1
diff -u -r1.1 base_user_macros.te
--- macros/base_user_macros.te	23 Mar 2005 20:30:17 -0000	1.1
+++ macros/base_user_macros.te	23 Mar 2005 16:10:40 -0000
@@ -185,6 +185,8 @@
 ifdef(`ssh.te', `ssh_domain($1)')
 ifdef(`irc.te', `irc_domain($1)')
 ifdef(`using_spamassassin', `spamassassin_domain($1)')
+ifdef(`pyzor.te', `pyzor_domain($1)')
+ifdef(`razor.te', `razor_domain($1)')
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')

--=-VZANxfGIl4UT55yqs0oG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
