Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3RCBsib032513
 for <selinux@tycho.nsa.gov>; Mon, 27 Apr 2015 08:11:54 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH] selinux: Merge Android libselinux changes with upstream
Date: Mon, 27 Apr 2015 13:11:36 +0100
Message-Id: <1430136696-1254-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This RFC patch takes the libselinux changes from AOSP master
and merges them into the SELinux project source from
https://github.com/SELinuxProject/selinux

checkpolicy, libselinux and libsepol have been updated with the
appropriate Android.mk files and licences.

The majority of changes were minor and use ifdef/ifndef, however:
1) label_file.c from Android was renamed label_android_file.c
   as the changes between them were great (Android does not
   currently use the *.bin file_contexts file)
   There is a request to add this support to Android (see
   https://bitbucket.org/seandroid/wiki/wiki/ToDo), but left it
   until later (just in case this patch does not fly at all).

2) procattr.c has been modified to support both but looks messy.

3) Not all Android changes were added as they did not seem necessary,
   for example include/selinux/selinux.h was not modified.

4) libselinux/src/Makefile was modified to build the required modules.

5) The Android.mk file was modified to add src/enabled.c because
   callbacks.c calls is_selinux_enabled.
   Also for non-user TARGET_BUILD_VARIANT add booleans.c because
   external/ltrace/sysdeps/linux-gnu/trace.c requires
   security_get_boolean_active, otherwise booleans could be removed.

These changes have been tested on Fedora 21 and Android master
builds (eng and user) using the emulator with no problems (the
external/checkpolicy, external/libselinux and external/libsepol
projects were removed).
The testing was not extensive and consisted of checking bootloading,
labeling and running apps (Android) and checking the libselinux/sepol
functions on Fedora.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Android.mk                              |    3 +-
 checkpolicy/MODULE_LICENSE_GPL          |    0
 checkpolicy/NOTICE                      |  340 +++++++
 libselinux/Android.mk                   |  108 +++
 libselinux/MODULE_LICENSE_PUBLIC_DOMAIN |    0
 libselinux/NOTICE                       |   21 +
 libselinux/include/selinux/android.h    |   56 ++
 libselinux/include/selinux/label.h      |    9 +
 libselinux/src/Makefile                 |   57 +-
 libselinux/src/android.c                | 1531 +++++++++++++++++++++++++++++++
 libselinux/src/avc.c                    |   59 ++
 libselinux/src/avc_internal.h           |    4 +
 libselinux/src/booleans.c               |   31 +-
 libselinux/src/canonicalize_context.c   |    8 +-
 libselinux/src/checkAccess.c            |    2 +
 libselinux/src/check_context.c          |    7 +-
 libselinux/src/compute_av.c             |   11 +-
 libselinux/src/compute_create.c         |   19 +-
 libselinux/src/fgetfilecon.c            |    7 +-
 libselinux/src/fsetfilecon.c            |    8 +
 libselinux/src/get_initial_context.c    |    7 +-
 libselinux/src/getfilecon.c             |    7 +-
 libselinux/src/getpeercon.c             |    7 +-
 libselinux/src/init.c                   |   11 +-
 libselinux/src/label.c                  |   81 +-
 libselinux/src/label_android_file.c     |  776 ++++++++++++++++
 libselinux/src/label_internal.h         |   12 +-
 libselinux/src/lgetfilecon.c            |    7 +-
 libselinux/src/load_policy.c            |    4 +
 libselinux/src/lsetfilecon.c            |    8 +
 libselinux/src/policy.h                 |    4 +-
 libselinux/src/procattr.c               |   70 +-
 libselinux/src/selinux_internal.h       |    2 +
 libselinux/src/setfilecon.c             |    8 +
 libselinux/src/stringrep.c              |    2 +
 libsepol/MODULE_LICENSE_LGPL            |    0
 libsepol/NOTICE                         |  504 ++++++++++
 37 files changed, 3764 insertions(+), 27 deletions(-)
 create mode 100644 checkpolicy/MODULE_LICENSE_GPL
 create mode 100644 checkpolicy/NOTICE
 create mode 100644 libselinux/Android.mk
 create mode 100644 libselinux/MODULE_LICENSE_PUBLIC_DOMAIN
 create mode 100644 libselinux/NOTICE
 create mode 100644 libselinux/include/selinux/android.h
 create mode 100644 libselinux/src/android.c
 create mode 100644 libselinux/src/label_android_file.c
 create mode 100644 libsepol/MODULE_LICENSE_LGPL
 create mode 100644 libsepol/NOTICE

diff --git a/Android.mk b/Android.mk
index 02f35a9..5053e7d 100644
--- a/Android.mk
+++ b/Android.mk
@@ -1,2 +1 @@
-# This empty Android.mk file will prevent the build system
-# from building anything below this point.
+include $(call all-subdir-makefiles)
diff --git a/checkpolicy/MODULE_LICENSE_GPL b/checkpolicy/MODULE_LICENSE_GPL
new file mode 100644
index 0000000..e69de29
diff --git a/checkpolicy/NOTICE b/checkpolicy/NOTICE
new file mode 100644
index 0000000..5b6e7c6
--- /dev/null
+++ b/checkpolicy/NOTICE
@@ -0,0 +1,340 @@
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/libselinux/Android.mk b/libselinux/Android.mk
new file mode 100644
index 0000000..f47b4f2
--- /dev/null
+++ b/libselinux/Android.mk
@@ -0,0 +1,108 @@
+LOCAL_PATH:= $(call my-dir)
+
+# If debug then external/ltrace/sysdeps/linux-gnu/trace.c requires
+# security_get_boolean_active, otherwise booleans could be removed.
+ifneq ($(TARGET_BUILD_VARIANT),user)
+	ADD_SEBOOLEANS := src/booleans.c
+endif
+
+common_SRC_FILES := \
+	src/canonicalize_context.c \
+	src/disable.c \
+	src/enabled.c \
+	src/fgetfilecon.c \
+	src/fsetfilecon.c \
+	src/getenforce.c \
+	src/getfilecon.c \
+	src/getpeercon.c \
+	src/lgetfilecon.c \
+	src/load_policy.c \
+	src/lsetfilecon.c \
+	src/policyvers.c \
+	src/procattr.c \
+	src/setenforce.c \
+	src/setfilecon.c \
+	src/context.c \
+	src/mapping.c \
+	src/stringrep.c \
+	src/compute_create.c \
+	src/compute_av.c \
+	src/avc.c \
+	src/avc_internal.c \
+	src/avc_sidtab.c \
+	src/get_initial_context.c \
+	src/checkAccess.c \
+	src/sestatus.c \
+	src/deny_unknown.c
+
+common_HOST_FILES := \
+	src/callbacks.c \
+	src/check_context.c \
+	src/freecon.c \
+	src/init.c \
+	src/label.c \
+	src/label_android_file.c \
+	src/label_android_property.c
+
+common_COPY_HEADERS_TO := selinux
+common_COPY_HEADERS := include/selinux/selinux.h include/selinux/label.h include/selinux/context.h include/selinux/avc.h include/selinux/android.h 
+
+include $(CLEAR_VARS)
+LOCAL_SRC_FILES := $(common_SRC_FILES) $(common_HOST_FILES) src/android.c $(ADD_SEBOOLEANS)
+LOCAL_MODULE:= libselinux
+LOCAL_MODULE_TAGS := eng
+LOCAL_STATIC_LIBRARIES := libmincrypt
+LOCAL_C_INCLUDES := external/pcre
+LOCAL_WHOLE_STATIC_LIBRARIES := libpcre
+# 1003 corresponds to auditd, from system/core/logd/event.logtags
+LOCAL_CFLAGS := -DAUDITD_LOG_TAG=1003
+# mapping.c has redundant check of array p_in->perms.
+LOCAL_CLANG_CFLAGS += -Wno-pointer-bool-conversion
+
+include $(BUILD_STATIC_LIBRARY)
+
+include $(CLEAR_VARS)
+LOCAL_CFLAGS := -DHOST
+
+ifeq ($(HOST_OS),darwin)
+LOCAL_CFLAGS += -DDARWIN
+endif
+
+LOCAL_SRC_FILES := $(common_HOST_FILES) src/enabled.c
+LOCAL_MODULE:= libselinux
+LOCAL_MODULE_TAGS := eng
+LOCAL_WHOLE_STATIC_LIBRARIES := libpcre
+LOCAL_C_INCLUDES := external/pcre
+include $(BUILD_HOST_STATIC_LIBRARY)
+
+include $(CLEAR_VARS)
+LOCAL_SRC_FILES := $(common_SRC_FILES) $(common_HOST_FILES) src/android.c $(ADD_SEBOOLEANS)
+LOCAL_MODULE:= libselinux
+LOCAL_MODULE_TAGS := eng
+LOCAL_COPY_HEADERS_TO := $(common_COPY_HEADERS_TO)
+LOCAL_COPY_HEADERS := $(common_COPY_HEADERS)
+LOCAL_STATIC_LIBRARIES := libmincrypt
+LOCAL_C_INCLUDES := external/pcre
+LOCAL_SHARED_LIBRARIES := liblog libpcre
+# 1003 corresponds to auditd, from system/core/logd/event.logtags
+LOCAL_CFLAGS := -DAUDITD_LOG_TAG=1003
+# mapping.c has redundant check of array p_in->perms.
+LOCAL_CLANG_CFLAGS += -Wno-pointer-bool-conversion
+
+include $(BUILD_SHARED_LIBRARY)
+
+include $(CLEAR_VARS)
+LOCAL_CFLAGS := -DHOST
+
+ifeq ($(HOST_OS),darwin)
+LOCAL_CFLAGS += -DDARWIN
+endif
+
+LOCAL_SRC_FILES := $(common_HOST_FILES) src/enabled.c
+LOCAL_MODULE:= libselinux
+LOCAL_MODULE_TAGS := eng
+LOCAL_COPY_HEADERS_TO := $(common_COPY_HEADERS_TO)
+LOCAL_COPY_HEADERS := $(common_COPY_HEADERS)
+LOCAL_WHOLE_STATIC_LIBRARIES := libpcre
+LOCAL_C_INCLUDES := external/pcre
+include $(BUILD_HOST_SHARED_LIBRARY)
diff --git a/libselinux/MODULE_LICENSE_PUBLIC_DOMAIN b/libselinux/MODULE_LICENSE_PUBLIC_DOMAIN
new file mode 100644
index 0000000..e69de29
diff --git a/libselinux/NOTICE b/libselinux/NOTICE
new file mode 100644
index 0000000..d386268
--- /dev/null
+++ b/libselinux/NOTICE
@@ -0,0 +1,21 @@
+This library (libselinux) is public domain software, i.e. not copyrighted.
+
+Warranty Exclusion
+------------------
+You agree that this software is a
+non-commercially developed program that may contain "bugs" (as that
+term is used in the industry) and that it may not function as intended.
+The software is licensed "as is". NSA makes no, and hereby expressly
+disclaims all, warranties, express, implied, statutory, or otherwise
+with respect to the software, including noninfringement and the implied
+warranties of merchantability and fitness for a particular purpose.
+
+Limitation of Liability
+-----------------------
+In no event will NSA be liable for any damages, including loss of data,
+lost profits, cost of cover, or other special, incidental,
+consequential, direct or indirect damages arising from the software or
+the use thereof, however caused and on any theory of liability. This
+limitation will apply even if NSA has been advised of the possibility
+of such damage. You acknowledge that this is a reasonable allocation of
+risk.
diff --git a/libselinux/include/selinux/android.h b/libselinux/include/selinux/android.h
new file mode 100644
index 0000000..b2f1ae8
--- /dev/null
+++ b/libselinux/include/selinux/android.h
@@ -0,0 +1,56 @@
+#ifndef _SELINUX_ANDROID_H_
+#define _SELINUX_ANDROID_H_
+
+#include <stdbool.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <selinux/label.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+extern struct selabel_handle* selinux_android_file_context_handle(void);
+
+extern struct selabel_handle* selinux_android_prop_context_handle(void);
+
+extern struct selabel_handle* selinux_android_service_context_handle(void);
+
+extern void selinux_android_set_sehandle(const struct selabel_handle *hndl);
+
+extern int selinux_android_load_policy(void);
+
+extern int selinux_android_reload_policy(void);
+
+extern int selinux_android_setcontext(uid_t uid,
+				      bool isSystemServer,
+				      const char *seinfo,
+				      const char *name);
+
+extern int selinux_android_setfilecon(const char *pkgdir,
+				       const char *pkgname,
+				       const char *seinfo,
+				       uid_t uid);
+
+extern int selinux_log_callback(int type, const char *fmt, ...)
+    __attribute__ ((format(printf, 2, 3)));
+
+#define SELINUX_ANDROID_RESTORECON_NOCHANGE 1
+#define SELINUX_ANDROID_RESTORECON_VERBOSE  2
+#define SELINUX_ANDROID_RESTORECON_RECURSE  4
+#define SELINUX_ANDROID_RESTORECON_FORCE    8
+#define SELINUX_ANDROID_RESTORECON_DATADATA 16
+extern int selinux_android_restorecon(const char *file, unsigned int flags);
+
+extern int selinux_android_restorecon_pkgdir(const char *pkgdir,
+                                             const char *seinfo,
+                                             uid_t uid,
+                                             unsigned int flags);
+
+extern int selinux_android_seapp_context_reload(void);
+
+#ifdef __cplusplus
+}
+#endif
+#endif
diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 672a7c2..cb3239c 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -8,6 +8,9 @@
 
 #include <sys/types.h>
 #include <selinux/selinux.h>
+#ifdef ANDROID
+#include <stdbool.h>
+#endif
 
 #ifdef __cplusplus
 extern "C" {
@@ -96,6 +99,12 @@ int selabel_lookup(struct selabel_handle *handle, char **con,
 		   const char *key, int type);
 int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 		       const char *key, int type);
