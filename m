Date: Mon, 8 Apr 2002 13:32:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: f980215 <f980215@mailandnews.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: help: install selinux
In-Reply-To: <006b01c1ddd5$74c93340$780aa8c0@r213>
Message-ID: <Pine.GSO.4.33.0204081311350.25988-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These errors indicate that you enabled the MLS option without making the
other changes described in the README.MLS file.  See the help text for
this option and the README.MLS file for more information.  As noted there,
the MLS policy component is considered experimental and has not been
configured for use.  Unless you really want to experiment with it, I
wouldn't recommend it.  Our focus has been on the RBAC and TE policies.
Of course, you can even express a MLS policy as a TE configuration if you
want, although the state space explodes if you have a lot of MLS levels.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Sun, 7 Apr 2002, f980215 wrote:

> hi,all
>
> I download SELinux and LSM Kernel on redhat 7.2 ,
>
> and I see the file: 'step-by-step building and installing'
>
> BUILDING  is ok
> ========
>
> but
>
> INSTALLING
> ==========
>           cd ../selinux
>
> STEP 2) : cd module
>           make install
>
> found the error info:
> =====================
>
> cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o services.o -c ../../../lsm-2.4/security/selinux/ss/services.c
> yacc -d policy_parse.y
> cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o y.tab.o -c y.tab.c
> y.tab.c: In function `yyparse':
> y.tab.c:3656: warning: implicit declaration of function `yylex'
> lex policy_scan.l
> cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss  -o lex.yy.o -c lex.yy.c
> lex.yy.c:1587: warning: `yyunput' defined but not used
> cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss    -c -o checkpolicy.o checkpolicy.c
> cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
> lex.yy.c:1587: warning: `yyunput' defined but not used
> cc -g  -I../../../lsm-2.4/include -Wall -O2 -pipe -include ../../../lsm-2.4/security/selinux/ss/global.h -I../../../lsm-2.4/security/selinux/include -I../../../lsm-2.4/security/selinux/ss    -c -o checkpolicy.o checkpolicy.c
> cc -o checkpolicy ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o checkpolicy.o -lfl
> policydb.o: In function `user_destroy':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:357: undefined reference to `mls_user_destroy'
> policydb.o: In function `policydb_context_isvalid':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:487: undefined reference to `mls_context_isvalid'
> policydb.o: In function `context_read_and_validate':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:513: undefined reference to `mls_read_range'
> policydb.o: In function `perm_read':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:552: undefined reference to `mls_read_perm'
> s/policydb.c:55: undefined reference to `sens_write'
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/policydb.c:55: undefined reference to `cat_write'
> services.o: In function `context_struct_compute_av':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:174: undefined reference to `mls_compute_av'
> services.o: In function `context_struct_to_string':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:277: undefined reference to `mls_compute_context_len'
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:295: undefined reference to `mls_sid_to_context'
> services.o: In function `security_context_to_sid':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:449: undefined reference to `mls_context_to_sid'
> services.o: In function `security_compute_sid':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:595: undefined reference to `mls_compute_sid'
> services.o: In function `convert_context':
> /usr/local/src/se/selinux/module/checkpolicy/../../../lsm-2.4/security/selinux/ss/services.c:791: undefined reference to `mls_convert_context'
> collect2: ld returned 1 exit status
> make[1]: *** [checkpolicy] Error 1
> make[1]: Leaving directory `/usr/local/src/se/selinux/module/checkpolicy'
> make: *** [all] Error 2
>
> Thanks for your any help.
>
> f980215
>
> f980215@mailandnews.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
