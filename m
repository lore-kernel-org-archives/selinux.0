Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m32KeiHb011288
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2008 16:40:44 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m32KeTHr023545
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2008 20:40:31 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
Cc: 472590@bugs.debian.org
Subject: RFC: changing the "+" in ls -l output to be "." or "+"
In-Reply-To: <877ifj9sgs.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 31 Mar 2008 11:02:27 +0200")
References: <200803251523.34329.russell@coker.com.au>
	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
	<200803260824.17731.russell@coker.com.au>
	<877ifj9sgs.fsf@rho.meyering.net>
Date: Wed, 02 Apr 2008 22:33:49 +0200
Message-ID: <87prt8uhci.fsf_-_@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I wrote this:
> [ I'm Cc'ing bug-coreutils@gnu.org.
>   FYI, this is a continuation of discussion from the SELinux list:
>   http://marc.info/?t=120645074000003&r=1&w=2
>   and the debian bug tracking system: http://bugs.debian.org/472590
>
>   The problem is that on an SELinux-enabled system, 'ls -l's "+",
>   the "alternate access method" indicator, is useless, because it
>   appears on every file:
>
>       $ ls -glo /var
>       total 164
>       drwxr-xr-x+  3 4096 2008-03-29 08:43 kerberos
>       drwxr-xr-x+ 39 4096 2008-03-29 08:43 lib
>       drwxr-xr-x+  2 4096 2008-03-27 17:33 local
>       drwxrwxr-x+  8 4096 2008-03-31 04:15 lock
>       drwxr-xr-x+ 20 4096 2008-03-31 09:55 log
>       lrwxrwxrwx+  1   10 2008-03-28 23:33 mail -> spool/mail
>       ...
>
>   Newer POSIX allows any non-space character as the indicator, and
>   that's what we're discussing now.
>   ]
>
> Russell Coker <russell@coker.com.au> wrote:
>> On Wednesday 26 March 2008 04:31, Michael Stone <mstone@debian.org> wrote:
>>> if (acl) then '+'
>>> else if (selinux) then '.'
>>
>> Should there be some special marking of files with both a SE Linux context and
>> an ACL?
>>
>> Pity that they didn't choose an "a" to mark an ACL which would then permit
>> using "A" for ACL + MAC.
>
> This is probably as good a time as any to make such a change, though
> I doubt it will make the cut for the upcoming release.  I'd like to keep
> it simple (i.e., not try to encode all possible combinations).  If you
> want to get full details, stat(1) is probably the program to change.
>
> I like Michael's suggestion.  Rephrasing it,
>
>     if (SELinux, with no other MAC or ACL)
>       use '.'
>     else if (any other combination of alternate access methods)
>       use '+'
>
> If someone who already has a copyright assignment on file for coreutils
> wants to write the patch (including doc update, tests, NEWS, ChangeLog,
> etc.), please speak up ASAP.  Otherwise I'll do it.

No one spoke up, so here's code, for discussion's sake.
I've tested it only lightly.
This change is not slated for the upcoming release.

Here's sample output, running on an SELinux system:

  $ src/ls -ldgo [ac]*
  -rw-r--r--.  1   42625 2008-04-02 19:31 aclocal.m4
  drwxr-xr-x.  2    4096 2008-04-02 19:31 autom4te.cache
  -rw-r--r--.  1    1597 2008-03-21 16:35 cfg.mk
  -rw-r--r--.  1 1417195 2008-04-02 19:33 config.log
  -rwxr-xr-x.  1   71225 2008-04-02 19:33 config.status
  -rwxr-xr-x.  1 1846424 2008-04-02 19:31 configure
  -rw-r--r--.  1   12014 2008-03-25 23:55 configure.ac

------------------------------------

	Use '.' (not +) as SELinux-only alternate access flag in ls -l output
	* src/ls.c (gobble_file) [long_format]: Map SELinux-only to '.',
	any other nonempty combination of MAC and ACL to '+', and all else
	to the usual ' '.
	* tests/misc/selinux: Adapt: expect '.', not '+'.
	* NEWS: TBD

---
 src/ls.c           |   25 +++++++++++++++++++------
 tests/misc/selinux |    4 ++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/src/ls.c b/src/ls.c
index e029fe0..ae234da 100644
--- a/src/ls.c
+++ b/src/ls.c
@@ -151,6 +151,12 @@ verify (sizeof filetype_letter - 1 == arg_directory + 1);
     C_LINK, C_SOCK, C_FILE, C_DIR			\
   }

+enum acl_type
+  {
+    ACL_T_NONE,
+    ACL_T_SELINUX_ONLY,
+    ACL_T_YES
+  };

 struct fileinfo
   {
@@ -179,7 +185,7 @@ struct fileinfo

     /* For long listings, true if the file has an access control list,
        or an SELinux security context.  */
-    bool have_acl;
+    enum acl_type acl_type;
   };

 #define LEN_STR_PAIR(s) sizeof (s) - 1, s
@@ -2671,6 +2677,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,

       if (format == long_format || print_scontext)
 	{
+	  bool have_selinux = false;
 	  bool have_acl = false;
 	  int attr_len = (do_deref
 			  ?  getfilecon (absolute_name, &f->scontext)
@@ -2689,7 +2696,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
 	    }

 	  if (err == 0)
-	    have_acl = ! STREQ ("unlabeled", f->scontext);
+	    have_selinux = ! STREQ ("unlabeled", f->scontext);
 	  else
 	    {
 	      f->scontext = UNKNOWN_SECURITY_CONTEXT;
@@ -2702,15 +2709,19 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
 		err = 0;
 	    }

-	  if (err == 0 && ! have_acl && format == long_format)
+	  if (err == 0 && format == long_format)
 	    {
 	      int n = file_has_acl (absolute_name, &f->stat);
 	      err = (n < 0);
 	      have_acl = (0 < n);
 	    }

-	  f->have_acl = have_acl;
-	  any_has_acl |= have_acl;
+	  f->acl_type = (!have_selinux && !have_acl
+			 ? ACL_T_NONE
+			 : (have_selinux && !have_acl
+			    ? ACL_T_SELINUX_ONLY
+			    : ACL_T_YES));
+	  any_has_acl |= f->acl_type != ACL_T_NONE;

 	  if (err)
 	    error (0, errno, "%s", quotearg_colon (absolute_name));
@@ -3430,7 +3441,9 @@ print_long_format (const struct fileinfo *f)
     }
   if (! any_has_acl)
     modebuf[10] = '\0';
-  else if (f->have_acl)
+  else if (f->acl_type == ACL_T_SELINUX_ONLY)
+    modebuf[10] = '.';
+  else if (f->acl_type == ACL_T_YES)
     modebuf[10] = '+';

   switch (time_type)
diff --git a/tests/misc/selinux b/tests/misc/selinux
index 87d1a8d..ea95112 100755
--- a/tests/misc/selinux
+++ b/tests/misc/selinux
@@ -34,8 +34,8 @@ for i in d f p; do
   c=`stat --printf %C $i`; test x$c = x$ctx || fail=1
 done

-# ensure that ls -l output includes the "+".
-c=`ls -l f|cut -c11`; test "$c" = + || fail=1
+# ensure that ls -l output includes the ".".
+c=`ls -l f|cut -c11`; test "$c" = . || fail=1

 # Copy each to a new directory and ensure that context is preserved.
 cp -r --preserve=all d f p s1 || fail=1
--
1.5.5.rc2.26.g7bba

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