+#ifdef ANDROID
+bool selabel_partial_match(struct selabel_handle *handle, const char *key);
+
+int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
+			      const char *key, const char **aliases, int type);
+#endif
 
 /**
  * selabel_stats - log labeling operation statistics.
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac25c1f..f879aae 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -46,8 +46,63 @@ ifeq ($(DISABLE_BOOL),y)
 	UNUSED_SRCS+=booleans.c
 endif
 
+SRC_FILES := \
+	audit2why.c \
+	avc.c \
+	avc_internal.c \
+	avc_sidtab.c \
+	booleans.c \
+	callbacks.c \
+	canonicalize_context.c \
+	checkAccess.c \
+	check_context.c \
+	compute_av.c \
+	compute_create.c \
+	compute_member.c \
+	compute_relabel.c \
+	compute_user.c \
+	context.c \
+	deny_unknown.c \
+	disable.c \
+	enabled.c \
+	fgetfilecon.c \
+	freeconary.c \
+	freecon.c \
+	fsetfilecon.c \
+	get_context_list.c \
+	get_default_type.c \
+	getenforce.c \
+	getfilecon.c \
+	get_initial_context.c \
+	getpeercon.c \
+	init.c \
+	is_customizable_type.c \
+	label.c \
+	label_db.c \
+	label_file.c \
+	label_media.c \
+	label_x.c \
+	lgetfilecon.c \
+	load_policy.c \
+	lsetfilecon.c \
+	mapping.c \
+	matchmediacon.c \
+	matchpathcon.c \
+	policyvers.c \
+	procattr.c \
+	query_user_context.c \
+	selinux_check_securetty_context.c \
+	selinux_config.c \
+	sestatus.c \
+	setenforce.c \
+	setexecfilecon.c \
+	setfilecon.c \
+	setrans_client.c \
+	seusers.c \
+	stringrep.c
+
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
-SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
+SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(SRC_FILES))
 
 MAX_STACK_SIZE=32768
 
diff --git a/libselinux/src/android.c b/libselinux/src/android.c
new file mode 100644
index 0000000..7ea2b05
--- /dev/null
+++ b/libselinux/src/android.c
@@ -0,0 +1,1531 @@
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <errno.h>
+#include <pwd.h>
+#include <grp.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+#include <fcntl.h>
+#include <fts.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include <selinux/android.h>
+#include <selinux/label.h>
+#include <selinux/avc.h>
+#include <mincrypt/sha.h>
+#include <private/android_filesystem_config.h>
+#include <log/log.h>
+#include "policy.h"
+#include "callbacks.h"
+#include "selinux_internal.h"
+#include "label_internal.h"
+#include <fnmatch.h>
+
+/*
+ * XXX Where should this configuration file be located?
+ * Needs to be accessible by zygote and installd when
+ * setting credentials for app processes and setting permissions
+ * on app data directories.
+ */
+static char const * const seapp_contexts_file[] = {
+	"/seapp_contexts",
+	"/data/security/current/seapp_contexts",
+	NULL };
+
+static struct selinux_opt seopts[] = {
+	{ SELABEL_OPT_PATH, "/file_contexts" },
+	{ SELABEL_OPT_PATH, "/data/security/current/file_contexts" },
+	{ 0, NULL } };
+
+static const char *const sepolicy_file[] = {
+	"/sepolicy",
+	"/data/security/current/sepolicy",
+	NULL };
+
+static struct selinux_opt seopts_prop[] = {
+        { SELABEL_OPT_PATH, "/property_contexts" },
+        { SELABEL_OPT_PATH, "/data/security/current/property_contexts" },
+        { 0, NULL }
+};
+
+static struct selinux_opt seopts_service[] = {
+    { SELABEL_OPT_PATH, "/service_contexts" },
+    { SELABEL_OPT_PATH, "/data/security/current/service_contexts" },
+    { 0, NULL }
+};
+
+enum levelFrom {
+	LEVELFROM_NONE,
+	LEVELFROM_APP,
+	LEVELFROM_USER,
+	LEVELFROM_ALL
+};
+
+#define POLICY_OVERRIDE_VERSION    "/data/security/current/selinux_version"
+#define POLICY_BASE_VERSION        "/selinux_version"
+static int policy_index = 0;
+
+static void set_policy_index(void)
+{
+	int fd_base = -1, fd_override = -1;
+	struct stat sb_base;
+	struct stat sb_override;
+	void *map_base, *map_override;
+
+	policy_index = 0;
+
+	fd_base = open(POLICY_BASE_VERSION, O_RDONLY | O_NOFOLLOW);
+	if (fd_base < 0)
+		return;
+
+	if (fstat(fd_base, &sb_base) < 0)
+		goto close_base;
+
+	fd_override = open(POLICY_OVERRIDE_VERSION, O_RDONLY | O_NOFOLLOW);
+	if (fd_override < 0)
+		goto close_base;
+
+	if (fstat(fd_override, &sb_override) < 0)
+		goto close_override;
+
+	if (sb_base.st_size != sb_override.st_size)
+		goto close_override;
+
+	map_base = mmap(NULL, sb_base.st_size, PROT_READ, MAP_PRIVATE, fd_base, 0);
+	if (map_base == MAP_FAILED)
+		goto close_override;
+
+	map_override = mmap(NULL, sb_override.st_size, PROT_READ, MAP_PRIVATE, fd_override, 0);
+	if (map_override == MAP_FAILED)
+		goto unmap_base;
+
+	if (memcmp(map_base, map_override, sb_base.st_size) != 0)
+		goto unmap_override;
+
+	if (access(sepolicy_file[1], R_OK) != 0)
+		goto unmap_override;
+
+	if (access(seopts[1].value, R_OK) != 0)
+		goto unmap_override;
+
+	if (access(seopts_prop[1].value, R_OK) != 0)
+		goto unmap_override;
+
+	if (access(seopts_service[1].value, R_OK) != 0)
+		goto unmap_override;
+
+	if (access(seapp_contexts_file[1], R_OK) != 0)
+		goto unmap_override;
+
+	policy_index = 1;
+
+unmap_override:
+	munmap(map_override, sb_override.st_size);
+unmap_base:
+	munmap(map_base, sb_base.st_size);
+close_override:
+	close(fd_override);
+close_base:
+	close(fd_base);
+	return;
+}
+
+#if DEBUG
+static char const * const levelFromName[] = {
+	"none",
+	"app",
+	"user",
+	"all"
+};
+#endif
+
+struct prefix_str {
+	size_t len;
+	char *str;
+	char is_prefix;
+};
+
+static void free_prefix_str(struct prefix_str *p)
+{
+	if (!p)
+		return;
+	free(p->str);
+}
+
+struct seapp_context {
+	/* input selectors */
+	bool isSystemServer;
+	bool isOwnerSet;
+	bool isOwner;
+	struct prefix_str user;
+	char *seinfo;
+	struct prefix_str name;
+	struct prefix_str path;
+	/* outputs */
+	char *domain;
+	char *type;
+	char *level;
+	enum levelFrom levelFrom;
+};
+
+static void free_seapp_context(struct seapp_context *s)
+{
+	if (!s)
+		return;
+
+	free_prefix_str(&s->user);
+	free(s->seinfo);
+	free_prefix_str(&s->name);
+	free_prefix_str(&s->path);
+	free(s->domain);
+	free(s->type);
+	free(s->level);
+}
+
+static bool seapp_contexts_dup = false;
+
+static int seapp_context_cmp(const void *A, const void *B)
+{
+	const struct seapp_context *const *sp1 = (const struct seapp_context *const *) A;
+	const struct seapp_context *const *sp2 = (const struct seapp_context *const *) B;
+	const struct seapp_context *s1 = *sp1, *s2 = *sp2;
+	bool dup;
+
+	/* Give precedence to isSystemServer=true. */
+	if (s1->isSystemServer != s2->isSystemServer)
+		return (s1->isSystemServer ? -1 : 1);
+
+	/* Give precedence to a specified isOwner= over an unspecified isOwner=. */
+	if (s1->isOwnerSet != s2->isOwnerSet)
+		return (s1->isOwnerSet ? -1 : 1);
+
+	/* Give precedence to a specified user= over an unspecified user=. */
+	if (s1->user.str && !s2->user.str)
+		return -1;
+	if (!s1->user.str && s2->user.str)
+		return 1;
+
+	if (s1->user.str) {
+		/* Give precedence to a fixed user= string over a prefix. */
+		if (s1->user.is_prefix != s2->user.is_prefix)
+			return (s2->user.is_prefix ? -1 : 1);
+
+		/* Give precedence to a longer prefix over a shorter prefix. */
+		if (s1->user.is_prefix && s1->user.len != s2->user.len)
+			return (s1->user.len > s2->user.len) ? -1 : 1;
+	}
+
+	/* Give precedence to a specified seinfo= over an unspecified seinfo=. */
+	if (s1->seinfo && !s2->seinfo)
+		return -1;
+	if (!s1->seinfo && s2->seinfo)
+		return 1;
+
+	/* Give precedence to a specified name= over an unspecified name=. */
+	if (s1->name.str && !s2->name.str)
+		return -1;
+	if (!s1->name.str && s2->name.str)
+		return 1;
+
+	if (s1->name.str) {
+		/* Give precedence to a fixed name= string over a prefix. */
+		if (s1->name.is_prefix != s2->name.is_prefix)
+			return (s2->name.is_prefix ? -1 : 1);
+
+		/* Give precedence to a longer prefix over a shorter prefix. */
+		if (s1->name.is_prefix && s1->name.len != s2->name.len)
+			return (s1->name.len > s2->name.len) ? -1 : 1;
+	}
+
+	/* Give precedence to a specified path= over an unspecified path=. */
+	if (s1->path.str && !s2->path.str)
+		return -1;
+	if (!s1->path.str && s2->path.str)
+		return 1;
+
+	if (s1->path.str) {
+		/* Give precedence to a fixed path= string over a prefix. */
+		if (s1->path.is_prefix != s2->path.is_prefix)
+			return (s2->path.is_prefix ? -1 : 1);
+
+		/* Give precedence to a longer prefix over a shorter prefix. */
+		if (s1->path.is_prefix && s1->path.len != s2->path.len)
+			return (s1->path.len > s2->path.len) ? -1 : 1;
+	}
+
+	/*
+	 * Check for a duplicated entry on the input selectors.
+	 * We already compared isSystemServer, isOwnerSet, and isOwner above.
+	 * We also have already checked that both entries specify the same
+	 * string fields, so if s1 has a non-NULL string, then so does s2.
+	 */
+	dup = (!s1->user.str || !strcmp(s1->user.str, s2->user.str)) &&
+		(!s1->seinfo || !strcmp(s1->seinfo, s2->seinfo)) &&
+		(!s1->name.str || !strcmp(s1->name.str, s2->name.str)) &&
+		(!s1->path.str || !strcmp(s1->path.str, s2->path.str));
+	if (dup) {
+		seapp_contexts_dup = true;
+		selinux_log(SELINUX_ERROR, "seapp_contexts:  Duplicated entry\n");
+		if (s1->user.str)
+			selinux_log(SELINUX_ERROR, " user=%s\n", s1->user.str);
+		if (s1->seinfo)
+			selinux_log(SELINUX_ERROR, " seinfo=%s\n", s1->seinfo);
+		if (s1->name.str)
+			selinux_log(SELINUX_ERROR, " name=%s\n", s1->name.str);
+		if (s1->path.str)
+			selinux_log(SELINUX_ERROR, " path=%s\n", s1->path.str);
+	}
+
+	/* Anything else has equal precedence. */
+	return 0;
+}
+
+static struct seapp_context **seapp_contexts = NULL;
+static int nspec = 0;
+
+static void free_seapp_contexts(void)
+{
+	int n;
+
+	if (!seapp_contexts)
+		return;
+
+	for (n = 0; n < nspec; n++)
+		free_seapp_context(seapp_contexts[n]);
+
+	free(seapp_contexts);
+	seapp_contexts = NULL;
+	nspec = 0;
+}
+
+int selinux_android_seapp_context_reload(void)
+{
+	FILE *fp = NULL;
+	char line_buf[BUFSIZ];
+	char *token;
+	unsigned lineno;
+	struct seapp_context *cur;
+	char *p, *name = NULL, *value = NULL, *saveptr;
+	size_t len;
+	int n, ret;
+
+	set_policy_index();
+
+	fp = fopen(seapp_contexts_file[policy_index], "r");
+	if (!fp) {
+		selinux_log(SELINUX_ERROR, "%s:  could not open any seapp_contexts file", __FUNCTION__);
+		return -1;
+	}
+
+	free_seapp_contexts();
+
+	nspec = 0;
+	while (fgets(line_buf, sizeof line_buf - 1, fp)) {
+		p = line_buf;
+		while (isspace(*p))
+			p++;
+		if (*p == '#' || *p == 0)
+			continue;
+		nspec++;
+	}
+
+	seapp_contexts = (struct seapp_context **) calloc(nspec, sizeof(struct seapp_context *));
+	if (!seapp_contexts)
+		goto oom;
+
+	rewind(fp);
+	nspec = 0;
+	lineno = 1;
+	while (fgets(line_buf, sizeof line_buf - 1, fp)) {
+		len = strlen(line_buf);
+		if (line_buf[len - 1] == '\n')
+			line_buf[len - 1] = 0;
+		p = line_buf;
+		while (isspace(*p))
+			p++;
+		if (*p == '#' || *p == 0)
+			continue;
+
+		cur = (struct seapp_context *) calloc(1, sizeof(struct seapp_context));
+		if (!cur)
+			goto oom;
+
+		token = strtok_r(p, " \t", &saveptr);
+		if (!token) {
+			free_seapp_context(cur);
+			goto err;
+		}
+
+		while (1) {
+			name = token;
+			value = strchr(name, '=');
+			if (!value) {
+				free_seapp_context(cur);
+				goto err;
+			}
+			*value++ = 0;
+
+			if (!strcasecmp(name, "isSystemServer")) {
+				if (!strcasecmp(value, "true"))
+					cur->isSystemServer = true;
+				else if (!strcasecmp(value, "false"))
+					cur->isSystemServer = false;
+				else {
+					free_seapp_context(cur);
+					goto err;
+				}
+			} else if (!strcasecmp(name, "isOwner")) {
+				cur->isOwnerSet = true;
+				if (!strcasecmp(value, "true"))
+					cur->isOwner = true;
+				else if (!strcasecmp(value, "false"))
+					cur->isOwner = false;
+				else {
+					free_seapp_context(cur);
+					goto err;
+				}
+			} else if (!strcasecmp(name, "user")) {
+				if (cur->user.str) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->user.str = strdup(value);
+				if (!cur->user.str) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+				cur->user.len = strlen(cur->user.str);
+				if (cur->user.str[cur->user.len-1] == '*')
+					cur->user.is_prefix = 1;
+			} else if (!strcasecmp(name, "seinfo")) {
+				if (cur->seinfo) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->seinfo = strdup(value);
+				if (!cur->seinfo) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+			} else if (!strcasecmp(name, "name")) {
+				if (cur->name.str) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->name.str = strdup(value);
+				if (!cur->name.str) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+				cur->name.len = strlen(cur->name.str);
+				if (cur->name.str[cur->name.len-1] == '*')
+					cur->name.is_prefix = 1;
+			} else if (!strcasecmp(name, "domain")) {
+				if (cur->domain) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->domain = strdup(value);
+				if (!cur->domain) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+			} else if (!strcasecmp(name, "type")) {
+				if (cur->type) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->type = strdup(value);
+				if (!cur->type) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+			} else if (!strcasecmp(name, "levelFromUid")) {
+				if (cur->levelFrom) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				if (!strcasecmp(value, "true"))
+					cur->levelFrom = LEVELFROM_APP;
+				else if (!strcasecmp(value, "false"))
+					cur->levelFrom = LEVELFROM_NONE;
+				else {
+					free_seapp_context(cur);
+					goto err;
+				}
+			} else if (!strcasecmp(name, "levelFrom")) {
+				if (cur->levelFrom) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				if (!strcasecmp(value, "none"))
+					cur->levelFrom = LEVELFROM_NONE;
+				else if (!strcasecmp(value, "app"))
+					cur->levelFrom = LEVELFROM_APP;
+				else if (!strcasecmp(value, "user"))
+					cur->levelFrom = LEVELFROM_USER;
+				else if (!strcasecmp(value, "all"))
+					cur->levelFrom = LEVELFROM_ALL;
+				else {
+					free_seapp_context(cur);
+					goto err;
+				}
+			} else if (!strcasecmp(name, "level")) {
+				if (cur->level) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->level = strdup(value);
+				if (!cur->level) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+			} else if (!strcasecmp(name, "path")) {
+				if (cur->path.str) {
+					free_seapp_context(cur);
+					goto err;
+				}
+				cur->path.str = strdup(value);
+				if (!cur->path.str) {
+					free_seapp_context(cur);
+					goto oom;
+				}
+				cur->path.len = strlen(cur->path.str);
+				if (cur->path.str[cur->path.len-1] == '*')
+					cur->path.is_prefix = 1;
+			} else {
+				free_seapp_context(cur);
+				goto err;
+			}
+
+			token = strtok_r(NULL, " \t", &saveptr);
+			if (!token)
+				break;
+		}
+
+		if (cur->name.str &&
+		    (!cur->seinfo || !strcmp(cur->seinfo, "default"))) {
+			selinux_log(SELINUX_ERROR, "%s:  No specific seinfo value specified with name=\"%s\", on line %u:  insecure configuration!\n",
+				    seapp_contexts_file[policy_index], cur->name.str, lineno);
+			free_seapp_context(cur);
+			goto err;
+		}
+
+		seapp_contexts[nspec] = cur;
+		nspec++;
+		lineno++;
+	}
+
+	qsort(seapp_contexts, nspec, sizeof(struct seapp_context *),
+	      seapp_context_cmp);
+
+	if (seapp_contexts_dup)
+		goto err;
+
+#if DEBUG
+	{
+		int i;
+		for (i = 0; i < nspec; i++) {
+			cur = seapp_contexts[i];
+			selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s isOwner=%s user=%s seinfo=%s name=%s path=%s -> domain=%s type=%s level=%s levelFrom=%s",
+                        __FUNCTION__,
+                        cur->isSystemServer ? "true" : "false",
+                        cur->isOwnerSet ? (cur->isOwner ? "true" : "false") : "null",
+                        cur->user.str,
+                        cur->seinfo, cur->name.str, cur->path.str, cur->domain,
+                        cur->type, cur->level,
+                        levelFromName[cur->levelFrom]);
+		}
+	}
+#endif
+
+	ret = 0;
+
+out:
+	fclose(fp);
+	return ret;
+
+err:
+	selinux_log(SELINUX_ERROR, "%s:  Invalid entry on line %u\n",
+		    seapp_contexts_file[policy_index], lineno);
+	free_seapp_contexts();
+	ret = -1;
+	goto out;
+oom:
+	selinux_log(SELINUX_ERROR, 
+		    "%s:  Out of memory\n", __FUNCTION__);
+	free_seapp_contexts();
+	ret = -1;
+	goto out;
+}
+
+
+static void seapp_context_init(void)
+{
+        selinux_android_seapp_context_reload();
+}
+
+static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+/*
+ * Max id that can be mapped to category set uniquely
+ * using the current scheme.
+ */
+#define CAT_MAPPING_MAX_ID (0x1<<16)
+
+enum seapp_kind {
+	SEAPP_TYPE,
+	SEAPP_DOMAIN
+};
+
+static int seapp_context_lookup(enum seapp_kind kind,
+				uid_t uid,
+				bool isSystemServer,
+				const char *seinfo,
+				const char *pkgname,
+				const char *path,
+				context_t ctx)
+{
+	bool isOwner;
+	const char *username = NULL;
+	struct seapp_context *cur = NULL;
+	int i;
+	size_t n;
+	uid_t userid;
+	uid_t appid;
+
+	__selinux_once(once, seapp_context_init);
+
+	userid = uid / AID_USER;
+	isOwner = (userid == 0);
+	appid = uid % AID_USER;
+	if (appid < AID_APP) {
+		for (n = 0; n < android_id_count; n++) {
+			if (android_ids[n].aid == appid) {
+				username = android_ids[n].name;
+				break;
+			}
+		}
+		if (!username)
+			goto err;
+	} else if (appid < AID_ISOLATED_START) {
+		username = "_app";
+		appid -= AID_APP;
+	} else {
+		username = "_isolated";
+		appid -= AID_ISOLATED_START;
+	}
+
+	if (appid >= CAT_MAPPING_MAX_ID || userid >= CAT_MAPPING_MAX_ID)
+		goto err;
+
+	for (i = 0; i < nspec; i++) {
+		cur = seapp_contexts[i];
+
+		if (cur->isSystemServer != isSystemServer)
+			continue;
+
+		if (cur->isOwnerSet && cur->isOwner != isOwner)
+			continue;
+
+		if (cur->user.str) {
+			if (cur->user.is_prefix) {
+				if (strncasecmp(username, cur->user.str, cur->user.len-1))
+					continue;
+			} else {
+				if (strcasecmp(username, cur->user.str))
+					continue;
+			}
+		}
+
+		if (cur->seinfo) {
+			if (!seinfo || strcasecmp(seinfo, cur->seinfo))
+				continue;
+		}
+
+		if (cur->name.str) {
+			if(!pkgname)
+				continue;
+
+			if (cur->name.is_prefix) {
+				if (strncasecmp(pkgname, cur->name.str, cur->name.len-1))
+					continue;
+			} else {
+				if (strcasecmp(pkgname, cur->name.str))
+					continue;
+			}
+		}
+
+		if (cur->path.str) {
+			if (!path)
+				continue;
+
+			if (cur->path.is_prefix) {
+				if (strncmp(path, cur->path.str, cur->path.len-1))
+					continue;
+			} else {
+				if (strcmp(path, cur->path.str))
+					continue;
+			}
+		}
+
+		if (kind == SEAPP_TYPE && !cur->type)
+			continue;
+		else if (kind == SEAPP_DOMAIN && !cur->domain)
+			continue;
+
+		if (kind == SEAPP_TYPE) {
+			if (context_type_set(ctx, cur->type))
+				goto oom;
+		} else if (kind == SEAPP_DOMAIN) {
+			if (context_type_set(ctx, cur->domain))
+				goto oom;
+		}
+
+		if (cur->levelFrom != LEVELFROM_NONE) {
+			char level[255];
+			switch (cur->levelFrom) {
+			case LEVELFROM_APP:
+				snprintf(level, sizeof level, "s0:c%u,c%u",
+					 appid & 0xff,
+					 256 + (appid>>8 & 0xff));
+				break;
+			case LEVELFROM_USER:
+				snprintf(level, sizeof level, "s0:c%u,c%u",
+					 512 + (userid & 0xff),
+					 768 + (userid>>8 & 0xff));
+				break;
+			case LEVELFROM_ALL:
+				snprintf(level, sizeof level, "s0:c%u,c%u,c%u,c%u",
+					 appid & 0xff,
+					 256 + (appid>>8 & 0xff),
+					 512 + (userid & 0xff),
+					 768 + (userid>>8 & 0xff));
+				break;
+			default:
+				goto err;
+			}
+			if (context_range_set(ctx, level))
+				goto oom;
+		} else if (cur->level) {
+			if (context_range_set(ctx, cur->level))
+				goto oom;
+		}
+
+		break;
+	}
+
+	if (kind == SEAPP_DOMAIN && i == nspec) {
+		/*
+		 * No match.
+		 * Fail to prevent staying in the zygote's context.
+		 */
+		selinux_log(SELINUX_ERROR,
+			    "%s:  No match for app with uid %d, seinfo %s, name %s\n",
+			    __FUNCTION__, uid, seinfo, pkgname);
+
+		if (security_getenforce() == 1)
+			goto err;
+	}
+
+	return 0;
+err:
+	return -1;
+oom:
+	return -2;
+}
+
+int selinux_android_setfilecon(const char *pkgdir,
+				const char *pkgname,
+				const char *seinfo,
+				uid_t uid)
+{
+	char *orig_ctx_str = NULL;
+	char *ctx_str = NULL;
+	context_t ctx = NULL;
+	int rc = -1;
+
+	if (is_selinux_enabled() <= 0)
+		return 0;
+
+	rc = getfilecon(pkgdir, &ctx_str);
+	if (rc < 0)
+		goto err;
+
+	ctx = context_new(ctx_str);
+	orig_ctx_str = ctx_str;
+	if (!ctx)
+		goto oom;
+
+	rc = seapp_context_lookup(SEAPP_TYPE, uid, 0, seinfo, pkgname, NULL, ctx);
+	if (rc == -1)
+		goto err;
+	else if (rc == -2)
+		goto oom;
+
+	ctx_str = context_str(ctx);
+	if (!ctx_str)
+		goto oom;
+
+	rc = security_check_context(ctx_str);
+	if (rc < 0)
+		goto err;
+
+	if (strcmp(ctx_str, orig_ctx_str)) {
+		rc = setfilecon(pkgdir, ctx_str);
+		if (rc < 0)
+			goto err;
+	}
+
+	rc = 0;
+out:
+	freecon(orig_ctx_str);
+	context_free(ctx);
+	return rc;
+err:
+	selinux_log(SELINUX_ERROR, "%s:  Error setting context for pkgdir %s, uid %d: %s\n",
+		    __FUNCTION__, pkgdir, uid, strerror(errno));
+	rc = -1;
+	goto out;
+oom:
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __FUNCTION__);
+	rc = -1;
+	goto out;
+}
+
+int selinux_android_setcontext(uid_t uid,
+			       bool isSystemServer,
+			       const char *seinfo,
+			       const char *pkgname)
+{
+	char *orig_ctx_str = NULL, *ctx_str;
+	context_t ctx = NULL;
+	int rc = -1;
+
+	if (is_selinux_enabled() <= 0)
+		return 0;
+
+	rc = getcon(&ctx_str);
+	if (rc)
+		goto err;
+
+	ctx = context_new(ctx_str);
+	orig_ctx_str = ctx_str;
+	if (!ctx)
+		goto oom;
+
+	rc = seapp_context_lookup(SEAPP_DOMAIN, uid, isSystemServer, seinfo, pkgname, NULL, ctx);
+	if (rc == -1)
+		goto err;
+	else if (rc == -2)
+		goto oom;
+
+	ctx_str = context_str(ctx);
+	if (!ctx_str)
+		goto oom;
+
+	rc = security_check_context(ctx_str);
+	if (rc < 0)
+		goto err;
+
+	if (strcmp(ctx_str, orig_ctx_str)) {
+		rc = setcon(ctx_str);
+		if (rc < 0)
+			goto err;
+	}
+
+	rc = 0;
+out:
+	freecon(orig_ctx_str);
+	context_free(ctx);
+	avc_netlink_close();
+	return rc;
+err:
+	if (isSystemServer)
+		selinux_log(SELINUX_ERROR,
+				"%s:  Error setting context for system server: %s\n",
+				__FUNCTION__, strerror(errno));
+	else 
+		selinux_log(SELINUX_ERROR,
+				"%s:  Error setting context for app with uid %d, seinfo %s: %s\n",
+				__FUNCTION__, uid, seinfo, strerror(errno));
+
+	rc = -1;
+	goto out;
+oom:
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __FUNCTION__);
+	rc = -1;
+	goto out;
+}
+
+static struct selabel_handle *fc_sehandle = NULL;
+#define FC_DIGEST_SIZE SHA_DIGEST_SIZE
+static uint8_t fc_digest[FC_DIGEST_SIZE];
+
+static bool compute_contexts_hash(const struct selinux_opt opts[], uint8_t c_digest[])
+{
+    int fd;
+    struct stat sb;
+    void *map;
+
+    fd = open(opts[policy_index].value, O_CLOEXEC | O_RDONLY | O_NOFOLLOW);
+    if (fd < 0) {
+        selinux_log(SELINUX_ERROR, "SELinux:  Could not open %s:  %s\n",
+                    opts[policy_index].value, strerror(errno));
+        return false;
+    }
+    if (fstat(fd, &sb) < 0) {
+        selinux_log(SELINUX_ERROR, "SELinux:  Could not stat %s:  %s\n",
+                    opts[policy_index].value, strerror(errno));
+        close(fd);
+        return false;
+    }
+    map = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+    if (map == MAP_FAILED) {
+        selinux_log(SELINUX_ERROR, "SELinux:  Could not map %s:  %s\n",
+                    opts[policy_index].value, strerror(errno));
+        close(fd);
+        return false;
+    }
+    SHA_hash(map, sb.st_size, c_digest);
+    munmap(map, sb.st_size);
+    close(fd);
+
+    return true;
+}
+
+static void file_context_init(void)
+{
+    if (!fc_sehandle)
+        fc_sehandle = selinux_android_file_context_handle();
+}
+
+
+
+static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
+
+struct pkgInfo {
+    char *name;
+    uid_t uid;
+    bool debuggable;
+    char *dataDir;
+    char *seinfo;
+    struct pkgInfo *next;
+};
+
+#define PKGTAB_SIZE 256
+static struct pkgInfo *pkgTab[PKGTAB_SIZE];
+
+static unsigned int pkghash(const char *pkgname)
+{
+    unsigned int h = 7;
+    for (; *pkgname; pkgname++) {
+        h = h * 31 + *pkgname;
+    }
+    return h & (PKGTAB_SIZE - 1);
+}
+
+/* The file containing the list of installed packages on the system */
+#define PACKAGES_LIST_FILE  "/data/system/packages.list"
+
+static void package_info_init(void)
+{
+    char *buf = NULL;
+    size_t buflen = 0;
+    ssize_t bytesread;
+    FILE *fp;
+    char *cur, *next;
+    struct pkgInfo *pkgInfo = NULL;
+    unsigned int hash;
+    unsigned long lineno = 1;
+
+    fp = fopen(PACKAGES_LIST_FILE, "r");
+    if (!fp) {
+        selinux_log(SELINUX_ERROR, "SELinux:  Could not open %s:  %s.\n",
+                    PACKAGES_LIST_FILE, strerror(errno));
+        return;
+    }
+    while ((bytesread = getline(&buf, &buflen, fp)) > 0) {
+        pkgInfo = calloc(1, sizeof(*pkgInfo));
+        if (!pkgInfo)
+            goto err;
+        next = buf;
+        cur = strsep(&next, " \t\n");
+        if (!cur)
+            goto err;
+        pkgInfo->name = strdup(cur);
+        if (!pkgInfo->name)
+            goto err;
+        cur = strsep(&next, " \t\n");
+        if (!cur)
+            goto err;
+        pkgInfo->uid = atoi(cur);
+        if (!pkgInfo->uid)
+            goto err;
+        cur = strsep(&next, " \t\n");
+        if (!cur)
+            goto err;
+        pkgInfo->debuggable = atoi(cur);
+        cur = strsep(&next, " \t\n");
+        if (!cur)
+            goto err;
+        pkgInfo->dataDir = strdup(cur);
+        if (!pkgInfo->dataDir)
+            goto err;
+        cur = strsep(&next, " \t\n");
+        if (!cur)
+            goto err;
+        pkgInfo->seinfo = strdup(cur);
+        if (!pkgInfo->seinfo)
+            goto err;
+
+        hash = pkghash(pkgInfo->name);
+        if (pkgTab[hash])
+            pkgInfo->next = pkgTab[hash];
+        pkgTab[hash] = pkgInfo;
+
+        lineno++;
+    }
+
+#if DEBUG
+    {
+        unsigned int buckets, entries, chainlen, longestchain;
+
+        buckets = entries = longestchain = 0;
+        for (hash = 0; hash < PKGTAB_SIZE; hash++) {
+            if (pkgTab[hash]) {
+                buckets++;
+                chainlen = 0;
+                for (pkgInfo = pkgTab[hash]; pkgInfo; pkgInfo = pkgInfo->next) {
+                    chainlen++;
+                    selinux_log(SELINUX_INFO, "%s:  name=%s uid=%u debuggable=%s dataDir=%s seinfo=%s\n",
+                                __FUNCTION__,
+                                pkgInfo->name, pkgInfo->uid, pkgInfo->debuggable ? "true" : "false", pkgInfo->dataDir, pkgInfo->seinfo);
+                }
+                entries += chainlen;
+                if (longestchain < chainlen)
+                    longestchain = chainlen;
+            }
+        }
+        selinux_log(SELINUX_INFO, "SELinux:  %d pkg entries and %d/%d buckets used, longest chain %d\n", entries, buckets, PKGTAB_SIZE, longestchain);
+    }
+#endif
+
+out:
+    free(buf);
+    fclose(fp);
+    return;
+
+err:
+    selinux_log(SELINUX_ERROR, "SELinux:  Error reading %s on line %lu.\n",
+                PACKAGES_LIST_FILE, lineno);
+    if (pkgInfo) {
+        free(pkgInfo->name);
+        free(pkgInfo->dataDir);
+        free(pkgInfo->seinfo);
+        free(pkgInfo);
+    }
+    goto out;
+}
+
+static pthread_once_t pkg_once = PTHREAD_ONCE_INIT;
+
+struct pkgInfo *package_info_lookup(const char *name)
+{
+    struct pkgInfo *pkgInfo;
+    unsigned int hash;
+
+    __selinux_once(pkg_once, package_info_init);
+
+    hash = pkghash(name);
+    for (pkgInfo = pkgTab[hash]; pkgInfo; pkgInfo = pkgInfo->next) {
+        if (!strcmp(name, pkgInfo->name))
+            return pkgInfo;
+    }
+    return NULL;
+}
+
+/* The path prefixes of package data directories. */
+#define DATA_DATA_PATH "/data/data"
+#define DATA_USER_PATH "/data/user"
+#define EXPAND_USER_PATH "/mnt/expand/\?\?\?\?\?\?\?\?-\?\?\?\?-\?\?\?\?-\?\?\?\?-\?\?\?\?\?\?\?\?\?\?\?\?/user"
+#define DATA_DATA_PREFIX DATA_DATA_PATH "/"
+#define DATA_USER_PREFIX DATA_USER_PATH "/"
+
+static int pkgdir_selabel_lookup(const char *pathname,
+                                 const char *seinfo,
+                                 uid_t uid,
+                                 char **secontextp)
+{
+    char *pkgname = NULL, *end = NULL;
+    struct pkgInfo *pkgInfo = NULL;
+    char *secontext = *secontextp;
+    context_t ctx = NULL;
+    int rc = 0;
+
+    /* Skip directory prefix before package name. */
+    if (!strncmp(pathname, DATA_DATA_PREFIX, sizeof(DATA_DATA_PREFIX)-1)) {
+        pathname += sizeof(DATA_DATA_PREFIX) - 1;
+    } else if (!strncmp(pathname, DATA_USER_PREFIX, sizeof(DATA_USER_PREFIX)-1)) {
+        pathname += sizeof(DATA_USER_PREFIX) - 1;
+        while (isdigit(*pathname))
+            pathname++;
+        if (*pathname == '/')
+            pathname++;
+        else
+            return 0;
+    } else if (!fnmatch(EXPAND_USER_PATH, pathname, FNM_LEADING_DIR|FNM_PATHNAME)) {
+        pathname += sizeof(EXPAND_USER_PATH);
+        while (isdigit(*pathname))
+            pathname++;
+        if (*pathname == '/')
+            pathname++;
+        else
+            return 0;
+    } else
+        return 0;
+
+    if (!(*pathname))
+        return 0;
+
+    pkgname = strdup(pathname);
+    if (!pkgname)
+        return -1;
+
+    for (end = pkgname; *end && *end != '/'; end++)
+        ;
+    pathname = end;
+    if (*end)
+        pathname++;
+    *end = '\0';
+
+    if (!seinfo) {
+        pkgInfo = package_info_lookup(pkgname);
+        if (!pkgInfo) {
+            selinux_log(SELINUX_WARNING, "SELinux:  Could not look up information for package %s, cannot restorecon %s.\n",
+                        pkgname, pathname);
+            free(pkgname);
+            return -1;
+        }
+    }
+
+    ctx = context_new(secontext);
+    if (!ctx)
+        goto err;
+
+    rc = seapp_context_lookup(SEAPP_TYPE, pkgInfo ? pkgInfo->uid : uid, 0,
+                              pkgInfo ? pkgInfo->seinfo : seinfo, pkgInfo ? pkgInfo->name : pkgname, pathname, ctx);
+    if (rc < 0)
+        goto err;
+
+    secontext = context_str(ctx);
+    if (!secontext)
+        goto err;
+
+    if (!strcmp(secontext, *secontextp))
+        goto out;
+
+    rc = security_check_context(secontext);
+    if (rc < 0)
+        goto err;
+
+    freecon(*secontextp);
+    *secontextp = strdup(secontext);
+    if (!(*secontextp))
+        goto err;
+
+    rc = 0;
+
+out:
+    free(pkgname);
+    context_free(ctx);
+    return rc;
+err:
+    selinux_log(SELINUX_ERROR, "%s:  Error looking up context for path %s, pkgname %s, seinfo %s, uid %u: %s\n",
+                __FUNCTION__, pathname, pkgname, pkgInfo->seinfo, pkgInfo->uid, strerror(errno));
+    rc = -1;
+    goto out;
+}
+
+#define RESTORECON_LAST "security.restorecon_last"
+
+static int restorecon_sb(const char *pathname, const struct stat *sb,
+                         bool nochange, bool verbose,
+                         const char *seinfo, uid_t uid)
+{
+    char *secontext = NULL;
+    char *oldsecontext = NULL;
+    int rc = 0;
+
+    if (selabel_lookup(fc_sehandle, &secontext, pathname, sb->st_mode) < 0)
+        return 0;  /* no match, but not an error */
+
+    if (lgetfilecon(pathname, &oldsecontext) < 0)
+        goto err;
+
+    /*
+     * For subdirectories of /data/data or /data/user, we ignore selabel_lookup()
+     * and use pkgdir_selabel_lookup() instead. Files within those directories
+     * have different labeling rules, based off of /seapp_contexts, and
+     * installd is responsible for managing these labels instead of init.
+     */
+    if (!strncmp(pathname, DATA_DATA_PREFIX, sizeof(DATA_DATA_PREFIX)-1) ||
+        !strncmp(pathname, DATA_USER_PREFIX, sizeof(DATA_USER_PREFIX)-1) ||
+        !fnmatch(EXPAND_USER_PATH, pathname, FNM_LEADING_DIR|FNM_PATHNAME)) {
+        if (pkgdir_selabel_lookup(pathname, seinfo, uid, &secontext) < 0)
+            goto err;
+    }
+
+    if (strcmp(oldsecontext, secontext) != 0) {
+        if (verbose)
+            selinux_log(SELINUX_INFO,
+                        "SELinux:  Relabeling %s from %s to %s.\n", pathname, oldsecontext, secontext);
+        if (!nochange) {
+            if (lsetfilecon(pathname, secontext) < 0)
+                goto err;
+        }
+    }
+
+    rc = 0;
+
+out:
+    freecon(oldsecontext);
+    freecon(secontext);
+    return rc;
+
+err:
+    selinux_log(SELINUX_ERROR,
+                "SELinux: Could not set context for %s:  %s\n",
+                pathname, strerror(errno));
+    rc = -1;
+    goto out;
+}
+
+#define SYS_PATH "/sys"
+#define SYS_PREFIX SYS_PATH "/"
+
+static int selinux_android_restorecon_common(const char* pathname,
+                                             const char *seinfo,
+                                             uid_t uid,
+                                             unsigned int flags)
+{
+    bool nochange = (flags & SELINUX_ANDROID_RESTORECON_NOCHANGE) ? true : false;
+    bool verbose = (flags & SELINUX_ANDROID_RESTORECON_VERBOSE) ? true : false;
+    bool recurse = (flags & SELINUX_ANDROID_RESTORECON_RECURSE) ? true : false;
+    bool force = (flags & SELINUX_ANDROID_RESTORECON_FORCE) ? true : false;
+    bool datadata = (flags & SELINUX_ANDROID_RESTORECON_DATADATA) ? true : false;
+    bool issys = (!strcmp(pathname, SYS_PATH) || !strncmp(pathname, SYS_PREFIX, sizeof(SYS_PREFIX)-1)) ? true : false;
+    bool setrestoreconlast = true;
+    struct stat sb;
+    FTS *fts;
+    FTSENT *ftsent;
+    char *const paths[2] = { __UNCONST(pathname), NULL };
+    int ftsflags = FTS_NOCHDIR | FTS_XDEV | FTS_PHYSICAL;
+    int error, sverrno;
+    char xattr_value[FC_DIGEST_SIZE];
+    ssize_t size;
+
+    if (is_selinux_enabled() <= 0)
+        return 0;
+
+    __selinux_once(fc_once, file_context_init);
+
+    if (!fc_sehandle)
+        return 0;
+
+    if (!recurse) {
+        if (lstat(pathname, &sb) < 0)
+            return -1;
+
+        return restorecon_sb(pathname, &sb, nochange, verbose, seinfo, uid);
+    }
+
+    /*
+     * Ignore restorecon_last on /data/data or /data/user
+     * since their labeling is based on seapp_contexts and seinfo
+     * assignments rather than file_contexts and is managed by
+     * installd rather than init.
+     */
+    if (!strncmp(pathname, DATA_DATA_PREFIX, sizeof(DATA_DATA_PREFIX)-1) ||
+        !strncmp(pathname, DATA_USER_PREFIX, sizeof(DATA_USER_PREFIX)-1) ||
+        !fnmatch(EXPAND_USER_PATH, pathname, FNM_LEADING_DIR|FNM_PATHNAME))
+        setrestoreconlast = false;
+
+    /* Also ignore on /sys since it is regenerated on each boot regardless. */
+    if (issys)
+        setrestoreconlast = false;
+
+    if (setrestoreconlast) {
+        size = getxattr(pathname, RESTORECON_LAST, xattr_value, sizeof fc_digest);
+        if (!force && size == sizeof fc_digest && memcmp(fc_digest, xattr_value, sizeof fc_digest) == 0) {
+            selinux_log(SELINUX_INFO,
+                        "SELinux: Skipping restorecon_recursive(%s)\n",
+                        pathname);
+            return 0;
+        }
+    }
+
+    fts = fts_open(paths, ftsflags, NULL);
+    if (!fts)
+        return -1;
+
+    error = 0;
+    while ((ftsent = fts_read(fts)) != NULL) {
+        switch (ftsent->fts_info) {
+        case FTS_DC:
+            selinux_log(SELINUX_ERROR,
+                        "SELinux:  Directory cycle on %s.\n", ftsent->fts_path);
+            errno = ELOOP;
+            error = -1;
+            goto out;
+        case FTS_DP:
+            continue;
+        case FTS_DNR:
+            selinux_log(SELINUX_ERROR,
+                        "SELinux:  Could not read %s: %s.\n", ftsent->fts_path, strerror(errno));
+            fts_set(fts, ftsent, FTS_SKIP);
+            continue;
+        case FTS_NS:
+            selinux_log(SELINUX_ERROR,
+                        "SELinux:  Could not stat %s: %s.\n", ftsent->fts_path, strerror(errno));
+            fts_set(fts, ftsent, FTS_SKIP);
+            continue;
+        case FTS_ERR:
+            selinux_log(SELINUX_ERROR,
+                        "SELinux:  Error on %s: %s.\n", ftsent->fts_path, strerror(errno));
+            fts_set(fts, ftsent, FTS_SKIP);
+            continue;
+        case FTS_D:
+            if (issys && !selabel_partial_match(fc_sehandle, ftsent->fts_path)) {
+                fts_set(fts, ftsent, FTS_SKIP);
+                continue;
+            }
+
+            if (!datadata &&
+                (!strcmp(ftsent->fts_path, DATA_DATA_PATH) ||
+                 !strncmp(ftsent->fts_path, DATA_USER_PREFIX, sizeof(DATA_USER_PREFIX)-1) ||
+                 !fnmatch(EXPAND_USER_PATH, ftsent->fts_path, FNM_LEADING_DIR|FNM_PATHNAME))) {
+                // Don't label anything below this directory.
+                fts_set(fts, ftsent, FTS_SKIP);
+                // but fall through and make sure we label the directory itself
+            }
+            /* fall through */
+        default:
+            error |= restorecon_sb(ftsent->fts_path, ftsent->fts_statp, nochange, verbose, seinfo, uid);
+            break;
+        }
+    }
+
+    // Labeling successful. Mark the top level directory as completed.
+    if (setrestoreconlast && !nochange && !error)
+        setxattr(pathname, RESTORECON_LAST, fc_digest, sizeof fc_digest, 0);
+
+out:
+    sverrno = errno;
+    (void) fts_close(fts);
+    errno = sverrno;
+    return error;
+}
+
+int selinux_android_restorecon(const char *file, unsigned int flags)
+{
+    return selinux_android_restorecon_common(file, NULL, -1, flags);
+}
+
+int selinux_android_restorecon_pkgdir(const char *pkgdir,
+                                      const char *seinfo,
+                                      uid_t uid,
+                                      unsigned int flags)
+{
+    return selinux_android_restorecon_common(pkgdir, seinfo, uid, flags | SELINUX_ANDROID_RESTORECON_DATADATA);
+}
+
+struct selabel_handle* selinux_android_file_context_handle(void)
+{
+    struct selabel_handle *sehandle;
+
+    set_policy_index();
+    sehandle = selabel_open(SELABEL_CTX_FILE, &seopts[policy_index], 1);
+
+    if (!sehandle) {
+        selinux_log(SELINUX_ERROR, "%s: Error getting file context handle (%s)\n",
+                __FUNCTION__, strerror(errno));
+        return NULL;
+    }
+    if (!compute_contexts_hash(seopts, fc_digest)) {
+        selabel_close(sehandle);
+        return NULL;
+    }
+    selinux_log(SELINUX_INFO, "SELinux: Loaded file_contexts contexts from %s.\n",
+            seopts[policy_index].value);
+
+    return sehandle;
+}
+
+struct selabel_handle* selinux_android_prop_context_handle(void)
+{
+    struct selabel_handle* sehandle;
+
+    set_policy_index();
+    sehandle = selabel_open(SELABEL_CTX_ANDROID_PROP,
+            &seopts_prop[policy_index], 1);
+    if (!sehandle) {
+        selinux_log(SELINUX_ERROR, "%s: Error getting property context handle (%s)\n",
+                __FUNCTION__, strerror(errno));
+        return NULL;
+    }
+    selinux_log(SELINUX_INFO, "SELinux: Loaded property_contexts from %s.\n",
+            seopts_prop[policy_index].value);
+
+    return sehandle;
+}
+
+struct selabel_handle* selinux_android_service_context_handle(void)
+{
+    struct selabel_handle* sehandle;
+
+    set_policy_index();
+    sehandle = selabel_open(SELABEL_CTX_ANDROID_PROP,
+            &seopts_service[policy_index], 1);
+
+    if (!sehandle) {
+        selinux_log(SELINUX_ERROR, "%s: Error getting service context handle (%s)\n",
+                __FUNCTION__, strerror(errno));
+        return NULL;
+    }
+    selinux_log(SELINUX_INFO, "SELinux: Loaded service_contexts from %s.\n",
+            seopts_service[policy_index].value);
+
+    return sehandle;
+}
+
+void selinux_android_set_sehandle(const struct selabel_handle *hndl)
+{
+    fc_sehandle = (struct selabel_handle *) hndl;
+}
+
+static int selinux_android_load_policy_helper(bool reload)
+{
+	int fd = -1, rc;
+	struct stat sb;
+	void *map = NULL;
+	int old_policy_index = policy_index;
+
+	/*
+	 * If reloading policy and there is no /data policy or
+	 * that /data policy has the wrong version and our prior
+	 * load was from the / policy, then just return.
+	 * There is no point in reloading policy from / a second time.
+	 */
+	set_policy_index();
+	if (reload && !policy_index && !old_policy_index)
+		return 0;
+
+	fd = open(sepolicy_file[policy_index], O_RDONLY | O_NOFOLLOW);
+	if (fd < 0) {
+		selinux_log(SELINUX_ERROR, "SELinux:  Could not open sepolicy:  %s\n",
+				strerror(errno));
+		return -1;
+	}
+	if (fstat(fd, &sb) < 0) {
+		selinux_log(SELINUX_ERROR, "SELinux:  Could not stat %s:  %s\n",
+				sepolicy_file[policy_index], strerror(errno));
+		close(fd);
+		return -1;
+	}
+	map = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) {
+		selinux_log(SELINUX_ERROR, "SELinux:  Could not map %s:  %s\n",
+				sepolicy_file[policy_index], strerror(errno));
+		close(fd);
+		return -1;
+	}
+
+	rc = security_load_policy(map, sb.st_size);
+	if (rc < 0) {
+		selinux_log(SELINUX_ERROR, "SELinux:  Could not load policy:  %s\n",
+				strerror(errno));
+		munmap(map, sb.st_size);
+		close(fd);
+		return -1;
+	}
+
+	munmap(map, sb.st_size);
+	close(fd);
+	selinux_log(SELINUX_INFO, "SELinux: Loaded policy from %s\n", sepolicy_file[policy_index]);
+
+	return 0;
+}
+
+int selinux_android_reload_policy(void)
+{
+    return selinux_android_load_policy_helper(true);
+}
+
+int selinux_android_load_policy(void)
+{
+	const char *mnt = SELINUXMNT;
+	int rc;
+	rc = mount(SELINUXFS, mnt, SELINUXFS, 0, NULL);
+	if (rc < 0) {
+		if (errno == ENODEV) {
+			/* SELinux not enabled in kernel */
+			return -1;
+		}
+		if (errno == ENOENT) {
+			/* Fall back to legacy mountpoint. */
+			mnt = OLDSELINUXMNT;
+			rc = mkdir(mnt, 0755);
+			if (rc == -1 && errno != EEXIST) {
+				selinux_log(SELINUX_ERROR,"SELinux:  Could not mkdir:  %s\n",
+					strerror(errno));
+				return -1;
+			}
+			rc = mount(SELINUXFS, mnt, SELINUXFS, 0, NULL);
+		}
+	}
+	if (rc < 0) {
+		selinux_log(SELINUX_ERROR,"SELinux:  Could not mount selinuxfs:  %s\n",
+				strerror(errno));
+		return -1;
+	}
+	set_selinuxmnt(mnt);
+
+    return selinux_android_load_policy_helper(false);
+}
+
+int selinux_log_callback(int type, const char *fmt, ...)
+{
+    va_list ap;
+    int priority;
+    char *strp;
+
+    switch(type) {
+    case SELINUX_WARNING:
+        priority = ANDROID_LOG_WARN;
+        break;
+    case SELINUX_INFO:
+        priority = ANDROID_LOG_INFO;
+        break;
+    default:
+        priority = ANDROID_LOG_ERROR;
+        break;
+    }
+
+    va_start(ap, fmt);
+    if (vasprintf(&strp, fmt, ap) != -1) {
+        LOG_PRI(priority, "SELinux", "%s", strp);
+        LOG_EVENT_STRING(AUDITD_LOG_TAG, strp);
+        free(strp);
+    }
+    va_end(ap);
+    return 0;
+}
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b1ec57f..5494269 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -67,6 +67,46 @@ static inline int avc_hash(security_id_t ssid,
 	    & (AVC_CACHE_SLOTS - 1);
 }
 
