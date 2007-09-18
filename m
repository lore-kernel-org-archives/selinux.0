Message-ID: <46F02D0B.9020809@redhat.com>
Date: Tue, 18 Sep 2007 15:54:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Change default error handling in libselinux matchpathcon	to	use
 syslog instead of stderr.
References: <46EFF028.4040500@redhat.com> <46F0065B.1060101@manicmethod.com>	 <1190136184.14037.54.camel@moss-spartans.epoch.ncsc.mil>	 <46F00E55.9030100@manicmethod.com> <1190137543.14037.77.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190137543.14037.77.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030501020601050505030304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030501020601050505030304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2007-09-18 at 13:43 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Tue, 2007-09-18 at 13:09 -0400, Joshua Brindle wrote:
>>>   
>>>> Daniel J Walsh wrote:
>>>>     
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> Current behavior causes problems with network applications.
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=273081
>>>>>   
>>>>>       
>>>> Wait, what?
>>>>
>>>> I don't think it is an improvement to call the command line matchpathcon 
>>>> applications and have the logs go somewhere not visible by the user. IMO 
>>>> we should take the same approach libsemanage and libsepol did where the 
>>>> logging callbacks can be overridden by specific users of the library but 
>>>> for the command line applications the output still goes to stderr.
>>>>     
>>> You already can override the callback (set_matchpathcon_printf), but the
>>> claim in the bug report is that isn't usable from a library function
>>> that calls matchpathcon because it doesn't know whether it has already
>>> been set by the application.
>>>   
>> Hrm... so the alternative is to send it to syslog? I don't buy it. Can 
>> we just add an interface to see if the default callbacks have been 
>> overridden?
> 
> Yep.  And it should be based on the newer interfaces.  There is already
> a selinux_set_callback() and adding a selinux_get_callback() should be
> trivial.  setfiles is already rewritten to use the new interfaces in
> trunk, and we should be moving everything off of matchpathcon and onto
> selabel_lookup.
> 
> For RHEL 5, I suppose there might be a matchpathcon-specific interface
> for getting the callback.
> 
I would still prefer the default not to spew to stdout where an admin
might not see it or it might not get caught to using syslog.

Updated diff to include changing matchpathcon the exec

udev/install/mkinitrd/kerberos libraries and probably a few others are
using this interface.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG8C0LrlYvE4MpobMRApKVAKCx3bLTKq8pDe+rgARw6DdUo7O0wACgr5Cn
isUZTJ4Dh8jifv0uXaZ4xWI=
=HciW
-----END PGP SIGNATURE-----

--------------030501020601050505030304
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
 
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-2.0.33/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2007-07-16 14:20:45.000000000 -0400
+++ libselinux-2.0.33/utils/matchpathcon.c	2007-09-18 15:50:31.000000000 -0400
@@ -17,10 +17,24 @@
 	exit(1);
 }
 
+static void
+#ifdef __GNUC__
+    __attribute__ ((format(printf, 1, 2)))
+#endif
+    myprintf(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+}
+
 int printmatchpathcon(char *path, int header, int mode)
 {
 	char *buf;
-	int rc = matchpathcon(path, mode, &buf);
+	int rc;
+	set_matchpathcon_printf(myprintf);
+	rc = matchpathcon(path, mode, &buf);
 	if (rc < 0) {
 		fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
 			strerror(errno));

--------------030501020601050505030304
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG8C0LrlYvE4MpobMRAhUdAKDo1mp5D2OmVC0g0ihV09pTFiBV0QCcCv461sxp5s2v
65sP4fzy7LCfFSE=
--------------030501020601050505030304--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
