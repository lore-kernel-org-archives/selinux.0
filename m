Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8Q19OAg009700
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 21:09:24 -0400
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8Q19OWa019010
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 01:09:24 GMT
Received: by el-out-1112.google.com with SMTP id j27so165718elf.21
        for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2008 18:09:23 -0700 (PDT)
Message-ID: <48DC363B.4020304@gmail.com>
Date: Thu, 25 Sep 2008 21:09:15 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][autotools] libselinux/load_policy.o compile error
References: <48BF58E7.4030806@gmail.com> <48BFFFC6.6090100@manicmethod.com> <48C011FD.8080603@gmail.com> <48C02447.9030507@manicmethod.com> <48CED064.8000002@manicmethod.com>
In-Reply-To: <48CED064.8000002@manicmethod.com>
Content-Type: multipart/mixed;
 boundary="------------020506060101050605000707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020506060101050605000707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Joshua Brindle wrote:
> Joshua Brindle wrote:
>   
>> Vikram Noel Ambrose wrote:
>>     
>>> Joshua Brindle wrote:
>>>       
>>>> Vikram Noel Ambrose wrote:
>>>>  
>>>>         
>>>>> Here's the fix to that libselinux ld error you were getting.
>>>>>
>>>>>     
>>>>>           
>>>> Ok, applied and built fine. One interesting thing is that even without
>>>> building the swig wrappers (--disable-swig) it still installs
>>>> lib/python2.5/site-packages/selinux, which obviously wouldn't work
>>>> without the accompanying .so file.
>>>>
>>>>   
>>>>         
>>> I'll have a look at that, thanks.
>>>
>>>       
>>>> Also, it looks like any library that installs to /lib will also put
>>>> their python stuff in /lib/python2.5. I don't know if python even
>>>> knows to look there, and even if it does there is really no reason to
>>>> put them there. libselinux.so and libsepol.so will need to go to /lib
>>>> but the python stuff should go to /usr/lib and I don't see a different
>>>> argument for the python stuff (only --libdir).
>>>>
>>>>
>>>>   
>>>>         
>>> Here you are referring to libpy*.so? if so then, Yes, python does know
>>> to look for it in its site-packages/$pkg/ folder.
>>>
>>>       
>> I know that, I mean no python .so files or .py files are put in /lib/python2.5, they are all put in /usr/lib/python2.5. However, since libselinux.so and libsepol.so (the real libs) have to be in /lib/ there is no way to tell configure to split those up (since they both use libdir)
>>
>>     
>
> Ping?
>
>   
Sorry for the radio silence, been tied up of late.

I *think* I understand the problem,

Using the attached patch, python site packages folder resolution
is done as follows:

1. Try get python-site folder by asking "python"
--- This only really works if HOST machine = BUILD machine, and
    if the host's python was not relocated at installation.

2. User supplies --with-python-site=/some/where/python2.4/site-packages

So either way, the site-packages folder can be specified.


This patch also:

1. Stops the swig interface from being rebuilt when python
headers are not found, even if swig is found. This is done
because the interface is not going to be built without the
headers, so no point on rebuilding it's source.

2. Prevents selinux/__init__.py from being installed, if the
libpyselinux.so wrapper cannot be built. Done because the python
module is useless without the wrapper.

3. A little bit of white space clean up and formatting.


If i've understood the problem correctly, then i'll patch the
others (libsemanage etc..)

thanks josh,


Vikram




--------------020506060101050605000707
Content-Type: text/plain;
 name="better-handle-python-site-folder.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="better-handle-python-site-folder.patch"

diff --git a/libselinux/configure.ac b/libselinux/configure.ac
index 5d97078..a437404 100644
--- a/libselinux/configure.ac
+++ b/libselinux/configure.ac
@@ -92,15 +92,18 @@ AM_CONDITIONAL([enable_avc], [ test "$_enable_avc" = yes])
 AM_CONDITIONAL([enable_bool], [ test "$_enable_bool" = yes])
 AM_CONDITIONAL([enable_docs], [ test "$_enable_docs" = yes])
 
