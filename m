Message-ID: <4852B1F8.7000408@manicmethod.com>
Date: Fri, 13 Jun 2008 13:44:24 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [patch] libsepol write.c has shadowed var
References: <48529591.90806@manicmethod.com> <1213374335.17842.356.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213374335.17842.356.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-06-13 at 11:43 -0400, Joshua Brindle wrote:
>> This patch addresses a shadowed var that prevents libsepol from being built with DEBUG=1
>>
>> Signed-off-by: Joshua Brindle <method@manicmethod.com>
>>
>> ---
>>
>> Index: libsepol/src/write.c
>> ===================================================================
>> --- libsepol/src/write.c	(revision 2908)
>> +++ libsepol/src/write.c	(working copy)
>> @@ -1625,10 +1625,10 @@
>>  	if (p->policyvers < POLICYDB_VERSION_PERMISSIVE &&
>>  	    p->policy_type == POLICY_KERN) {
>>  		ebitmap_node_t *tnode;
>> -		unsigned int i;
>> +		unsigned int j;
>>  
>> -		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
>> -			if (ebitmap_node_get_bit(tnode, i)) {
>> +		ebitmap_for_each_bit(&p->permissive_map, tnode, j) {
>> +			if (ebitmap_node_get_bit(tnode, j)) {
>>  				WARN(fp->handle, "Warning! Policy version %d cannot "
>>  				     "support permissive types, but some were defined",
>>  				     p->policyvers);
> 
> Any particular reason we can't just use the local var from the outer
> scope?
> 


good point, I didn't really look at how i was being used. This uses i from the outer scope and adds -Wshadow to library and checkpolicy makefiles.

---

Index: libsemanage/src/Makefile
===================================================================
--- libsemanage/src/Makefile	(revision 2908)
+++ libsemanage/src/Makefile	(working copy)
@@ -31,7 +31,7 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c))) conf-scan.lo conf-parse.lo
-CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
+CFLAGS ?= -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -Wno-unused-parameter
 
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
 
Index: libsepol/src/Makefile
===================================================================
--- libsepol/src/Makefile	(revision 2908)
+++ libsepol/src/Makefile	(working copy)
@@ -10,7 +10,7 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS ?= -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 all: $(LIBA) $(LIBSO)
Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2908)
+++ libsepol/src/write.c	(working copy)
@@ -1625,7 +1625,6 @@
 	if (p->policyvers < POLICYDB_VERSION_PERMISSIVE &&
 	    p->policy_type == POLICY_KERN) {
 		ebitmap_node_t *tnode;
-		unsigned int i;
 
 		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
 			if (ebitmap_node_get_bit(tnode, i)) {
Index: checkpolicy/Makefile
===================================================================
--- checkpolicy/Makefile	(revision 2908)
+++ checkpolicy/Makefile	(working copy)
@@ -10,7 +10,7 @@
 
 YACC = bison -y
 
-CFLAGS ?= -g -Wall -Werror -O2 -pipe -fno-strict-aliasing
+CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
 
 override CFLAGS += -I. -I${INCLUDEDIR}
 
Index: libselinux/src/Makefile
===================================================================
--- libselinux/src/Makefile	(revision 2908)
+++ libselinux/src/Makefile	(working copy)
@@ -33,7 +33,7 @@
 
 OBJS= $(patsubst %.c,%.o,$(SRCS))
 LOBJS= $(patsubst %.c,%.lo,$(SRCS))
-CFLAGS ?= -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
