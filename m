Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5Q6es0S005629
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 02:40:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5Q6er5e000091
	for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 06:40:53 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
        by jazzband.ncsc.mil  with ESMTP id h5Q6eq92000088 for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2003 06:40:52 GMT
Subject: Re: small passwd.te zsh fixes
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306260710.55224.russell@coker.com.au>
References: <1056569473.3752.25.camel@columbia>
	 <200306260710.55224.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-AdvzXoyb6eAYwZr14t9k"
Message-Id: <1056609638.7566.1.camel@columbia>
Mime-Version: 1.0
Date: 26 Jun 2003 02:40:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-AdvzXoyb6eAYwZr14t9k
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-06-25 at 17:10, Russell Coker wrote:

> I recently changed my policy to not label such symlinks as shell_exec_t, the 
> current version in Debian does this so if you have the latest policy 
> installed and relabel /bin it should be fine.

Ok, that works too.  I just did that, thanks.

> I have just added a change to my policy to allow reading etc_t:lnk_file.

Cool.  I noticed afterwards that newrole needs this too; a patch is
attached.


--=-AdvzXoyb6eAYwZr14t9k
Content-Disposition: attachment; filename=newrole-te.patch
Content-Type: text/plain; name=newrole-te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/domains/program/newrole.te	Sat May 24=
 22:07:24 2003
+++ /etc/selinux/domains/program/newrole.te	Thu Jun 26 14:41:55 2003
@@ -39,6 +39,8 @@
 allow newrole_t bin_t:dir r_dir_perms;
 allow newrole_t bin_t:lnk_file read;
 allow newrole_t shell_exec_t:file r_file_perms;
+# For reading /etc/alternatives links.=20
+allow newrole_t etc_t:lnk_file read;
=20
 # Allow newrole_t to transition to user domains.
 domain_trans(newrole_t, shell_exec_t, userdomain)

--=-AdvzXoyb6eAYwZr14t9k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