-AC_ARG_WITH([pythonver],
-	[AC_HELP_STRING([--with-pythonver=x],[Python version (eg 2.4) ])],
-        [],
-        [with_pythonver=$PYTHON_VERSION]
+AC_ARG_WITH([python-site],
+	[AC_HELP_STRING([--with-python-site=PATH],
+			[Optional path to python site-packages folder,
+			eg /usr/lib/python2.4/site-packages])],
+	[]
 )
 
-if test -n "$with_pythonver" ; then
-        AC_SUBST([pythondir],[$libdir/python$with_pythonver/site-packages])
-        AC_SUBST([pyexecdir],[$libdir/python$with_pythonver/site-packages])
+if test -n "$with_python_site" ; then
+	AC_SUBST([pythondir],[$with_python_site])
+	AC_SUBST([pyexecdir],[$with_python_site])
+else
+	AC_MSG_WARN([Python site folder not specified, guessing...])
 fi
 
 AC_ARG_WITH([python],
@@ -138,7 +141,7 @@ AC_ARG_WITH([static-libsepol],
         else
                 AC_MSG_RESULT([no found])
                 AC_MSG_WARN([[Cannot build libpyaudit2why.so python wrappper. 
-			Try --with-static-libsepol=PATH]])
+		Try --with-static-libsepol=PATH]])
 
         fi],
         [AC_MSG_CHECKING([for libsepol.a in $prefix/lib])]
@@ -148,7 +151,7 @@ AC_ARG_WITH([static-libsepol],
         else
                 AC_MSG_RESULT([not found])
                 AC_MSG_WARN([[Cannot build libpyaudit2why.so python wrappper. 
-			Try --with-static-libsepol=PATH]])
+		Try --with-static-libsepol=PATH]])
         fi]
 )
 
@@ -177,6 +180,14 @@ if test "$_enable_swig" = "yes" -a -z "$SWIG" ; then
 		or install swig])
 fi
 
+# If libpy*.so wrapper cannot be built, then do not rebuild swig interface
+# even if swig is available, and do not install selinux/__init__.py
+if test "$have_python" != "yes" ; then
+	_enable_swig=no
+	AC_MSG_NOTICE([Swig interface does not need to be regenerated 
+		because libpyselinux.so wrapper cannot be built])
+fi
+
 # slip in fake swig if needed
 if test "$_enable_swig" != "yes" ; then
 	AC_SUBST([SWIG],[/bin/true])
@@ -201,10 +212,12 @@ $PRINT "\n*** Libselinux Configuration summary ***\n"
 if test "$have_python" != yes ; then
  $PRINT "\taudit2why\t\t= no "
  $PRINT "(try --with-python=/usr/include/python$PYTHON_VERSION) \n"
- $PRINT "\tlibpyselinux.so\t\t= no\n"
+ $PRINT "\tlibpyselinux.so\t\t= no "
+ $PRINT "(try --with-python=/usr/include/python$PYTHON_VERSION) \n"
 else
  $PRINT "\taudit2why\t\t= yes (Using python headers $with_python) \n"
  $PRINT "\tlibpyselinux.so\t\t= yes\n"
+ $PRINT "\tPython site folder\t= $pythondir\n"
 fi
 
 if test -n "$LIBSEPOL_A_PATH" ; then
@@ -221,5 +234,4 @@ $PRINT "\tSELinux utlities\t= yes\n"
 $PRINT "\tInstall Man pages\t= $_enable_docs\n"
 $PRINT "\tSELinux Type\t\t= $with_policyname\n"
 $PRINT "\tRegenerate py wrapper\t= $_enable_swig\n"
-$PRINT "\tPython Packages folder\t= $pythondir\n"
 $PRINT "------------------------------------------------------------\n" 
diff --git a/libselinux/src/Makefile.am b/libselinux/src/Makefile.am
index fd22726..a32f4a9 100644
--- a/libselinux/src/Makefile.am
+++ b/libselinux/src/Makefile.am
@@ -30,7 +30,7 @@ lib_LTLIBRARIES			= libselinux.la
 selinux_pyexecdir		= $(pyexecdir)/selinux
 selinux_pythondir		= $(pythondir)/selinux
 selinux_pyexec_LTLIBRARIES	= $(extra_lib)
-selinux_python_PYTHON		= __init__.py
+selinux_python_PYTHON		= $(extra_py) 
 
 sysconf_DATA			= config
 config:Makefile
@@ -38,12 +38,14 @@ config:Makefile
 		
 PACKAGE				= selinux
 extra_lib			=
+extra_py			=
 libselinux_la_SOURCES		= $(BUILDSRC)
 libselinux_la_LDFLAGS		= -Wl,--as-needed -version-info 1
 if enable_python
 selinuxswig_wrap.c: Makefile selinuxswig.i selinuxswig_python.i
 	$(SWIG) -o $@ $(SWIG_FLAGS) -interface libpyselinux $(srcdir)/selinuxswig_python.i 
 extra_lib			+= libpyselinux.la
+extra_py			+= __init__.py
 libpyselinux_la_SOURCES		= selinuxswig_wrap.c
 libpyselinux_la_CPPFLAGS	= \
 	-I@PYTHON_INCLUDE_DIR@

--------------020506060101050605000707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
