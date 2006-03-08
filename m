Message-ID: <440F6745.2060309@cornell.edu>
Date: Wed, 08 Mar 2006 18:22:45 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Abort early on merge() errors
Content-Type: multipart/mixed;
 boundary="------------060502030702020802060903"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060502030702020802060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a harmless bug where errors in sorting and clearing 
obsolete booleans would abort late, and also not print an error message 
as appropriate. The original intention was immediate abort.

======

Passes tests, I wanted to run it through valgrind, but that never seems 
to work anymore - valgrind spirals out of control, and eats 70% of my 
memory whenever I run it. It also still floods the screen with 
strcpy_chk python warnings, and dlopen ones (translation related). One 
of these days I'll investigate what those warnings are all about:

--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18
--19922-- DWARF2 CFI reader: unhandled CFI instruction 0:18

==20645== Conditional jump or move depends on uninitialised value(s)
==20645==    at 0x509FFDC: __strcpy_chk (in /lib64/libc-2.4.so)
==20645==    by 0x3883EA8DC5: (within /usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883EAB6F7: (within /usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883EABBAB: (within /usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883EABDB6: PyImport_ImportModuleEx (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E8CA62: (within /usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E364FF: PyObject_Call (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E8FA00: PyEval_CallObjectWithKeywords (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E91713: PyEval_EvalFrame (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E95DD4: PyEval_EvalCodeEx (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883E95E21: PyEval_EvalCode (in 
/usr/lib64/libpython2.4.so.1.0)
==20645==    by 0x3883EAA239: PyImport_ExecCodeModuleEx (in 
/usr/lib64/libpython2.4.so.1.0)

==19922== Conditional jump or move depends on uninitialised value(s)
==19922==    at 0x4009F1B: _dl_relocate_object (in /lib64/ld-2.4.so)
==19922==    by 0x4003782: dl_main (in /lib64/ld-2.4.so)
==19922==    by 0x4012A3A: _dl_sysdep_start (in /lib64/ld-2.4.so)
==19922==    by 0x4001384: _dl_start (in /lib64/ld-2.4.so)
==19922==    by 0x4000A77: (within /lib64/ld-2.4.so)

==19922== Conditional jump or move depends on uninitialised value(s)
==19922==    at 0x400A1A6: _dl_relocate_object (in /lib64/ld-2.4.so)
==19922==    by 0x401078D: dl_open_worker (in /lib64/ld-2.4.so)
==19922==    by 0x400C875: _dl_catch_error (in /lib64/ld-2.4.so)
==19922==    by 0x400FFBB: _dl_open (in /lib64/ld-2.4.so)
==19922==    by 0x4FEB1A9: dlopen_doit (in /lib64/libdl-2.4.so)
==19922==    by 0x400C875: _dl_catch_error (in /lib64/ld-2.4.so)
==19922==    by 0x4FEB71C: _dlerror_run (in /lib64/libdl-2.4.so)
==19922==    by 0x4FEB120: dlopen@@GLIBC_2.2.5 (in /lib64/libdl-2.4.so)
==19922==    by 0x388050D0A7: init_translations (in /lib64/libselinux.so.1)
==19922==    by 0x388050D1B8: init_lib (in /lib64/libselinux.so.1)
==19922==    by 0x38805122F1: (within /lib64/libselinux.so.1)
==19922==    by 0x3880503B22: (within /lib64/libselinux.so.1)


--------------060502030702020802060903
Content-Type: text/x-patch;
 name="libsemanage.merge_abort_early.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.merge_abort_early.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2006-02-16 13:49:35.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2006-03-08 17:34:53.000000000 -0500
@@ -194,6 +194,10 @@ int semanage_base_merge_components(
 		for (j = 0; j < nrecords; j++)
 			rtable->free(records[j]);
 		free(records);
+
+		/* Abort on error */
+		if (rc < 0)
+			goto err;
 	}	
 
 	return rc;

--------------060502030702020802060903--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
