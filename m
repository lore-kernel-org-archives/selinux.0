Subject: Re: How about future of MLS?
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Wu Yanjun <yanjunwu@sonata.iscas.ac.cn>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1063129289.8041.613.camel@moss-spartans.epoch.ncsc.mil>
References: <200309080810.12991.yanjunwu@sonata.iscas.ac.cn>
	 <1063023949.8041.42.camel@moss-spartans.epoch.ncsc.mil>
	 <200309091050.57371.yanjunwu@sonata.iscas.ac.cn>
	 <1063129289.8041.613.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-ZGZdF/ZQsCGYpzwJS07T"
Message-Id: <1063312550.28296.2.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 11 Sep 2003 16:35:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZGZdF/ZQsCGYpzwJS07T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-09-09 at 13:41, Stephen Smalley wrote:
> Regardless of whether this approach is taken, the MLS configuration
> requires further work to correctly map each SELinux permission to the
> corresponding set of MLS base permissions (information flows), and the
> TE configuration requires further work to identify domains that need to
> act as trusted subjects.  Polyinstantiated / multi-level directory
> support will be needed to support userspace, and a program for selecting
> the current level will be needed.

I have attached and included below two patches against the latest
selinux-usr to help fix the mls configuration for SELinux. This is to
support our work on information flow analysis that will be released
soon. The first patch modifies policy/mls to support the object class
changes. The base permissions assigned are meant to be consistent with
the existing mappings, but anyone who wants to use MLS should
review these changes. The second patch adds support to the checkpolicy
Makefile for compiling with MLS support.

Karl
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134

--- policy/mls.orig     2003-09-12 01:57:22.908376432 -0400
+++ policy/mls  2003-09-12 02:54:16.302461656 -0400
@@ -79,7 +79,7 @@
        recv_msg        :       read
        send_msg        :       write
        name_bind       :       none
-}      
+}
 
 common ipc
 {
@@ -197,6 +197,10 @@
        getcap          :       read
        setcap          :       write
        share           :       { read write }
+       noatsecure      :       none
+       getattr         :       read
+       setexec         :       write
+       setfscreate     :       write
 }
 
 class ipc
@@ -222,26 +226,21 @@
 class security
 {
        compute_av              :       none
-       transition_sid          :       none
-       member_sid              :       none
-       sid_to_context          :       none
-       context_to_sid          :       none
+       compute_create          :       none
+       compute_member          :       none
+       check_context           :       none
        load_policy             :       none
-       get_sids                :       none
-       change_sid              :       none
-       get_user_sids           :       none
+       compute_relabel         :       none
+       compute_user            :       none
+       setenforce              :       none
 }
 
 class system
 {
        ipc_info                :       none
-       avc_toggle              :       none
-       nfsd_control            :       none
-       bdflush                 :       none
        syslog_read             :       none
        syslog_mod              :       none
        syslog_console          :       none
-       ichsid                  :       none    
 }
 
 class capability
@@ -276,3 +275,10 @@
        mknod                   :       none
        lease                   :       none
 }
+
+class passwd
+{
+       passwd                  :       write
+       chfn                    :       write
+       chsh                    :       write
+}


--- checkpolicy/Makefile.orig   2003-09-12 01:52:03.694904256 -0400
+++ checkpolicy/Makefile        2003-09-12 01:55:08.370829248 -0400
@@ -4,10 +4,21 @@
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
 
-CFLAGS = -g -Wall -O2 -pipe
+# Set to y for MLS
+MLS=n
+
+ifeq ($(MLS),y)
+OPTIONS = -DCONFIG_SECURITY_SELINUX_MLS
+OBJS = mls.o
+else
+OPTIONS =
+OBJS =
+endif
+
+CFLAGS = -g $(OPTIONS) -Wall -O2 -pipe
 override CFLAGS += -include global.h -I. -Iinclude
 
-OBJS = ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o
services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
+OBJS += ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o
services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
 
 LIBS=-lfl


--=-ZGZdF/ZQsCGYpzwJS07T
Content-Disposition: attachment; filename=make-patch
Content-Type: text/plain; name=make-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- checkpolicy/Makefile.orig	2003-09-12 01:52:03.694904256 -0400
+++ checkpolicy/Makefile	2003-09-12 01:55:08.370829248 -0400
@@ -4,10 +4,21 @@
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
 
-CFLAGS = -g -Wall -O2 -pipe
+# Set to y for MLS
+MLS=n
+
+ifeq ($(MLS),y)
+OPTIONS = -DCONFIG_SECURITY_SELINUX_MLS
+OBJS = mls.o
+else
+OPTIONS =
+OBJS =
+endif
+
+CFLAGS = -g $(OPTIONS) -Wall -O2 -pipe
 override CFLAGS += -include global.h -I. -Iinclude
 
-OBJS = ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
+OBJS += ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
 
 LIBS=-lfl
 

--=-ZGZdF/ZQsCGYpzwJS07T
Content-Disposition: attachment; filename=mls-patch
Content-Type: text/plain; name=mls-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- policy/mls.orig	2003-09-12 01:57:22.908376432 -0400
+++ policy/mls	2003-09-12 02:54:16.302461656 -0400
@@ -79,7 +79,7 @@
 	recv_msg	:	read
 	send_msg	:	write
 	name_bind	:	none
-}	
+}
 
 common ipc
 {
@@ -197,6 +197,10 @@
 	getcap		:	read
 	setcap		:	write
 	share		:	{ read write }
+	noatsecure	:	none
+	getattr		:	read
+	setexec		:	write
+	setfscreate	:	write
 }
 
 class ipc
@@ -222,26 +226,21 @@
 class security
 {
 	compute_av		:	none
-	transition_sid		:	none
-	member_sid		:	none
-	sid_to_context		:	none
-	context_to_sid		:	none
+	compute_create		:	none
+	compute_member		:	none
+	check_context		:	none
 	load_policy		:	none
-	get_sids		:	none
-	change_sid		:	none
-	get_user_sids		:	none
+	compute_relabel		:	none
+	compute_user		:	none
+	setenforce		:	none
 }
 
 class system
 {
 	ipc_info		:	none
-	avc_toggle		:	none
-	nfsd_control		:	none
-	bdflush			:	none
 	syslog_read		:	none
 	syslog_mod		:	none
 	syslog_console		:	none
-	ichsid			:	none	
 }
 
 class capability
@@ -276,3 +275,10 @@
 	mknod			:	none
 	lease			:	none
 }
+
+class passwd
+{
+	passwd			:	write
+	chfn			:	write
+	chsh			:	write
+}

--=-ZGZdF/ZQsCGYpzwJS07T--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