+#ifdef ANDROID
+int avc_context_to_sid(const char * ctx, security_id_t * sid)
+{
+	int rc;
+	/* avc_init needs to be called before this function */
+	assert(avc_running);
+
+	avc_get_lock(avc_lock);
+	rc = sidtab_context_to_sid(&avc_sidtab, ctx, sid);
+	avc_release_lock(avc_lock);
+	return rc;
+}
+
+int avc_sid_to_context(security_id_t sid, char ** ctx)
+{
+	int rc;
+	*ctx = NULL;
+	avc_get_lock(avc_lock);
+	*ctx = strdup(sid->ctx);	/* caller must free via freecon */
+	rc = *ctx ? 0 : -1;
+	avc_release_lock(avc_lock);
+	return rc;
+}
+
+int avc_get_initial_sid(const char * name, security_id_t * sid)
+{
+	int rc;
+	char * con;
+
+	rc = security_get_initial_context(name, &con);
+	if (rc < 0)
+		return rc;
+	rc = avc_context_to_sid(con, sid);
+
+	freecon(con);
+
+	return rc;
+}
+
+#else
 int avc_context_to_sid_raw(const char * ctx, security_id_t * sid)
 {
 	int rc;
@@ -144,6 +184,7 @@ int avc_get_initial_sid(const char * name, security_id_t * sid)
 
 	return rc;
 }
