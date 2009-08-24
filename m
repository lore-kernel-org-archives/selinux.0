Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7ODsfKj010951
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 09:54:41 -0400
Received: from QMTA04.westchester.pa.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7ODtqsa004420
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 13:55:52 GMT
Subject: libsemanage issue with bzip-blocksize=0 and compressed modules in
 store
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 09:54:32 -0400
Message-Id: <1251122072.2916.16.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I took the current release of libsemanage and added the patch to add a
bzip blocksize option[1].  The modules in my store were already
compressed with the stock release.  I put bzip-blocksize=0 in my
semanage.conf and I do semodule -B and get:

libsepol.module_package_read_offsets: wrong magic number for module
package:  expected 0xf97cff8f, got 0x39685a42 (No such file or
directory).
libsemanage.semanage_load_module: Error while reading from module
file /etc/selinux/strict/modules/tmp/modules/apm.pp. (No such file or
directory).
semodule:  Failed!

If I do semodule -l, it will also get the magic number error.  If I
remove the blocksize option, it works again.  I was able to reinsert all
of the modules to get it working again with the blocksize 0 option.

[1] http://userspace.selinuxproject.org/trac/changeset/ee9827000137fed2d3300124115fc1572acafe2f

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
