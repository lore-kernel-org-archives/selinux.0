Subject: Re: 'make policy' issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Laganowski <eric@laganowski.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4ADF2663.2030105@laganowski.net>
References: <4ADF2358.4050606@laganowski.net>
	 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
	 <4ADF2663.2030105@laganowski.net>
Content-Type: multipart/mixed; boundary="=-Sv+KgO/keU1tM5rSG4U1"
Date: Wed, 21 Oct 2009 11:29:10 -0400
Message-Id: <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Sv+KgO/keU1tM5rSG4U1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2009-10-21 at 11:18 -0400, Eric Laganowski wrote:
> Stephen Smalley wrote:
> > On Wed, 2009-10-21 at 11:06 -0400, Eric Laganowski wrote:
> >   
> >> Hello,
> >>
> >>  I was trying to build selinux userspace tools on my custom linux build. 
> >> Everything went fine until I attempted to compile reference policy.
> >> Could you please help me in understanding what went wrong here.
> >>
> >> refpolicy-2.20090730
> >>
> >> $ make policy
> >> Compiling refpolicy policy.24
> >> /usr/bin/checkpolicy policy.conf -o policy.24
> >> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> >> policy/modules/kernel/corenetwork.te":1715:ERROR 'syntax error' at token ':' on line 9122:
> >> allow corenet_unconfined_type node_type:node *;
> >>
> >> checkpolicy:  error(s) encountered while parsing configuration
> >> make: *** [policy.24] Error 1
> >>
> >>
> >> Packages:
> >>
> >> checkpolicy-2.0.19
> >> libselinux-2.0.85
> >> libsemanage-2.0.33
> >> libsepol-2.0.37
> >> policycoreutils-2.0.69
> >> sepolgen-1.0.17
> >>
> >> $ yacc -V
> >> yacc - 1.9 20090221
> >> $ flex -V
> >> flex 2.5.35
> >>     
> >
> > Sounds similar to:
> > http://marc.info/?l=selinux&m=117076095205821&w=2
> >
> > which was an upstream flex problem.  However, I also see that you are using yacc rather than bison?
> > Default for building checkpolicy is bison -y, which could be relevant.
> >   
> Re bison/yacc: I tried both, byacc and 'bison -y'
> Re flex: What is the requirement for flex from selinux perspective? Is 
> it known what build of flex is "known good"?

My impression is that one of the patches carried by the distributions
for flex is needed for checkpolicy to work, but no one has ever fully
investigated the precise dependency - people just grab the Fedora srpm
and apply those patches to flex, and then rebuild checkpolicy and it
works.  I haven't seen any complaints from Debian or Gentoo so I presume
that they also carry the same patches for flex.

flex -V here also shows 2.5.35.  But there are three patches in the
Fedora package.  Attached.

-- 
Stephen Smalley
National Security Agency

--=-Sv+KgO/keU1tM5rSG4U1
Content-Disposition: attachment; filename="flex-2.5.35-gcc44.patch"
Content-Type: text/x-patch; name="flex-2.5.35-gcc44.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -urNp flex-2.5.35.orig/flex.skl flex-2.5.35/flex.skl
--- flex-2.5.35.orig/flex.skl	2009-04-20 03:09:46.000000000 +0530
+++ flex-2.5.35/flex.skl	2009-04-20 07:46:58.000000000 +0530
@@ -217,6 +217,7 @@ m4preproc_include(`flexint.h')
 /* begin standard C++ headers. */
 #include <iostream> 
 #include <errno.h>
+#include <cstdio>
 #include <cstdlib>
 #include <cstring>
 /* end standard C++ headers. */
diff -urNp flex-2.5.35.orig/skel.c flex-2.5.35/skel.c
--- flex-2.5.35.orig/skel.c	2009-04-20 03:09:46.000000000 +0530
+++ flex-2.5.35/skel.c	2009-04-20 07:46:40.000000000 +0530
@@ -284,6 +284,7 @@ const char *skel[] = {
   "/* begin standard C++ headers. */",
   "#include <iostream> ",
   "#include <errno.h>",
+  "#include <cstdio>",
   "#include <cstdlib>",
   "#include <cstring>",
   "/* end standard C++ headers. */",

--=-Sv+KgO/keU1tM5rSG4U1
Content-Disposition: attachment; filename="flex-2.5.35-hardening.patch"
Content-Type: text/x-patch; name="flex-2.5.35-hardening.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -u flex-2.5.35/scan.c flex-2.5.35/scan.c
--- flex-2.5.35/scan.c
+++ flex-2.5.35/scan.c
@@ -2096,7 +2096,7 @@
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO fwrite( yytext, yyleng, 1, yyout )
+#define ECHO do { if (fwrite( yytext, yyleng, 1, yyout )) {} } while (0)
 #endif
 
 /* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
diff -u flex-2.5.35/flex.skl flex-2.5.35/flex.skl
--- flex-2.5.35/flex.skl
+++ flex-2.5.35/flex.skl
@@ -1075,7 +1075,7 @@
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO fwrite( yytext, yyleng, 1, yyout )
+#define ECHO do { if (fwrite( yytext, yyleng, 1, yyout )) {} } while (0)
 %endif
 %if-c++-only C++ definition
 #define ECHO LexerOutput( yytext, yyleng )
diff -u flex-2.5.35/skel.c flex-2.5.35/skel.c
--- flex-2.5.35/skel.c
+++ flex-2.5.35/skel.c
@@ -1142,7 +1142,7 @@
   "/* This used to be an fputs(), but since the string might contain NUL's,",
   " * we now use fwrite().",
   " */",
-  "#define ECHO fwrite( yytext, yyleng, 1, yyout )",
+  "#define ECHO do { if (fwrite( yytext, yyleng, 1, yyout )) {} } while (0)",
   "%endif",
   "%if-c++-only C++ definition",
   "#define ECHO LexerOutput( yytext, yyleng )",

--=-Sv+KgO/keU1tM5rSG4U1
Content-Disposition: attachment; filename="flex-2.5.35-sign.patch"
Content-Type: text/x-patch; name="flex-2.5.35-sign.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- flex-2.5.35/gen.c-orig	2008-04-30 22:51:08.000000000 +0200
+++ flex-2.5.35/gen.c	2008-04-30 22:51:14.000000000 +0200
@@ -1890,7 +1890,7 @@
 			outn ("\tif ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \\");
 			outn ("\t\t{ \\");
 			outn ("\t\tint c = '*'; \\");
-			outn ("\t\tint n; \\");
+			outn ("\t\tunsigned n; \\");
 			outn ("\t\tfor ( n = 0; n < max_size && \\");
 			outn ("\t\t\t     (c = getc( yyin )) != EOF && c != '\\n'; ++n ) \\");
 			outn ("\t\t\tbuf[n] = (char) c; \\");

--=-Sv+KgO/keU1tM5rSG4U1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