+#endif /* ANDROID */
 
 int avc_open(struct selinux_opt *opts, unsigned nopts)
 {
@@ -785,9 +826,15 @@ int avc_has_perm_noaudit(security_id_t ssid,
 		avc_cache_stats_incr(entry_misses);
 		rc = avc_lookup(ssid, tsid, tclass, requested, aeref);
 		if (rc) {
+#ifdef ANDROID
+			rc = security_compute_av(ssid->ctx, tsid->ctx,
+						 	   tclass, requested,
+						 	   &entry.avd);
+#else
 			rc = security_compute_av_flags_raw(ssid->ctx, tsid->ctx,
 							   tclass, requested,
 							   &entry.avd);
+#endif
 			if (rc && errno == EINVAL && !avc_enforcing) {
 				rc = errno = 0;
 				goto out;
@@ -854,8 +901,13 @@ int avc_compute_create(security_id_t ssid,  security_id_t tsid,
 	rc = avc_lookup(ssid, tsid, tclass, 0, &aeref);
 	if (rc) {
 		/* need to make a cache entry for this tuple */
+#ifdef ANDROID
+		rc = security_compute_av(ssid->ctx, tsid->ctx,
+						   tclass, 0, &entry.avd);
+#else
 		rc = security_compute_av_flags_raw(ssid->ctx, tsid->ctx,
 						   tclass, 0, &entry.avd);
+#endif
 		if (rc)
 			goto out;
 		rc = avc_insert(ssid, tsid, tclass, &entry, &aeref);
@@ -866,8 +918,13 @@ int avc_compute_create(security_id_t ssid,  security_id_t tsid,
 	/* check for a saved compute_create value */
 	if (!aeref.ae->create_sid) {
 		/* need to query the kernel policy */
+#ifdef ANDROID
+		rc = security_compute_create(ssid->ctx, tsid->ctx, tclass,
+						 &ctx);
+#else
 		rc = security_compute_create_raw(ssid->ctx, tsid->ctx, tclass,
 						 &ctx);
+#endif
 		if (rc)
 			goto out;
 		rc = sidtab_context_to_sid(&avc_sidtab, ctx, newsid);
@@ -887,6 +944,7 @@ out:
 	return rc;
 }
 
+#ifndef ANDROID
 int avc_compute_member(security_id_t ssid,  security_id_t tsid,
 		       security_class_t tclass, security_id_t *newsid)
 {
@@ -906,6 +964,7 @@ out:
 	avc_release_lock(avc_lock);
 	return rc;
 }
+#endif
 
 int avc_add_callback(int (*callback) (uint32_t event, security_id_t ssid,
 				      security_id_t tsid,
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index f851659..37aa196 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -20,7 +20,11 @@
 extern void *(*avc_func_malloc) (size_t) hidden;
 extern void (*avc_func_free) (void *)hidden;
 
+#ifdef ANDROID
+extern void (*avc_func_log) (const char *, ...)hidden;
+#else
 extern void (*avc_func_log) (const char *, ...) __attribute__((__format__(printf,1,2))) hidden;
+#endif
 extern void (*avc_func_audit) (void *, security_class_t, char *, size_t)hidden;
 
 extern int avc_using_threads hidden;
diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 4b39a28..067964c 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -63,7 +63,11 @@ int security_get_boolean_names(char ***names, int *len)
 	}
 
 	for (i = 0; i < *len; i++) {
+#ifdef ANDROID
+	        n[i] = strdup(namelist[i]->d_name);
+#else
 		n[i] = (char *)malloc(_D_ALLOC_NAMLEN(namelist[i]));
+#endif
 		if (!n[i]) {
 			rc = -1;
 			goto bad_freen;
@@ -88,6 +92,7 @@ int security_get_boolean_names(char ***names, int *len)
 
 hidden_def(security_get_boolean_names)
 
+#ifndef ANDROID
 char *selinux_boolean_sub(const char *name)
 {
 	char *sub = NULL;
@@ -195,6 +200,7 @@ out:
 
 	return fd;
 }
+#endif  /* NOT an ANDROID build */
 
 #define STRBUF_SIZE 3
 static int get_bool_value(const char *name, char **buf)
@@ -212,8 +218,11 @@ static int get_bool_value(const char *name, char **buf)
 		return -1;
 
 	(*buf)[STRBUF_SIZE] = 0;
-
+#ifdef ANDROID
+	fd = open(name, O_RDONLY);
+#else
 	fd = bool_open(name, O_RDONLY);
+#endif
 	if (fd < 0)
 		goto out_err;
 
@@ -278,8 +287,11 @@ int security_set_boolean(const char *name, int value)
 		errno = EINVAL;
 		return -1;
 	}
-
+#ifdef ANDROID
+	fd = open(name, O_WRONLY);
+#else
 	fd = bool_open(name, O_WRONLY);
+#endif
 	if (fd < 0)
 		return -1;
 
@@ -330,6 +342,7 @@ int security_commit_booleans(void)
 
 hidden_def(security_commit_booleans)
 
+#ifndef ANDROID
 static char *strtrim(char *dest, char *source, int size)
 {
 	int i = 0;
@@ -486,6 +499,8 @@ static int save_booleans(size_t boolcnt, SELboolean * boollist)
 	free(used);
 	return 0;
 }
+#endif /* Not ANDROID build */
+
 static void rollback(SELboolean * boollist, int end)
 {
 	int i;
@@ -496,8 +511,13 @@ static void rollback(SELboolean * boollist, int end)
 								 name));
 }
 
+#ifdef ANDROID
+int security_set_boolean_list(size_t boolcnt, SELboolean * const boollist,
+			      int permanent __attribute__((unused)))
+#else
 int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
 			      int permanent)
+#endif
 {
 
 	size_t i;
@@ -512,12 +532,14 @@ int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
 	if (security_commit_booleans()) {
 		return -1;
 	}
-
+#ifndef ANDROID
 	if (permanent)
 		return save_booleans(boolcnt, boollist);
-
+#endif
 	return 0;
 }
+
+#ifndef ANDROID
 int security_load_booleans(char *path)
 {
 	FILE *boolf;
@@ -568,3 +590,4 @@ int security_load_booleans(char *path)
 		errno = EINVAL;
 	return errors ? -1 : 0;
 }
+#endif /* Not ANDROID build */
diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index 7cf3139..bcfb496 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -9,8 +9,13 @@
 #include "policy.h"
 #include <limits.h>
 
+#ifdef ANDROID
+int security_canonicalize_context(const char * con,
+				      char ** canoncon)
+#else
 int security_canonicalize_context_raw(const char * con,
 				      char ** canoncon)
+#endif
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -59,7 +64,7 @@ int security_canonicalize_context_raw(const char * con,
 	close(fd);
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(security_canonicalize_context_raw)
 
 int security_canonicalize_context(const char * con,
@@ -84,3 +89,4 @@ int security_canonicalize_context(const char * con,
 }
 
 hidden_def(security_canonicalize_context)
+#endif
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 29be16e..abac61f 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -60,6 +60,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
 }
 
+#ifndef ANDROID
 int selinux_check_passwd_access(access_vector_t requested)
 {
 	int status = -1;
@@ -99,3 +100,4 @@ int checkPasswdAccess(access_vector_t requested)
 {
 	return selinux_check_passwd_access(requested);
 }
+#endif
diff --git a/libselinux/src/check_context.c b/libselinux/src/check_context.c
index 52063fa..1055e04 100644
--- a/libselinux/src/check_context.c
+++ b/libselinux/src/check_context.c
@@ -9,7 +9,11 @@
 #include "policy.h"
 #include <limits.h>
 
+#ifdef ANDROID
+int security_check_context(const char * con)
+#else
 int security_check_context_raw(const char * con)
+#endif
 {
 	char path[PATH_MAX];
 	int fd, ret;
@@ -30,7 +34,7 @@ int security_check_context_raw(const char * con)
 		return -1;
 	return 0;
 }
-
+#ifndef ANDROID
 hidden_def(security_check_context_raw)
 
 int security_check_context(const char * con)
@@ -49,3 +53,4 @@ int security_check_context(const char * con)
 }
 
 hidden_def(security_check_context)
+#endif
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 937e5c3..554e981 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -10,11 +10,19 @@
 #include "policy.h"
 #include "mapping.h"
 
+#ifdef ANDROID
+int security_compute_av(const char * scon,
+				  const char * tcon,
+				  security_class_t tclass,
+				  access_vector_t requested,
+				  struct av_decision *avd)
+#else
 int security_compute_av_flags_raw(const char * scon,
 				  const char * tcon,
 				  security_class_t tclass,
 				  access_vector_t requested,
 				  struct av_decision *avd)
+#endif
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -71,7 +79,7 @@ int security_compute_av_flags_raw(const char * scon,
 	close(fd);
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(security_compute_av_flags_raw)
 
 int security_compute_av_raw(const char * scon,
@@ -155,3 +163,4 @@ int security_compute_av(const char * scon,
 }
 
 hidden_def(security_compute_av)
+#endif /* Not an ANDROID build */
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 9559d42..1d7e642 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -11,6 +11,7 @@
 #include "policy.h"
 #include "mapping.h"
 
+#ifndef ANDROID
 static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 {
 	int	code;
@@ -47,12 +48,21 @@ static int object_name_encode(const char *objname, char *buffer, size_t buflen)
 
 	return 0;
 }
+#endif  /* Not an ANDROID build */
 
+#ifdef ANDROID
+int security_compute_create_name_raw(const char * scon,
+				     const char * tcon,
+				     security_class_t tclass,
+				     const char *objname __attribute__((unused)),
+				     char ** newcon)
+#else
 int security_compute_create_name_raw(const char * scon,
 				     const char * tcon,
 				     security_class_t tclass,
 				     const char *objname,
 				     char ** newcon)
+#endif
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -77,13 +87,14 @@ int security_compute_create_name_raw(const char * scon,
 	}
 	len = snprintf(buf, size, "%s %s %hu",
 		       scon, tcon, unmap_class(tclass));
+#ifndef ANDROID
 	if (objname &&
 	    object_name_encode(objname, buf + len, size - len) < 0) {
 		errno = ENAMETOOLONG;
 		ret = -1;
 		goto out2;
 	}
-
+#endif
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
 		goto out2;
@@ -107,6 +118,7 @@ int security_compute_create_name_raw(const char * scon,
 }
 hidden_def(security_compute_create_name_raw)
 
+#ifndef ANDROID
 int security_compute_create_raw(const char * scon,
 				const char * tcon,
 				security_class_t tclass,
@@ -147,12 +159,17 @@ int security_compute_create_name(const char * scon,
 	return ret;
 }
 hidden_def(security_compute_create_name)
+#endif  /* Not an ANDROID build */
 
 int security_compute_create(const char * scon,
 				const char * tcon,
 			    security_class_t tclass,
 				char ** newcon)
 {
+#ifdef ANDROID
+	return security_compute_create_name_raw(scon, tcon, tclass, NULL, newcon);
+#else
 	return security_compute_create_name(scon, tcon, tclass, NULL, newcon);
+#endif
 }
 hidden_def(security_compute_create)
diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index 3954e64..21b49fc 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -7,7 +7,11 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifdef ANDROID
+int fgetfilecon(int fd, char ** context)
+#else
 int fgetfilecon_raw(int fd, char ** context)
+#endif
 {
 	char *buf;
 	ssize_t size;
@@ -48,7 +52,7 @@ int fgetfilecon_raw(int fd, char ** context)
 		*context = buf;
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(fgetfilecon_raw)
 
 int fgetfilecon(int fd, char ** context)
@@ -70,3 +74,4 @@ int fgetfilecon(int fd, char ** context)
 
 	return ret;
 }
+#endif
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index 52707d0..159b93b 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -7,6 +7,13 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifdef ANDROID
+int fsetfilecon(int fd, const char *context)
+{
+	return fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
+			 0);
+}
+#else
 int fsetfilecon_raw(int fd, const char * context)
 {
 	int rc = fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + 1,
@@ -41,3 +48,4 @@ int fsetfilecon(int fd, const char *context)
 
 	return ret;
 }
+#endif
diff --git a/libselinux/src/get_initial_context.c b/libselinux/src/get_initial_context.c
index 522ed78..a269f7c 100644
--- a/libselinux/src/get_initial_context.c
+++ b/libselinux/src/get_initial_context.c
@@ -11,7 +11,11 @@
 
 #define SELINUX_INITCON_DIR "/initial_contexts/"
 
+#ifdef ANDROID
+int security_get_initial_context(const char * name, char ** con)
+#else
 int security_get_initial_context_raw(const char * name, char ** con)
+#endif
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -52,7 +56,7 @@ int security_get_initial_context_raw(const char * name, char ** con)
 	close(fd);
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(security_get_initial_context_raw)
 
 int security_get_initial_context(const char * name, char ** con)
@@ -70,3 +74,4 @@ int security_get_initial_context(const char * name, char ** con)
 }
 
 hidden_def(security_get_initial_context)
+#endif
diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
index 5d4d483..06a4301 100644
--- a/libselinux/src/getfilecon.c
+++ b/libselinux/src/getfilecon.c
@@ -7,7 +7,11 @@
 #include <sys/xattr.h>
 #include "policy.h"
 
+#ifdef ANDROID
+int getfilecon(const char *path, char ** context)
+#else
 int getfilecon_raw(const char *path, char ** context)
+#endif
 {
 	char *buf;
 	ssize_t size;
@@ -48,7 +52,7 @@ int getfilecon_raw(const char *path, char ** context)
 		*context = buf;
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(getfilecon_raw)
 
 int getfilecon(const char *path, char ** context)
@@ -71,3 +75,4 @@ int getfilecon(const char *path, char ** context)
 }
 
 hidden_def(getfilecon)
+#endif
diff --git a/libselinux/src/getpeercon.c b/libselinux/src/getpeercon.c
index 3a77a2d..c4d87bd 100644
--- a/libselinux/src/getpeercon.c
+++ b/libselinux/src/getpeercon.c
@@ -11,7 +11,11 @@
 #define SO_PEERSEC 31
 #endif
 
+#ifdef ANDROID
+int getpeercon(int fd, char ** context)
+#else
 int getpeercon_raw(int fd, char ** context)
+#endif
 {
 	char *buf;
 	socklen_t size;
@@ -42,7 +46,7 @@ int getpeercon_raw(int fd, char ** context)
 		*context = buf;
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(getpeercon_raw)
 
 int getpeercon(int fd, char ** context)
@@ -59,3 +63,4 @@ int getpeercon(int fd, char ** context)
 
 	return ret;
 }
+#endif
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 179e0d0..f4ee637 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -7,8 +7,15 @@
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <dlfcn.h>
+
+#ifdef DARWIN
+#include <sys/param.h>
+#include <sys/mount.h>
+#else
 #include <sys/statvfs.h>
 #include <sys/vfs.h>
+#endif
+
 #include <stdint.h>
 #include <limits.h>
 #include <sys/mount.h>
@@ -16,11 +23,13 @@
 #include "dso.h"
 #include "policy.h"
 #include "selinux_internal.h"
+
+#ifndef ANDROID
 #include "setrans_internal.h"
+#endif
 
 char *selinux_mnt = NULL;
 int selinux_page_size = 0;
-int obj_class_compat = 1;
 
 /* Verify the mount point for selinux file system has a selinuxfs.
    If the file system:
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index c3c099e..19bcb04 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -21,12 +21,20 @@ typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
+#ifdef ANDROID
+	NULL,
+	NULL,
+	NULL,
+	&selabel_property_init
+#else
 	&selabel_media_init,
 	&selabel_x_init,
 	&selabel_db_init,
-	&selabel_property_init,
+	NULL
+#endif
 };
 
+#ifndef ANDROID
 static void selabel_subs_fini(struct selabel_sub *ptr)
 {
 	struct selabel_sub *next;
@@ -123,6 +131,7 @@ err:
 	free(sub);
 	goto out;
 }
+#endif
 
 /*
  * Validation functions
@@ -175,10 +184,10 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	memset(rec, 0, sizeof(*rec));
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
-
+#ifndef ANDROID
 	rec->subs = NULL;
 	rec->dist_subs = NULL;
-
+#endif
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
 		rec = NULL;
@@ -188,6 +197,32 @@ out:
 	return rec;
 }
 
+#ifdef ANDROID
+static struct selabel_lookup_rec *selabel_lookup_common
+		      (struct selabel_handle *rec,
+		      const char *key, int type)
+{
+	struct selabel_lookup_rec *lr;
+	lr = rec->func_lookup(rec, key, type); 
+	if (!lr)
+		return NULL;
+
+	return lr;
+}
+
+int selabel_lookup(struct selabel_handle *rec, char **con,
+		   const char *key, int type)
+{
+	struct selabel_lookup_rec *lr;
+
+	lr = selabel_lookup_common(rec, key, type);
+	if (!lr)
+		return -1;
+
+	*con = strdup(lr->ctx_raw);
+	return *con ? 0 : -1;
+}
+#else
 static struct selabel_lookup_rec *
 selabel_lookup_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type)
@@ -242,7 +277,9 @@ int selabel_lookup(struct selabel_handle *rec, char **con,
 	*con = strdup(lr->ctx_trans);
 	return *con ? 0 : -1;
 }
+#endif
 
+#ifndef ANDROID
 int selabel_lookup_raw(struct selabel_handle *rec, char **con,
 		       const char *key, int type)
 {
@@ -255,14 +292,52 @@ int selabel_lookup_raw(struct selabel_handle *rec, char **con,
 	*con = strdup(lr->ctx_raw);
 	return *con ? 0 : -1;
 }
+#endif
+
+#ifdef ANDROID
+bool selabel_partial_match(struct selabel_handle *rec, const char *key)
+{
+	if (!rec->func_partial_match) {
+		/*
+		 * If the label backend does not support partial matching,
+		 * then assume a match is possible.
+		 */
+		return true;
+	}
+	return rec->func_partial_match(rec, key);
+}
+
+int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
+			      const char *key, const char **aliases, int type)
+{
+	struct selabel_lookup_rec *lr;
+
+	if (!rec->func_lookup_best_match) {
+		errno = ENOTSUP;
+		return -1;
+	}
+
+	lr = rec->func_lookup_best_match(rec, key, aliases, type);
+	if (!lr)
+		return -1;
+
+	*con = strdup(lr->ctx_raw);
+	return *con ? 0 : -1;
+}
+#endif
 
 void selabel_close(struct selabel_handle *rec)
 {
+#ifdef ANDROID
+	rec->func_close(rec);
+	free(rec);
+#else
 	selabel_subs_fini(rec->subs);
 	selabel_subs_fini(rec->dist_subs);
 	rec->func_close(rec);
 	free(rec->spec_file);
 	free(rec);
+#endif
 }
 
 void selabel_stats(struct selabel_handle *rec)
diff --git a/libselinux/src/label_android_file.c b/libselinux/src/label_android_file.c
new file mode 100644
index 0000000..3708413
--- /dev/null
+++ b/libselinux/src/label_android_file.c
@@ -0,0 +1,776 @@
+/*
+ * File contexts backend for labeling system
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+
+#include <fcntl.h>
+#include <stdarg.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "callbacks.h"
+#include "label_internal.h"
+#include <pcre.h>
+
+/*
+ * Internals, mostly moved over from matchpathcon.c
+ */
+
+/* A file security context specification. */
+typedef struct spec {
+	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
+	char *regex_str;	/* regular expession string for diagnostics */
+	char *type_str;		/* type string for diagnostic messages */
+	pcre *regex;		/* compiled regular expression */
+	pcre_extra *sd;         /* pcre study result */
+	char regcomp;           /* regex_str has been compiled to regex */
+	mode_t mode;		/* mode format value */
+	int matches;		/* number of matching pathnames */
+	int hasMetaChars;	/* regular expression has meta-chars */
+	int stem_id;		/* indicates which stem-compression item */
+	size_t prefix_len;      /* length of fixed path prefix */
+} spec_t;
+
+/* A regular expression stem */
+typedef struct stem {
+	char *buf;
+	int len;
+} stem_t;
+
+/* Our stored configuration */
+struct saved_data {
+	/*
+	 * The array of specifications, initially in the same order as in 
+	 * the specification file. Sorting occurs based on hasMetaChars.
+	 */
+	spec_t *spec_arr;
+	unsigned int nspec;
+	unsigned int ncomp;
+
+	/*
+	 * The array of regular expression stems.
+	 */
+	stem_t *stem_arr;
+	int num_stems;
+	int alloc_stems;
+};
+
+/* Return the length of the text that can be considered the stem, returns 0
+ * if there is no identifiable stem */
+static int get_stem_from_spec(const char *const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+	const char *ind;
+
+	if (!tmp)
+		return 0;
+
+	for (ind = buf; ind < tmp; ind++) {
+		if (strchr(".^$?*+|[({", (int)*ind))
+			return 0;
+	}
+	return tmp - buf;
+}
+
+/* return the length of the text that is the stem of a file name */
+static int get_stem_from_file_name(const char *const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+
+	if (!tmp)
+		return 0;
+	return tmp - buf;
+}
+
+/* find the stem of a file spec, returns the index into stem_arr for a new
+ * or existing stem, (or -1 if there is no possible stem - IE for a file in
+ * the root directory or a regex that is too complex for us). */
+static int find_stem_from_spec(struct saved_data *data, const char *buf)
+{
+	int i, num = data->num_stems;
+	int stem_len = get_stem_from_spec(buf);
+
+	if (!stem_len)
+		return -1;
+	for (i = 0; i < num; i++) {
+		if (stem_len == data->stem_arr[i].len
+		    && !strncmp(buf, data->stem_arr[i].buf, stem_len))
+			return i;
+	}
+	if (data->alloc_stems == num) {
+		stem_t *tmp_arr;
+		data->alloc_stems = data->alloc_stems * 2 + 16;
+		tmp_arr = (stem_t *) realloc(data->stem_arr,
+				  sizeof(stem_t) * data->alloc_stems);
+		if (!tmp_arr)
+			return -1;
+		data->stem_arr = tmp_arr;
+	}
+	data->stem_arr[num].len = stem_len;
+	data->stem_arr[num].buf = (char *) malloc(stem_len + 1);
+	if (!data->stem_arr[num].buf)
+		return -1;
+	memcpy(data->stem_arr[num].buf, buf, stem_len);
+	data->stem_arr[num].buf[stem_len] = '\0';
+	data->num_stems++;
+	buf += stem_len;
+	return num;
+}
+
+/* find the stem of a file name, returns the index into stem_arr (or -1 if
+ * there is no match - IE for a file in the root directory or a regex that is
+ * too complex for us).  Makes buf point to the text AFTER the stem. */
+static int find_stem_from_file(struct saved_data *data, const char **buf)
+{
+	int i;
+	int stem_len = get_stem_from_file_name(*buf);
+
+	if (!stem_len)
+		return -1;
+	for (i = 0; i < data->num_stems; i++) {
+		if (stem_len == data->stem_arr[i].len
+		    && !strncmp(*buf, data->stem_arr[i].buf, stem_len)) {
+			*buf += stem_len;
+			return i;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Warn about duplicate specifications.
+ */
+static int nodups_specs(struct saved_data *data, const char *path)
+{
+	int rc = 0;
+	unsigned int ii, jj;
+	struct spec *curr_spec, *spec_arr = data->spec_arr;
+
+	for (ii = 0; ii < data->nspec; ii++) {
+		curr_spec = &spec_arr[ii];
+		for (jj = ii + 1; jj < data->nspec; jj++) {
+			if ((!strcmp
+			     (spec_arr[jj].regex_str, curr_spec->regex_str))
+			    && (!spec_arr[jj].mode || !curr_spec->mode
+				|| spec_arr[jj].mode == curr_spec->mode)) {
+				rc = -1;
+				errno = EINVAL;
+				if (strcmp
+				    (spec_arr[jj].lr.ctx_raw,
+				     curr_spec->lr.ctx_raw)) {
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple different specifications for %s  (%s and %s).\n",
+						 path, curr_spec->regex_str,
+						 spec_arr[jj].lr.ctx_raw,
+						 curr_spec->lr.ctx_raw);
+				} else {
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple same specifications for %s.\n",
+						 path, curr_spec->regex_str);
+				}
+			}
+		}
+	}
+	return rc;
+}
+
+/* Determine if the regular expression specification has any meta characters. */
+static void spec_hasMetaChars(struct spec *spec)
+{
+	char *c;
+	size_t len;
+	char *end;
+
+	c = spec->regex_str;
+	len = strlen(spec->regex_str);
+	end = c + len;
+
+	spec->hasMetaChars = 0;
+	spec->prefix_len = len;
+
+	/* Look at each character in the RE specification string for a 
+	 * meta character. Return when any meta character reached. */
+	while (c != end) {
+		switch (*c) {
+		case '.':
+		case '^':
+		case '$':
+		case '?':
+		case '*':
+		case '+':
+		case '|':
+		case '[':
+		case '(':
+		case '{':
+			spec->hasMetaChars = 1;
+			spec->prefix_len = c - spec->regex_str;
+			return;
+		case '\\':	/* skip the next character */
+			c++;
+			break;
+		default:
+			break;
+
+		}
+		c++;
+	}
+	return;
+}
+
+static int compile_regex(struct saved_data *data, spec_t *spec, const char **errbuf)
+{
+	const char *tmperrbuf;
+	char *reg_buf, *anchored_regex, *cp;
+	stem_t *stem_arr = data->stem_arr;
+	size_t len;
+	int erroff;
+
+	if (spec->regcomp)
+		return 0; /* already done */
+
+	data->ncomp++; /* how many compiled regexes required */
+
+	/* Skip the fixed stem. */
+	reg_buf = spec->regex_str;
+	if (spec->stem_id >= 0)
+		reg_buf += stem_arr[spec->stem_id].len;
+
+	/* Anchor the regular expression. */
+	len = strlen(reg_buf);
+	cp = anchored_regex = (char *) malloc(len + 3);
+	if (!anchored_regex)
+		return -1;
+	/* Create ^...$ regexp.  */
+	*cp++ = '^';
+	memcpy(cp, reg_buf, len);
+	cp += len;
+	*cp++ = '$';
+	*cp = '\0';
+
+	/* Compile the regular expression. */
+	spec->regex = pcre_compile(anchored_regex, PCRE_DOTALL, &tmperrbuf, &erroff, NULL);
+	free(anchored_regex);
+	if (!spec->regex) {
+		if (errbuf)
+			*errbuf=tmperrbuf;
+		return -1;
+	}
+
+	spec->sd = pcre_study(spec->regex, 0, &tmperrbuf);
+	if (!spec->sd && tmperrbuf) {
+		if (errbuf)
+			*errbuf=tmperrbuf;
+		return -1;
+	}
+
+	/* Done. */
+	spec->regcomp = 1;
+
+	return 0;
+}
+
+
+static int process_line(struct selabel_handle *rec,
+			const char *path, const char *prefix,
+			char *line_buf, int pass, unsigned lineno)
+{
+	int items, len;
+	char buf1[BUFSIZ], buf2[BUFSIZ], buf3[BUFSIZ];
+	char *buf_p, *regex = buf1, *type = buf2, *context = buf3;
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	unsigned int nspec = data->nspec;
+
+	len = strlen(line_buf);
+	if (line_buf[len - 1] == '\n')
+		line_buf[len - 1] = 0;
+	buf_p = line_buf;
+	while (isspace(*buf_p))
+		buf_p++;
+	/* Skip comment lines and empty lines. */
+	if (*buf_p == '#' || *buf_p == 0)
+		return 0;
+	items = sscanf(line_buf, "%255s %255s %255s", regex, type, context);
+	if (items < 2) {
+		selinux_log(SELINUX_WARNING,
+			    "%s:  line %d is missing fields, skipping\n", path,
+			    lineno);
+		return 0;
+	} else if (items == 2) {
+		/* The type field is optional. */
+		context = type;
+		type = NULL;
+	}
+
+	len = get_stem_from_spec(regex);
+	if (len && prefix && strncmp(prefix, regex, len)) {
+		/* Stem of regex does not match requested prefix, discard. */
+		return 0;
+	}
+
+	if (pass == 1) {
+		/* On the second pass, process and store the specification in spec. */
+		const char *errbuf = NULL;
+		spec_arr[nspec].stem_id = find_stem_from_spec(data, regex);
+		spec_arr[nspec].regex_str = strdup(regex);
+		if (!spec_arr[nspec].regex_str) {
+			selinux_log(SELINUX_WARNING,
+				   "%s:  out of memory at line %d on regex %s\n",
+				   path, lineno, regex);
+			return -1;
+
+		}
+		if (rec->validating && compile_regex(data, &spec_arr[nspec], &errbuf)) {
+			selinux_log(SELINUX_WARNING,
+				   "%s:  line %d has invalid regex %s:  %s\n",
+				   path, lineno, regex,
+				   (errbuf ? errbuf : "out of memory"));
+		}
+
+		/* Convert the type string to a mode format */
+		spec_arr[nspec].mode = 0;
+		if (!type)
+			goto skip_type;
+		spec_arr[nspec].type_str = strdup(type);
+		len = strlen(type);
+		if (type[0] != '-' || len != 2) {
+			selinux_log(SELINUX_WARNING,
+				    "%s:  line %d has invalid file type %s\n",
+				    path, lineno, type);
+			return 0;
+		}
+		switch (type[1]) {
+		case 'b':
+			spec_arr[nspec].mode = S_IFBLK;
+			break;
+		case 'c':
+			spec_arr[nspec].mode = S_IFCHR;
+			break;
+		case 'd':
+			spec_arr[nspec].mode = S_IFDIR;
+			break;
+		case 'p':
+			spec_arr[nspec].mode = S_IFIFO;
+			break;
+		case 'l':
+			spec_arr[nspec].mode = S_IFLNK;
+			break;
+		case 's':
+			spec_arr[nspec].mode = S_IFSOCK;
+			break;
+		case '-':
+			spec_arr[nspec].mode = S_IFREG;
+			break;
+		default:
+			selinux_log(SELINUX_WARNING,
+				    "%s:  line %d has invalid file type %s\n",
+				    path, lineno, type);
+			return 0;
+		}
+
+	skip_type:
+		spec_arr[nspec].lr.ctx_raw = strdup(context);
+
+		if (strcmp(context, "<<none>>") && rec->validating) {
+			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
+				selinux_log(SELINUX_WARNING,
+					    "%s:  line %d has invalid context %s\n",
+					    path, lineno, spec_arr[nspec].lr.ctx_raw);
+			}
+		}
+
+		/* Determine if specification has 
+		 * any meta characters in the RE */
+		spec_hasMetaChars(&spec_arr[nspec]);
+	}
+
+	data->nspec = ++nspec;
+	return 0;
+}
+
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
+		unsigned n)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	const char *path = NULL;
+	const char *prefix = NULL;
+	FILE *fp;
+	FILE *localfp = NULL;
+	FILE *homedirfp = NULL;
+	char local_path[PATH_MAX + 1];
+	char homedir_path[PATH_MAX + 1];
+	char line_buf[BUFSIZ];
+	unsigned int lineno, pass, i, j, maxnspec;
+	spec_t *spec_copy = NULL;
+	int status = -1, baseonly = 0;
+	struct stat sb;
+
+	/* Process arguments */
+	while (n--)
+		switch(opts[n].type) {
+		case SELABEL_OPT_PATH:
+			path = opts[n].value;
+			break;
+		case SELABEL_OPT_SUBSET:
+			prefix = opts[n].value;
+			break;
+		case SELABEL_OPT_BASEONLY:
+			baseonly = !!opts[n].value;
+			break;
+		}
+
+	/* Open the specification file. */
+	if ((fp = fopen(path, "r")) == NULL)
+		return -1;
+
+	if (fstat(fileno(fp), &sb) < 0)
+		return -1;
+	if (!S_ISREG(sb.st_mode)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (!baseonly) {
+		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs",
+			 path);
+		homedirfp = fopen(homedir_path, "r");
+
+		snprintf(local_path, sizeof(local_path), "%s.local", path);
+		localfp = fopen(local_path, "r");
+	}
+
+	/* 
+	 * Perform two passes over the specification file.
+	 * The first pass counts the number of specifications and
+	 * performs simple validation of the input.  At the end
+	 * of the first pass, the spec array is allocated.
+	 * The second pass performs detailed validation of the input
+	 * and fills in the spec array.
+	 */
+	maxnspec = UINT_MAX / sizeof(spec_t);
+	for (pass = 0; pass < 2; pass++) {
+		lineno = 0;
+		data->nspec = 0;
+		data->ncomp = 0;
+		while (fgets(line_buf, sizeof line_buf - 1, fp)
+		       && data->nspec < maxnspec) {
+			if (process_line(rec, path, prefix, line_buf,
+					 pass, ++lineno) != 0)
+				goto finish;
+		}
+		if (pass == 1) {
+			status = nodups_specs(data, path);
+			if (status)
+				goto finish;
+		}
+		lineno = 0;
+		if (homedirfp)
+			while (fgets(line_buf, sizeof line_buf - 1, homedirfp)
+			       && data->nspec < maxnspec) {
+				if (process_line
+				    (rec, homedir_path, prefix,
+				     line_buf, pass, ++lineno) != 0)
+					goto finish;
+			}
+
+		lineno = 0;
+		if (localfp)
+			while (fgets(line_buf, sizeof line_buf - 1, localfp)
+			       && data->nspec < maxnspec) {
+				if (process_line
+				    (rec, local_path, prefix, line_buf,
+				     pass, ++lineno) != 0)
+					goto finish;
+			}
+
+		if (pass == 0) {
+			if (data->nspec == 0) {
+				status = 0;
+				goto finish;
+			}
+			if (NULL == (data->spec_arr =
+				     (spec_t *) malloc(sizeof(spec_t) * data->nspec)))
+				goto finish;
+			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
+			maxnspec = data->nspec;
+			rewind(fp);
+			if (homedirfp)
+				rewind(homedirfp);
+			if (localfp)
+				rewind(localfp);
+		}
+	}
+
+	/* Move exact pathname specifications to the end. */
+	spec_copy = (spec_t *) malloc(sizeof(spec_t) * data->nspec);
+	if (!spec_copy)
+		goto finish;
+	j = 0;
+	for (i = 0; i < data->nspec; i++)
+		if (data->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++],
+			       &data->spec_arr[i], sizeof(spec_t));
+	for (i = 0; i < data->nspec; i++)
+		if (!data->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++],
+			       &data->spec_arr[i], sizeof(spec_t));
+	free(data->spec_arr);
+	data->spec_arr = spec_copy;
+
+	status = 0;
+finish:
+	fclose(fp);
+	if (data->spec_arr != spec_copy)
+		free(data->spec_arr);
+	if (homedirfp)
+		fclose(homedirfp);
+	if (localfp)
+		fclose(localfp);
+	return status;
+}
+
+/*
+ * Backend interface routines
+ */
+static void closef(struct selabel_handle *rec)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	struct spec *spec;
+	struct stem *stem;
+	unsigned int i;
+
+	for (i = 0; i < data->nspec; i++) {
+		spec = &data->spec_arr[i];
+		free(spec->regex_str);
+		free(spec->type_str);
+		free(spec->lr.ctx_raw);
+		free(spec->lr.ctx_trans);
+		if (spec->regcomp) {
+			pcre_free(spec->regex);
+			pcre_free_study(spec->sd);
+		}
+	}
+
+	for (i = 0; i < (unsigned int)data->num_stems; i++) {
+		stem = &data->stem_arr[i];
+		free(stem->buf);
+	}
+
+	if (data->spec_arr)
+		free(data->spec_arr);
+	if (data->stem_arr)
+		free(data->stem_arr);
+	
+	free(data);
+}
+
+static spec_t *lookup_common(struct selabel_handle *rec,
+			     const char *key,
+			     int type,
+			     bool partial)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	int i, rc, file_stem, pcre_options = 0;
+	mode_t mode = (mode_t)type;
+	const char *buf;
+	spec_t *ret = NULL;
+	char *clean_key = NULL;
+	const char *prev_slash, *next_slash;
+	unsigned int sofar = 0;
+
+	if (!data->nspec) {
+		errno = ENOENT;
+		goto finish;
+	}
+
+	/* Remove duplicate slashes */
+	if ((next_slash = strstr(key, "//"))) {
+		clean_key = (char *) malloc(strlen(key) + 1);
+		if (!clean_key)
+			goto finish;
+		prev_slash = key;
+		while (next_slash) {
+			memcpy(clean_key + sofar, prev_slash, next_slash - prev_slash);
+			sofar += next_slash - prev_slash;
+			prev_slash = next_slash + 1;
+			next_slash = strstr(prev_slash, "//");
+		}
+		strcpy(clean_key + sofar, prev_slash);
+		key = clean_key;
+	}
+
+	buf = key;
+	file_stem = find_stem_from_file(data, &buf);
+	mode &= S_IFMT;
+
+	if (partial)
+		pcre_options |= PCRE_PARTIAL_SOFT;
+
+	/* 
+	 * Check for matching specifications in reverse order, so that
+	 * the last matching specification is used.
+	 */
+	for (i = data->nspec - 1; i >= 0; i--) {
+		/* if the spec in question matches no stem or has the same
+		 * stem as the file AND if the spec in question has no mode
+		 * specified or if the mode matches the file mode then we do
+		 * a regex check        */
+		if ((spec_arr[i].stem_id == -1
+		     || spec_arr[i].stem_id == file_stem)
+		    && (!mode || !spec_arr[i].mode
+			|| mode == spec_arr[i].mode)) {
+			if (compile_regex(data, &spec_arr[i], NULL) < 0)
+				goto finish;
+			if (spec_arr[i].stem_id == -1)
+				rc = pcre_exec(spec_arr[i].regex, spec_arr[i].sd, key, strlen(key), 0, pcre_options, NULL, 0);
+			else
+				rc = pcre_exec(spec_arr[i].regex, spec_arr[i].sd, buf, strlen(buf), 0, pcre_options, NULL, 0);
+
+			if (rc == 0) {
+				spec_arr[i].matches++;
+				break;
+			} else if (partial && rc == PCRE_ERROR_PARTIAL)
+				break;
+
+			if (rc == PCRE_ERROR_NOMATCH)
+				continue;
+			/* else it's an error */
+			goto finish;
+		}
+	}
+
+	if (i < 0 || strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
+		/* No matching specification. */
+		errno = ENOENT;
+		goto finish;
+	}
+
+	ret = &spec_arr[i];
+
+finish:
+	free(clean_key);
+	return ret;
+}
+
+static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
+					 const char *key, int type)
+{
+	spec_t *spec;
+	spec = lookup_common(rec, key, type, false);
+	if (spec)
+		return &spec->lr;
+	return NULL;
+}
+
+static bool partial_match(struct selabel_handle *rec, const char *key)
+{
+	return lookup_common(rec, key, 0, true) ? true : false;
+}
+
+static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
+						    const char *key,
+						    const char **aliases,
+						    int type)
+{
+	size_t n, i;
+	int best = -1;
+	spec_t **specs;
+	size_t prefix_len = 0;
+	struct selabel_lookup_rec *lr = NULL;
+
+	if (!aliases || !aliases[0])
+		return lookup(rec, key, type);
+
+	for (n = 0; aliases[n]; n++)
+		;
+
+	specs = calloc(n+1, sizeof(spec_t *));
+	if (!specs)
+		return NULL;
+	specs[0] = lookup_common(rec, key, type, false);
+	if (specs[0]) {
+		if (!specs[0]->hasMetaChars) {
+			/* exact match on key */
+			lr = &specs[0]->lr;
+			goto out;
+		}
+		best = 0;
+		prefix_len = specs[0]->prefix_len;
+	}
+	for (i = 1; i <= n; i++) {
+		specs[i] = lookup_common(rec, aliases[i-1], type, false);
+		if (specs[i]) {
+			if (!specs[i]->hasMetaChars) {
+				/* exact match on alias */
+				lr = &specs[i]->lr;
+				goto out;
+			}
+			if (specs[i]->prefix_len > prefix_len) {
+				best = i;
+				prefix_len = specs[i]->prefix_len;
+			}
+		}
+	}
+
+	if (best >= 0) {
+		/* longest fixed prefix match on key or alias */
+		lr = &specs[best]->lr;
+	}
+
+out:
+	free(specs);
+	return lr;
+}
+
+static void stats(struct selabel_handle *rec)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	unsigned int i, nspec = data->nspec;
+	spec_t *spec_arr = data->spec_arr;
+
+	for (i = 0; i < nspec; i++) {
+		if (spec_arr[i].matches == 0) {
+			if (spec_arr[i].type_str) {
+				selinux_log(SELINUX_WARNING,
+				    "Warning!  No matches for (%s, %s, %s)\n",
+				    spec_arr[i].regex_str,
+				    spec_arr[i].type_str,
+				    spec_arr[i].lr.ctx_raw);
+			} else {
+				selinux_log(SELINUX_WARNING,
+				    "Warning!  No matches for (%s, %s)\n",
+				    spec_arr[i].regex_str,
+				    spec_arr[i].lr.ctx_raw);
+			}
+		}
+	}
+}
+
+int selabel_file_init(struct selabel_handle *rec, struct selinux_opt *opts,
+		      unsigned nopts)
+{
+	struct saved_data *data;
+
+	data = (struct saved_data *)malloc(sizeof(*data));
+	if (!data)
+		return -1;
+	memset(data, 0, sizeof(*data));
+
+	rec->data = data;
+	rec->func_close = &closef;
+	rec->func_stats = &stats;
+	rec->func_lookup = &lookup;
+	rec->func_partial_match = &partial_match;
+	rec->func_lookup_best_match = &lookup_best_match;
+
+	return init(rec, opts, nopts);
+}
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index a1fa4fd..c43e48b 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -57,7 +57,13 @@ struct selabel_handle {
 						   const char *key, int type);
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
-
+#ifdef ANDROID
+	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
+	struct selabel_lookup_rec *(*func_lookup_best_match) (struct selabel_handle *h,
+							 const char *key,
+							 const char **aliases,
+							 int type);
+#endif
 	/* supports backend-specific state information */
 	void *data;
 
