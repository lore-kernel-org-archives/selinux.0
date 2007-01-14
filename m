Message-ID: <45AA8C62.4020800@us.ibm.com>
Date: Sun, 14 Jan 2007 14:02:42 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] clarifications for -l to newrole.1
References: <45A6A064.2040707@us.ibm.com> <1168549320.7993.458.camel@moss-spartans.epoch.ncsc.mil> <45A6D0A1.6020301@us.ibm.com> <1168614985.7993.494.camel@moss-spartans.epoch.ncsc.mil> <45A7B520.5090405@us.ibm.com> <1168638769.7993.604.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168638769.7993.604.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060205070503060405050509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060205070503060405050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Fri, 2007-01-12 at 10:19 -0600, Michael C Thompson wrote:
>> Stephen Smalley wrote:
>> <snip>
>>> Looks sane as far as content is concerned, although I don't understand
>>> the author ordering (I'd typically expect alphabetically by last name or
>>> by amount of involvement or by date of involvement).  But it doesn't
>>> apply (whitespace damage) for me.   Also, please make the patch -p1
>>> appliable from the top of the tree, e.g. result of svn diff
>>> policycoreutils.
>> I've reordered the authors in alphabetical order, and re-patched with -p1.
> 
> Still whitespace damaged. See:
> http://mbligh.org/linuxdocs/Email/Clients/Thunderbird
> 
> Or just attach it.

Bugger, that's what I normally do, but thought this would be ok... guess 
not :)

> BTW, newrole.c also has an Authors list in the comments, so either needs
> to be updated or dropped.

Added the names that are in the man page, I'm not sure if its 100% or 
not, but its included with the patch.

Thanks,
Mike

---


--------------060205070503060405050509
Content-Type: text/x-diff;
 name="newrole-man_author.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole-man_author.patch"

diff -Naur policycoreutils-1.33.12.orig/newrole/newrole.1 policycoreutils-1.33.12/newrole/newrole.1
--- policycoreutils-1.33.12.orig/newrole/newrole.1	2007-01-11 13:01:39.000000000 -0600
+++ policycoreutils-1.33.12/newrole/newrole.1	2007-01-12 10:15:14.000000000 -0600
@@ -57,16 +57,45 @@
 .B --version
 shows the current version of newrole
 .PP
+.SH EXAMPLE
+.br
+Changing role:
+   # id -Z
+   staff_u:staff_r:staff_t:SystemLow-SystemHigh
+   # newrole -r sysadm_r
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
+
+Changing sensitivity only:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
+
+.PP
+Changing sensitivity and clearance:
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
+   # newrole -l Secret-Secret
+   # id -Z
+   staff_u:sysadm_r:sysadm_t:Secret
+
 .SH FILES
 /etc/passwd - user account information
 .br
 /etc/shadow - encrypted passwords and age information
+.br
+/etc/selinux/<policy>/contexts/default_type - default types for roles
+.br
 .SH SEE ALSO
-.B su
-(1),
-.B runas
+.B runcon
 (1)
 .SH AUTHORS
 .nf
-Tim Fraser (tfraser@tislabs.com) 
-Anthony Colatrella (amcolat@epoch.ncsc.mil)
+Anthony Colatrella
+Tim Fraser
+Steve Grubb <sgrubb@redhat.com>
+Darrel Goeddel <DGoeddel@trustedcs.com>
+Michael Thompson <mcthomps@us.ibm.com>
+Dan Walsh <dwalsh@redhat.com>
diff -Naur policycoreutils-1.33.12.orig/newrole/newrole.c policycoreutils-1.33.12/newrole/newrole.c
--- policycoreutils-1.33.12.orig/newrole/newrole.c	2007-01-11 13:01:39.000000000 -0600
+++ policycoreutils-1.33.12/newrole/newrole.c	2007-01-14 13:56:41.000000000 -0600
@@ -36,8 +36,14 @@
  * setuid root, so that it can read the shadow passwd file.
  * 
  *
- * Authors:  Tim Fraser , 
- *           Anthony Colatrella <amcolat@epoch.ncsc.mil>
+ * Authors:
+ *      Anthony Colatrella <amcolat@epoch.ncsc.mil>
+ *	Tim Fraser
+ *	Steve Grubb <sgrubb@redhat.com>
+ *	Darrel Goeddel <DGoeddel@trustedcs.com>
+ *	Michael Thompson <mcthomps@us.ibm.com>
+ *	Dan Walsh <dwalsh@redhat.com>
+ *
  * Various bug fixes by Stephen Smalley <sds@epoch.ncsc.mil>
  *
  *************************************************************************/

--------------060205070503060405050509--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
