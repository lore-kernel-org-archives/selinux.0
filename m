Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACJXTC014155
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:19:33 -0400
Message-ID: <518CE5CD.8000809@redhat.com>
Date: Fri, 10 May 2013 08:19:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: audit2allow/sepolgen not setting the locale properly when calculating
 the bootdate
References: <20130509225106.7191c1df@soldur.bigon.be>
In-Reply-To: <20130509225106.7191c1df@soldur.bigon.be>
Content-Type: multipart/mixed;
 boundary="------------060003050704070203050300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060003050704070203050300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/09/2013 04:51 PM, Laurent Bigonville wrote:
> Hello,
> 
> When using a locale that use the date format other than MM/DD/YY, 
> allow2audit -b is not working properly (shows <no matches>). The ausearch
> executable is expecting the date to be formatted in the user locale.
> 
> Explicitly setting "locale.setlocale(locale.LC_ALL, '')" inside the 
> sepolgen get_audit_boot_msgs() function (or in the allow2audit executable)
> is passing the correct date to the ausearch executable.
> 
> I'll propose a patch for this if you want, but I'm not sure if you would 
> prefer this to be fixed in the audit2allow executable or in the sepolgen 
> python library.
> 
> Cheers
> 
> Laurent Bigonville
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
We have a patch for this in Fedora now.  Attach patch is the difference
between upstream and Fedora.  Eric and I will begin putting together a series
of patches to get Fedora patches into upstream.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGM5c0ACgkQrlYvE4MpobOBaACg072AlvtRX5zX0Q/p7bvdUrJS
zqgAniqFg98UT4pu9cfOaa1t+lJpQGr4
=4dHo
-----END PGP SIGNATURE-----

--------------060003050704070203050300
Content-Type: text/x-patch;
 name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit2allow.patch"

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 8e0c396..1059bea 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -18,7 +18,7 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
-import sys
+import sys, os
 
 import sepolgen.audit as audit
 import sepolgen.policygen as policygen
@@ -29,6 +29,8 @@ import sepolgen.defaults as defaults
 import sepolgen.module as module
 from sepolgen.sepolgeni18n import _
 import selinux.audit2why as audit2why
+import locale
+locale.setlocale(locale.LC_ALL, '')
 
 class AuditToPolicy:
     VERSION = "%prog .1"
@@ -80,8 +82,7 @@ class AuditToPolicy:
         parser.add_option("--interface-info", dest="interface_info", help="file name of interface information")
         parser.add_option("--debug", dest="debug", action="store_true", default=False,
                           help="leave generated modules for -M")
-
-        parser.add_option("-w", "--why", dest="audit2why",  action="store_true", default=False,
+        parser.add_option("-w", "--why", dest="audit2why",  action="store_true", default=(os.path.basename(sys.argv[0])=="audit2why"),
                           help="Translates SELinux audit messages into a description of why the access was denied")
 
         options, args = parser.parse_args()
@@ -267,12 +268,10 @@ class AuditToPolicy:
                     continue
 
                 if rc == audit2why.CONSTRAINT:
-                    print "\t\tPolicy constraint violation.\n"
-                    print "\t\tMay require adding a type attribute to the domain or type to satisfy the constraint.\n"
-                    print "\t\tConstraints are defined in the policy sources in policy/constraints (general), policy/mcs (MCS), and policy/mls (MLS).\n"
-                    for reason in data:
-                        print "\t\tNote: Possible cause is the source and target %s differ\n" % reason
-                    continue
+                    print #!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.\n"
+                    print "#Constraint rule: \n\t" + data[0]
+                    for reason in data[1:]:
+                        print "#\tPossible cause is the source %s and target %s are different.\n\b" % reason
 
                 if rc == audit2why.RBAC:
                     print "\t\tMissing role allow rule.\n"
@@ -350,6 +349,9 @@ class AuditToPolicy:
         except ValueError, e:
             print e
             sys.exit(1)
+        except IOError, e:
+            print e
+            sys.exit(1)
 
 if __name__ == "__main__":
     app = AuditToPolicy()

--------------060003050704070203050300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