@@ -79,6 +85,9 @@ extern int
 selabel_validate(struct selabel_handle *rec,
 		 struct selabel_lookup_rec *contexts) hidden;
 
+#ifdef ANDROID
+#define COMPAT_LOG(type, fmt...) selinux_log(type, fmt);
+#else
 /*
  * Compatibility support
  */
@@ -95,5 +104,6 @@ extern int
 compat_validate(struct selabel_handle *rec,
 		struct selabel_lookup_rec *contexts,
 		const char *path, unsigned lineno) hidden;
+#endif /* ANDROID */
 
 #endif				/* _SELABEL_INTERNAL_H_ */
diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
index 478e0c6..957d216 100644
--- a/libselinux/src/lgetfilecon.c
+++ b/libselinux/src/lgetfilecon.c
@@ -7,7 +7,11 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifdef ANDROID
+int lgetfilecon(const char *path, char ** context)
+#else
 int lgetfilecon_raw(const char *path, char ** context)
+#endif
 {
 	char *buf;
 	ssize_t size;
@@ -48,7 +52,7 @@ int lgetfilecon_raw(const char *path, char ** context)
 		*context = buf;
 	return ret;
 }
-
+#ifndef ANDROID
 hidden_def(lgetfilecon_raw)
 
 int lgetfilecon(const char *path, char ** context)
