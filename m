Message-ID: <46F02B57.5020805@redhat.com>
Date: Tue, 18 Sep 2007 15:47:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: Change default error handling in libselinux matchpathcon to	use
 syslog instead of stderr.
References: <46EFF028.4040500@redhat.com> <1190133805.14037.18.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190133805.14037.18.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050100030802030900090908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050100030802030900090908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2007-09-18 at 11:35 -0400, Daniel J Walsh wrote:
> Current behavior causes problems with network applications.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=273081
> 
>> I'm not sure about changing current behavior, as that is effectively an
>> "interface" change.  Or if it isn't, then there are other such changes I
>> would make too (e.g. changing the default for SETLOCALDEFS in libselinux
>> comes to mind).
> 
>> What if they used the newer interfaces introduced by Eamon (selabel*)?
>> setfiles has already been rewritten by him to use those interfaces, and
>> thus matchpathcon is a legacy interface at this point.  Does the same
>> problem exist there?
> 
>> I suppose that doesn't help you though with RHEL 5, as it would only
>> have the older interfaces.
> 
>> Changing the interface from one arbitrary default (stderr) to another
>> arbitrary default (syslog) doesn't seem like an improvement, although it
>> would fix this particular issue I suppose.  We would need to at least
>> make sure that setfiles -c continues to report the error messages as
>> expected.
> 
>> One comment below on the code itself.  
> 
plain text document attachment (diff)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c
libselinux-2.0.33/src/matchpathcon.c
- --- nsalibselinux/src/matchpathcon.c	2007-08-10 11:58:34.000000000 -0400
+++ libselinux-2.0.33/src/matchpathcon.c	2007-09-18 11:28:07.000000000 -0400
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdio.h>
+#include <syslog.h>
 #include "selinux_internal.h"
 #include "label_internal.h"
 #include "callbacks.h"
@@ -55,10 +56,12 @@
 #endif
     default_printf(const char *fmt, ...)
 {
+	char buf[BUFSIZ];
 	va_list ap;
 	va_start(ap, fmt);
- -	vfprintf(stderr, fmt, ap);
+	vsnprintf(buf, sizeof(buf) - 1, fmt, ap);
 	va_end(ap);
+	syslog(LOG_ERR, buf, strlen(buf));
 }

> Could you use vsyslog() instead to avoid the need for a fixed size
> buffer?


 void

Sure, I did not know that interface existed.

man syslog and
man 3 syslog are different.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG8CtXrlYvE4MpobMRArAnAJsGDG1/UQtq8O/3sOWsWg6mbs+OaACg11BH
44PynbOo4cSB9hcAq66yjiw=
=dPQV
-----END PGP SIGNATURE-----

--------------050100030802030900090908
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-2.0.33/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2007-08-10 11:58:34.000000000 -0400
+++ libselinux-2.0.33/src/matchpathcon.c	2007-09-18 15:45:42.000000000 -0400
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <errno.h>
 #include <stdio.h>
+#include <syslog.h>
 #include "selinux_internal.h"
 #include "label_internal.h"
 #include "callbacks.h"
@@ -57,7 +58,7 @@
 {
 	va_list ap;
 	va_start(ap, fmt);
-	vfprintf(stderr, fmt, ap);
+	vsyslog(LOG_ERR, fmt, ap);
 	va_end(ap);
 }
 

--------------050100030802030900090908
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG8CtXrlYvE4MpobMRApp2AKDHnxHbQuhSxTaGRvia8P7Is67/ZwCdHRVcR46GPR5N
WSmf9XVFz/9E6IU=
--------------050100030802030900090908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
