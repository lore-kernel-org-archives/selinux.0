Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17735
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 13:03:31 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA18901
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 17:01:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA18895
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 17:01:56 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14915
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2002 13:03:29 -0400 (EDT)
Message-ID: <006b01c1ddd5$74c93340$780aa8c0@r213>
From: "f980215" <f980215@mailandnews.com>
To: <SELinux@tycho.nsa.gov>
Subject: help: install selinux
Date: Sun, 7 Apr 2002 09:42:05 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,all

I download SELinux and LSM Kernel on redhat 7.2 , 

and I see the file: 'step-by-step building and installing'

BUILDING  is ok
========

but

INSTALLING
==========
          cd ../selinux

STEP 2) : cd module
          make install

found the error info:
=====================

cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o services.o -c ../../../lsm-2.4/security/selinux/ss/services.c
yacc -d policy_parse.y
cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o y.tab.o -c y.tab.c
y.tab.c: In function `yyparse':
y.tab.c:3656: warning: implicit declaration of function `yylex'
lex policy_scan.l
cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o lex.yy.o -c lex.yy.c
lex.yy.c:1587: warning: `yyunput' defined but not used
cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss    -c -o checkpolicy.o checkpolicy.c
cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
lex.yy.c:1587: warning: `yyunput' defined but not used
cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss    -c -o checkpolicy.o checkpolicy.c
cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
policydb.o: In function `user_destroy':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:357: undefined reference to `mls_user_destroy'
policydb.o: In function `policydb_context_isvalid':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:487: undefined reference to `mls_context_isvalid'
policydb.o: In function `context_read_and_validate':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:513: undefined reference to `mls_read_range'
policydb.o: In function `perm_read':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:552: undefined reference to `mls_read_perm'
s/policydb.c:55: undefined reference to `sens_write'
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:55: undefined reference to `cat_write'
services.o: In function `context_struct_compute_av':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:174: undefined reference to `mls_compute_av'
services.o: In function `context_struct_to_string':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:277: undefined reference to `mls_compute_context_len'
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:295: undefined reference to `mls_sid_to_context'
services.o: In function `security_context_to_sid':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:449: undefined reference to `mls_context_to_sid'
services.o: In function `security_compute_sid':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:595: undefined reference to `mls_compute_sid'
services.o: In function `convert_context':
/usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:791: undefined reference to `mls_convert_context'
collect2: ld returned 1 exit status
make[1]: *** [checkpolicy] Error 1
make[1]: Leaving directory `/usr/local/src/se/selinux/module/checkpolicy'
make: *** [all] Error 2

Thanks for your any help.

f980215

f980215@mailandnews.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