@@ -69,3 +73,4 @@ int lgetfilecon(const char *path, char ** context)
 		return strlen(*context) + 1;
 	return ret;
 }
+#endif
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 21ee58b..b9cf21a 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -11,8 +11,10 @@
 #include <string.h>
 #include <errno.h>
 #include "selinux_internal.h"
+#ifndef ANDROID
 #include <sepol/sepol.h>
 #include <sepol/policydb.h>
+#endif
 #include <dlfcn.h>
 #include "policy.h"
 #include <limits.h>
@@ -41,6 +43,7 @@ int security_load_policy(void *data, size_t len)
 
 hidden_def(security_load_policy)
 
+#ifndef ANDROID
 int load_setlocaldefs hidden = 1;
 
 #undef max
@@ -460,3 +463,4 @@ int selinux_init_load_policy(int *enforce)
 	 */
 	return -1;
 }
+#endif /* Not an ANDROID build */
diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon.c
index 1d3b28a..8e472e7 100644
--- a/libselinux/src/lsetfilecon.c
+++ b/libselinux/src/lsetfilecon.c
@@ -7,6 +7,13 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifdef ANDROID
+int lsetfilecon(const char *path, const char *context)
+{
+	return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
+			 0);
+}
+#else
 int lsetfilecon_raw(const char *path, const char * context)
 {
 	int rc = lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
@@ -41,3 +48,4 @@ int lsetfilecon(const char *path, const char *context)
 
 	return ret;
 }
+#endif
diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
index bf270b5..2fd18f2 100644
--- a/libselinux/src/policy.h
+++ b/libselinux/src/policy.h
@@ -9,7 +9,7 @@
 /* Initial length guess for getting contexts. */
 #define INITCONTEXTLEN 255
 
-/* selinux file system type */
+/* selinux file system type string */
 #define SELINUXFS "selinuxfs"
 
 /* selinuxfs magic number */
@@ -22,7 +22,9 @@
 /* selinuxfs mount point */
 extern char *selinux_mnt;
 
+#ifndef ANDROID
 #define FILECONTEXTS "/etc/security/selinux/file_contexts"
+#endif
 
 #define DEFAULT_POLICY_VERSION 15
 
diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index f990350..437e9eb 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -9,6 +9,7 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifndef ANDROID
 #define UNSET (char *) -1
 
 static __thread pid_t cpid;
@@ -32,12 +33,16 @@ static int __selinux_atfork (void (*prepare) (void), void (*parent) (void), void
   return __register_atfork (prepare, parent, child,
                             &__dso_handle == NULL ? NULL : __dso_handle);
 }
+#endif
 
+#if defined(HOST) && defined(ANDROID) || !defined(ANDROID)
 static pid_t gettid(void)
 {
 	return syscall(__NR_gettid);
 }
+#endif
 
+#ifndef ANDROID
 static void procattr_thread_destructor(void __attribute__((unused)) *unused)
 {
 	if (prev_current != UNSET)
@@ -83,15 +88,18 @@ static void init_procattr(void)
 		destructor_key_initialized = 1;
 	}
 }
+#endif
 
 static int openattr(pid_t pid, const char *attr, int flags)
 {
 	int fd, rc;
 	char *path;
-
+#ifdef ANDROID
+	pid_t tid = gettid();
+#else
 	if (cpid != getpid())
 		free_procattr();
-
+#endif
 	if (pid > 0)
 		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
 	else {
@@ -107,8 +115,13 @@ static int openattr(pid_t pid, const char *attr, int flags)
 	return fd;
 }
 
+#ifdef ANDROID
+static int getprocattrcon(char ** context,
+			      pid_t pid, const char *attr)
+#else
 static int getprocattrcon_raw(char ** context,
 			      pid_t pid, const char *attr)
+#endif
 {
 	char *buf;
 	size_t size;
@@ -116,7 +129,7 @@ static int getprocattrcon_raw(char ** context,
 	ssize_t ret;
 	int errno_hold;
 	char * prev_context;
-
+#ifndef ANDROID
 	__selinux_once(once, init_procattr);
 	init_thread_destructor();
 
@@ -154,7 +167,7 @@ static int getprocattrcon_raw(char ** context,
 		}
 		return 0;
 	}
-
+#endif
 	fd = openattr(pid, attr, O_RDONLY);
 	if (fd < 0)
 		return -1;
@@ -193,6 +206,7 @@ static int getprocattrcon_raw(char ** context,
 	return ret;
 }
 
+#ifndef ANDROID
 static int getprocattrcon(char ** context,
 			  pid_t pid, const char *attr)
 {
@@ -208,13 +222,20 @@ static int getprocattrcon(char ** context,
 
 	return ret;
 }
+#endif
 
+#ifdef ANDROID
+static int setprocattrcon(const char * context,
+			      pid_t pid, const char *attr)
+#else
 static int setprocattrcon_raw(const char * context,
 			      pid_t pid, const char *attr)
+#endif
 {
 	int fd;
 	ssize_t ret;
 	int errno_hold;
+#ifndef ANDROID
 	char **prev_context, *context2 = NULL;
 
 	__selinux_once(once, init_procattr);
@@ -249,17 +270,23 @@ static int setprocattrcon_raw(const char * context,
 	if (context && *prev_context && *prev_context != UNSET
 	    && !strcmp(context, *prev_context))
 		return 0;
-
+#endif
 	fd = openattr(pid, attr, O_RDWR);
 	if (fd < 0)
 		return -1;
 	if (context) {
+#ifndef ANDROID
 		ret = -1;
 		context2 = strdup(context);
 		if (!context2)
 			goto out;
+#endif
 		do {
+#ifdef ANDROID
+			ret = write(fd, context, strlen(context) + 1);
+#else
 			ret = write(fd, context2, strlen(context2) + 1);
+#endif
 		} while (ret < 0 && errno == EINTR);
 	} else {
 		do {
@@ -270,6 +297,12 @@ out:
 	errno_hold = errno;
 	close(fd);
 	errno = errno_hold;
+#ifdef ANDROID
+	if (ret < 0)
+		return -1;
+	else
+		return 0;
+#else
 	if (ret < 0) {
 		free(context2);
 		return -1;
@@ -279,8 +312,10 @@ out:
 		*prev_context = context2;
 		return 0;
 	}
+#endif
 }
 
+#ifndef ANDROID
 static int setprocattrcon(const char * context,
 			  pid_t pid, const char *attr)
 {
@@ -296,7 +331,31 @@ static int setprocattrcon(const char * context,
 
 	return ret;
 }
+#endif
 
+#ifdef ANDROID
+#define getselfattr_def(fn, attr) \
+	int get##fn(char **c) \
+	{ \
+		return getprocattrcon(c, 0, #attr); \
+	}
+
+#define setselfattr_def(fn, attr) \
+	int set##fn(const char * c) \
+	{ \
+		return setprocattrcon(c, 0, #attr); \
+	}
+
+#define all_selfattr_def(fn, attr) \
+	getselfattr_def(fn, attr)	 \
+	setselfattr_def(fn, attr)
+
+#define getpidattr_def(fn, attr) \
+	int get##fn(pid_t pid, char **c)	\
+	{ \
+		return getprocattrcon(c, pid, #attr); \
+	}
+#else
 #define getselfattr_def(fn, attr) \
 	int get##fn##_raw(char **c) \
 	{ \
@@ -330,6 +389,7 @@ static int setprocattrcon(const char * context,
 	{ \
 		return getprocattrcon(c, pid, #attr); \
 	}
+#endif
 
 all_selfattr_def(con, current)
     getpidattr_def(pidcon, current)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index afb2170..ef047e2 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -101,8 +101,10 @@ hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 hidden_proto(selinux_reset_config);
 
+#ifndef ANDROID
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
+#endif
 extern int selinux_page_size hidden;
 
 /* Make pthread_once optional */
diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c
index d05969c..b36f50d 100644
--- a/libselinux/src/setfilecon.c
+++ b/libselinux/src/setfilecon.c
@@ -7,6 +7,13 @@
 #include "selinux_internal.h"
 #include "policy.h"
 
+#ifdef ANDROID
+int setfilecon(const char *path, const char *context)
+{
+	return setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
+			0);
+}
+#else
 int setfilecon_raw(const char *path, const char * context)
 {
 	int rc = setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) + 1,
@@ -41,3 +48,4 @@ int setfilecon(const char *path, const char *context)
 
 	return ret;
 }
+#endif
diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index 9ae8248..00aecdc 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -298,6 +298,7 @@ out:
 	return rc;
 }
 
+#ifndef ANDROID
 void print_access_vector(security_class_t tclass, access_vector_t av)
 {
 	const char *permstr;
@@ -325,3 +326,4 @@ void print_access_vector(security_class_t tclass, access_vector_t av)
 		printf(" 0x%x", av);
 	printf(" }");
 }
+#endif
diff --git a/libsepol/MODULE_LICENSE_LGPL b/libsepol/MODULE_LICENSE_LGPL
new file mode 100644
index 0000000..e69de29
diff --git a/libsepol/NOTICE b/libsepol/NOTICE
new file mode 100644
index 0000000..8add30a
--- /dev/null
+++ b/libsepol/NOTICE
@@ -0,0 +1,504 @@
+		  GNU LESSER GENERAL PUBLIC LICENSE
+		       Version 2.1, February 1999
+
+ Copyright (C) 1991, 1999 Free Software Foundation, Inc.
+     51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+[This is the first released version of the Lesser GPL.  It also counts
+ as the successor of the GNU Library Public License, version 2, hence
+ the version number 2.1.]
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+Licenses are intended to guarantee your freedom to share and change
+free software--to make sure the software is free for all its users.
+
+  This license, the Lesser General Public License, applies to some
+specially designated software packages--typically libraries--of the
+Free Software Foundation and other authors who decide to use it.  You
+can use it too, but we suggest you first think carefully about whether
+this license or the ordinary General Public License is the better
+strategy to use in any particular case, based on the explanations below.
+
+  When we speak of free software, we are referring to freedom of use,
+not price.  Our General Public Licenses are designed to make sure that
+you have the freedom to distribute copies of free software (and charge
+for this service if you wish); that you receive source code or can get
+it if you want it; that you can change the software and use pieces of
+it in new free programs; and that you are informed that you can do
+these things.
+
+  To protect your rights, we need to make restrictions that forbid
+distributors to deny you these rights or to ask you to surrender these
+rights.  These restrictions translate to certain responsibilities for
+you if you distribute copies of the library or if you modify it.
+
+  For example, if you distribute copies of the library, whether gratis
+or for a fee, you must give the recipients all the rights that we gave
+you.  You must make sure that they, too, receive or can get the source
+code.  If you link other code with the library, you must provide
+complete object files to the recipients, so that they can relink them
+with the library after making changes to the library and recompiling
+it.  And you must show them these terms so they know their rights.
+
+  We protect your rights with a two-step method: (1) we copyright the
+library, and (2) we offer you this license, which gives you legal
+permission to copy, distribute and/or modify the library.
+
+  To protect each distributor, we want to make it very clear that
+there is no warranty for the free library.  Also, if the library is
+modified by someone else and passed on, the recipients should know
+that what they have is not the original version, so that the original
+author's reputation will not be affected by problems that might be
+introduced by others.
+
+  Finally, software patents pose a constant threat to the existence of
+any free program.  We wish to make sure that a company cannot
+effectively restrict the users of a free program by obtaining a
+restrictive license from a patent holder.  Therefore, we insist that
+any patent license obtained for a version of the library must be
+consistent with the full freedom of use specified in this license.
+
+  Most GNU software, including some libraries, is covered by the
+ordinary GNU General Public License.  This license, the GNU Lesser
+General Public License, applies to certain designated libraries, and
+is quite different from the ordinary General Public License.  We use
+this license for certain libraries in order to permit linking those
+libraries into non-free programs.
+
+  When a program is linked with a library, whether statically or using
+a shared library, the combination of the two is legally speaking a
+combined work, a derivative of the original library.  The ordinary
+General Public License therefore permits such linking only if the
+entire combination fits its criteria of freedom.  The Lesser General
+Public License permits more lax criteria for linking other code with
+the library.
+
+  We call this license the "Lesser" General Public License because it
+does Less to protect the user's freedom than the ordinary General
+Public License.  It also provides other free software developers Less
+of an advantage over competing non-free programs.  These disadvantages
+are the reason we use the ordinary General Public License for many
+libraries.  However, the Lesser license provides advantages in certain
+special circumstances.
+
+  For example, on rare occasions, there may be a special need to
+encourage the widest possible use of a certain library, so that it becomes
+a de-facto standard.  To achieve this, non-free programs must be
+allowed to use the library.  A more frequent case is that a free
+library does the same job as widely used non-free libraries.  In this
+case, there is little to gain by limiting the free library to free
+software only, so we use the Lesser General Public License.
+
+  In other cases, permission to use a particular library in non-free
+programs enables a greater number of people to use a large body of
+free software.  For example, permission to use the GNU C Library in
+non-free programs enables many more people to use the whole GNU
+operating system, as well as its variant, the GNU/Linux operating
+system.
+
+  Although the Lesser General Public License is Less protective of the
+users' freedom, it does ensure that the user of a program that is
+linked with the Library has the freedom and the wherewithal to run
+that program using a modified version of the Library.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.  Pay close attention to the difference between a
+"work based on the library" and a "work that uses the library".  The
+former contains code derived from the library, whereas the latter must
+be combined with the library in order to run.
+
+		  GNU LESSER GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License Agreement applies to any software library or other
+program which contains a notice placed by the copyright holder or
+other authorized party saying it may be distributed under the terms of
+this Lesser General Public License (also called "this License").
+Each licensee is addressed as "you".
+
+  A "library" means a collection of software functions and/or data
+prepared so as to be conveniently linked with application programs
+(which use some of those functions and data) to form executables.
+
+  The "Library", below, refers to any such software library or work
+which has been distributed under these terms.  A "work based on the
+Library" means either the Library or any derivative work under
+copyright law: that is to say, a work containing the Library or a
+portion of it, either verbatim or with modifications and/or translated
+straightforwardly into another language.  (Hereinafter, translation is
+included without limitation in the term "modification".)
+
+  "Source code" for a work means the preferred form of the work for
+making modifications to it.  For a library, complete source code means
+all the source code for all modules it contains, plus any associated
+interface definition files, plus the scripts used to control compilation
+and installation of the library.
+
+  Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running a program using the Library is not restricted, and output from
+such a program is covered only if its contents constitute a work based
+on the Library (independent of the use of the Library in a tool for
+writing it).  Whether that is true depends on what the Library does
+and what the program that uses the Library does.
+  
+  1. You may copy and distribute verbatim copies of the Library's
+complete source code as you receive it, in any medium, provided that
+you conspicuously and appropriately publish on each copy an
+appropriate copyright notice and disclaimer of warranty; keep intact
+all the notices that refer to this License and to the absence of any
+warranty; and distribute a copy of this License along with the
+Library.
+
+  You may charge a fee for the physical act of transferring a copy,
+and you may at your option offer warranty protection in exchange for a
+fee.
+
+  2. You may modify your copy or copies of the Library or any portion
+of it, thus forming a work based on the Library, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) The modified work must itself be a software library.
+
+    b) You must cause the files modified to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    c) You must cause the whole of the work to be licensed at no
+    charge to all third parties under the terms of this License.
+
+    d) If a facility in the modified Library refers to a function or a
+    table of data to be supplied by an application program that uses
+    the facility, other than as an argument passed when the facility
+    is invoked, then you must make a good faith effort to ensure that,
+    in the event an application does not supply such function or
+    table, the facility still operates, and performs whatever part of
+    its purpose remains meaningful.
+
+    (For example, a function in a library to compute square roots has
+    a purpose that is entirely well-defined independent of the
+    application.  Therefore, Subsection 2d requires that any
+    application-supplied function or table used by this function must
+    be optional: if the application does not supply it, the square
+    root function must still compute square roots.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Library,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Library, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote
+it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Library.
+
+In addition, mere aggregation of another work not based on the Library
+with the Library (or with a work based on the Library) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may opt to apply the terms of the ordinary GNU General Public
+License instead of this License to a given copy of the Library.  To do
+this, you must alter all the notices that refer to this License, so
+that they refer to the ordinary GNU General Public License, version 2,
+instead of to this License.  (If a newer version than version 2 of the
+ordinary GNU General Public License has appeared, then you can specify
+that version instead if you wish.)  Do not make any other change in
+these notices.
+
+  Once this change is made in a given copy, it is irreversible for
+that copy, so the ordinary GNU General Public License applies to all
+subsequent copies and derivative works made from that copy.
+
+  This option is useful when you wish to copy part of the code of
+the Library into a program that is not a library.
+
+  4. You may copy and distribute the Library (or a portion or
+derivative of it, under Section 2) in object code or executable form
+under the terms of Sections 1 and 2 above provided that you accompany
+it with the complete corresponding machine-readable source code, which
+must be distributed under the terms of Sections 1 and 2 above on a
+medium customarily used for software interchange.
+
+  If distribution of object code is made by offering access to copy
+from a designated place, then offering equivalent access to copy the
+source code from the same place satisfies the requirement to
+distribute the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  5. A program that contains no derivative of any portion of the
+Library, but is designed to work with the Library by being compiled or
+linked with it, is called a "work that uses the Library".  Such a
+work, in isolation, is not a derivative work of the Library, and
+therefore falls outside the scope of this License.
+
+  However, linking a "work that uses the Library" with the Library
+creates an executable that is a derivative of the Library (because it
+contains portions of the Library), rather than a "work that uses the
+library".  The executable is therefore covered by this License.
+Section 6 states terms for distribution of such executables.
+
+  When a "work that uses the Library" uses material from a header file
+that is part of the Library, the object code for the work may be a
+derivative work of the Library even though the source code is not.
+Whether this is true is especially significant if the work can be
+linked without the Library, or if the work is itself a library.  The
+threshold for this to be true is not precisely defined by law.
+
+  If such an object file uses only numerical parameters, data
+structure layouts and accessors, and small macros and small inline
+functions (ten lines or less in length), then the use of the object
+file is unrestricted, regardless of whether it is legally a derivative
+work.  (Executables containing this object code plus portions of the
+Library will still fall under Section 6.)
+
+  Otherwise, if the work is a derivative of the Library, you may
+distribute the object code for the work under the terms of Section 6.
+Any executables containing that work also fall under Section 6,
+whether or not they are linked directly with the Library itself.
+
+  6. As an exception to the Sections above, you may also combine or
+link a "work that uses the Library" with the Library to produce a
+work containing portions of the Library, and distribute that work
+under terms of your choice, provided that the terms permit
+modification of the work for the customer's own use and reverse
+engineering for debugging such modifications.
+
+  You must give prominent notice with each copy of the work that the
+Library is used in it and that the Library and its use are covered by
+this License.  You must supply a copy of this License.  If the work
+during execution displays copyright notices, you must include the
+copyright notice for the Library among them, as well as a reference
+directing the user to the copy of this License.  Also, you must do one
+of these things:
+
+    a) Accompany the work with the complete corresponding
+    machine-readable source code for the Library including whatever
+    changes were used in the work (which must be distributed under
+    Sections 1 and 2 above); and, if the work is an executable linked
+    with the Library, with the complete machine-readable "work that
+    uses the Library", as object code and/or source code, so that the
+    user can modify the Library and then relink to produce a modified
+    executable containing the modified Library.  (It is understood
+    that the user who changes the contents of definitions files in the
+    Library will not necessarily be able to recompile the application
+    to use the modified definitions.)
+
+    b) Use a suitable shared library mechanism for linking with the
+    Library.  A suitable mechanism is one that (1) uses at run time a
+    copy of the library already present on the user's computer system,
+    rather than copying library functions into the executable, and (2)
+    will operate properly with a modified version of the library, if
+    the user installs one, as long as the modified version is
+    interface-compatible with the version that the work was made with.
+
+    c) Accompany the work with a written offer, valid for at
+    least three years, to give the same user the materials
+    specified in Subsection 6a, above, for a charge no more
+    than the cost of performing this distribution.
+
+    d) If distribution of the work is made by offering access to copy
+    from a designated place, offer equivalent access to copy the above
+    specified materials from the same place.
+
+    e) Verify that the user has already received a copy of these
+    materials or that you have already sent this user a copy.
+
+  For an executable, the required form of the "work that uses the
+Library" must include any data and utility programs needed for
+reproducing the executable from it.  However, as a special exception,
+the materials to be distributed need not include anything that is
+normally distributed (in either source or binary form) with the major
+components (compiler, kernel, and so on) of the operating system on
+which the executable runs, unless that component itself accompanies
+the executable.
+
+  It may happen that this requirement contradicts the license
+restrictions of other proprietary libraries that do not normally
+accompany the operating system.  Such a contradiction means you cannot
+use both them and the Library together in an executable that you
+distribute.
+
+  7. You may place library facilities that are a work based on the
+Library side-by-side in a single library together with other library
+facilities not covered by this License, and distribute such a combined
+library, provided that the separate distribution of the work based on
+the Library and of the other library facilities is otherwise
+permitted, and provided that you do these two things:
+
+    a) Accompany the combined library with a copy of the same work
+    based on the Library, uncombined with any other library
+    facilities.  This must be distributed under the terms of the
+    Sections above.
+
+    b) Give prominent notice with the combined library of the fact
+    that part of it is a work based on the Library, and explaining
+    where to find the accompanying uncombined form of the same work.
+
+  8. You may not copy, modify, sublicense, link with, or distribute
+the Library except as expressly provided under this License.  Any
+attempt otherwise to copy, modify, sublicense, link with, or
+distribute the Library is void, and will automatically terminate your
+rights under this License.  However, parties who have received copies,
+or rights, from you under this License will not have their licenses
+terminated so long as such parties remain in full compliance.
+
+  9. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Library or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Library (or any work based on the
+Library), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Library or works based on it.
+
+  10. Each time you redistribute the Library (or any work based on the
+Library), the recipient automatically receives a license from the
+original licensor to copy, distribute, link with or modify the Library
+subject to these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties with
+this License.
+
+  11. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Library at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Library by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Library.
+
+If any portion of this section is held invalid or unenforceable under any
+particular circumstance, the balance of the section is intended to apply,
+and the section as a whole is intended to apply in other circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  12. If the distribution and/or use of the Library is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Library under this License may add
+an explicit geographical distribution limitation excluding those countries,
+so that distribution is permitted only in or among countries not thus
+excluded.  In such case, this License incorporates the limitation as if
+written in the body of this License.
+
+  13. The Free Software Foundation may publish revised and/or new
+versions of the Lesser General Public License from time to time.
+Such new versions will be similar in spirit to the present version,
+but may differ in detail to address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Library
+specifies a version number of this License which applies to it and
+"any later version", you have the option of following the terms and
+conditions either of that version or of any later version published by
+the Free Software Foundation.  If the Library does not specify a
+license version number, you may choose any version ever published by
+the Free Software Foundation.
+
+  14. If you wish to incorporate parts of the Library into other free
+programs whose distribution conditions are incompatible with these,
+write to the author to ask for permission.  For software which is
+copyrighted by the Free Software Foundation, write to the Free
+Software Foundation; we sometimes make exceptions for this.  Our
+decision will be guided by the two goals of preserving the free status
+of all derivatives of our free software and of promoting the sharing
+and reuse of software generally.
+
+			    NO WARRANTY
+
+  15. BECAUSE THE LIBRARY IS LICENSED FREE OF CHARGE, THERE IS NO
+WARRANTY FOR THE LIBRARY, TO THE EXTENT PERMITTED BY APPLICABLE LAW.
+EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR
+OTHER PARTIES PROVIDE THE LIBRARY "AS IS" WITHOUT WARRANTY OF ANY
+KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
+LIBRARY IS WITH YOU.  SHOULD THE LIBRARY PROVE DEFECTIVE, YOU ASSUME
+THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
+
+  16. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN
+WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY
+AND/OR REDISTRIBUTE THE LIBRARY AS PERMITTED ABOVE, BE LIABLE TO YOU
+FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR
+CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
+LIBRARY (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
+RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
+FAILURE OF THE LIBRARY TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
+SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
+DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+           How to Apply These Terms to Your New Libraries
+
+  If you develop a new library, and you want it to be of the greatest
+possible use to the public, we recommend making it free software that
+everyone can redistribute and change.  You can do so by permitting
+redistribution under these terms (or, alternatively, under the terms of the
+ordinary General Public License).
+
+  To apply these terms, attach the following notices to the library.  It is
+safest to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least the
+"copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the library's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This library is free software; you can redistribute it and/or
+    modify it under the terms of the GNU Lesser General Public
+    License as published by the Free Software Foundation; either
+    version 2.1 of the License, or (at your option) any later version.
+
+    This library is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    Lesser General Public License for more details.
+
+    You should have received a copy of the GNU Lesser General Public
+    License along with this library; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+Also add information on how to contact you by electronic and paper mail.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the library, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the
+  library `Frob' (a library for tweaking knobs) written by James Random Hacker.
+
+  <signature of Ty Coon>, 1 April 1990
+  Ty Coon, President of Vice
+
+That's all there is to it!
+
+
-- 
2.1.0
