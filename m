Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MHtfWt004760
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 13:55:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9MHtRIS011078
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:55:27 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
	by jazzswing.ncsc.mil  with ESMTP id h9MHtQDc011062
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:55:26 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 3C0D3170021
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 20:10:06 +0200 (CEST)
Date: Wed, 22 Oct 2003 19:56:08 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy/policy_scan.y
Message-ID: <20031022175608.GB4531@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi
                                                                                                                                                             
The following patch fixes some warnings in policy_parse.y (add -W to the
CFLAGS to display this warnings):
                                                                                                                                                             
policy_parse.y: In function `set_types':
policy_parse.y:1666: warning: comparison between signed and unsigned
policy_parse.y:1674: warning: comparison between signed and unsigned
policy_parse.y:1694: warning: comparison between signed and unsigned
...
policy_parse.y: In function `define_constraint':
policy_parse.y:2543: warning: comparison between signed and unsigned
policy_parse.y: In function `define_cexpr':
policy_parse.y:2644: warning: cast from pointer to integer of different size
policy_parse.y:2645: warning: cast from pointer to integer of different size
policy_parse.y:2648: warning: cast from pointer to integer of different size
policy_parse.y:2649: warning: cast from pointer to integer of different size
policy_parse.y: In function `set_user_roles':
policy_parse.y:2711: warning: comparison between signed and unsigned
policy_parse.y:2719: warning: comparison between signed and unsigned
policy_parse.y:2738: warning: comparison between signed and unsigned
                                                                                                                                                             
Joerg


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=policy_scan

12a13
> #include <stdint.h>
51c52
< static constraint_expr_t *define_cexpr(__u32 expr_type, void *arg1, void* arg2);
---
> static uintptr_t define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2);
57,58c58,59
< static int define_fs_context(int major, int minor);
< static int define_port_context(int low, int high);
---
> static int define_fs_context(uintptr_t major, uintptr_t minor);
> static int define_port_context(uintptr_t low, uintptr_t high);
60c61
< static int define_node_context(int addr, int mask);
---
> static int define_node_context(uintptr_t addr, uintptr_t mask);
64c65
< 	int val;
---
> 	uintptr_t val;
68,69c69,70
< %type <ptr> role_def roles cexpr cexpr_prim op roleop
< %type <val> ipv4_addr_def number
---
> %type <ptr> role_def roles
> %type <val> ipv4_addr_def number cexpr cexpr_prim op roleop
325c326
< 			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_USER, $2);
---
> 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, $2);
328c329
< 			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_ROLE, $2);
---
> 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
331c332
< 			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_TYPE, $2);
---
> 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_TYPE, $2);
334c335
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_USER, $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_USER, $2);
337c338
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_USER | CEXPR_TARGET), $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_USER | CEXPR_TARGET), $2);
340c341
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_ROLE, $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, $2);
343c344
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_ROLE | CEXPR_TARGET), $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), $2);
346c347
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_TYPE, $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, $2);
349c350
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_TYPE | CEXPR_TARGET), $2);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), $2);
352c353
< 			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_USER, (void*)CEXPR_EQ);
---
> 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_USER, CEXPR_EQ);
355c356
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_ROLE, (void*)CEXPR_EQ);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_ROLE, CEXPR_EQ);
358c359
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_ROLE | CEXPR_TARGET), (void*)CEXPR_EQ);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_ROLE | CEXPR_TARGET), CEXPR_EQ);
361c362
< 			{ $$ = define_cexpr(CEXPR_ATTR, (void*)CEXPR_ROLE, (void*)$2);
---
> 			{ $$ = define_cexpr(CEXPR_ATTR, CEXPR_ROLE, $2);
364c365
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)CEXPR_TYPE, (void*)CEXPR_EQ);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, CEXPR_TYPE, CEXPR_EQ);
367c368
< 			{ $$ = define_cexpr(CEXPR_NAMES, (void*)(CEXPR_TYPE | CEXPR_TARGET), (void*)CEXPR_EQ);
---
> 			{ $$ = define_cexpr(CEXPR_NAMES, (CEXPR_TYPE | CEXPR_TARGET), CEXPR_EQ);
371c372
< 			{ $$ = (void*)CEXPR_EQ; }
---
> 			{ $$ = CEXPR_EQ; }
373c374
< 			{ $$ = (void*)CEXPR_NEQ; }
---
> 			{ $$ = CEXPR_NEQ; }
378c379
< 			{ $$ = (void*)CEXPR_DOM; }
---
> 			{ $$ = CEXPR_DOM; }
380c381
< 			{ $$ = (void*)CEXPR_DOMBY; }
---
> 			{ $$ = CEXPR_DOMBY; }
382c383
< 			{ $$ = (void*)CEXPR_INCOMP; }
---
> 			{ $$ = CEXPR_INCOMP; }
1662c1663
< 	int i;
---
> 	unsigned int i;
1718c1719,1720
< 	int ret, i, j, k;
---
> 	int ret;
> 	unsigned int i, j, k;
1867c1869,1870
< 	int i, rc;
---
> 	unsigned int i;
> 	int rc;
1894c1897
< static int te_avtab_helper(int which, int stype, int ttype, 
---
> static int te_avtab_helper(int which, unsigned int stype, unsigned int ttype, 
1900c1903,1904
< 	int ret, k;
---
> 	int ret;
> 	unsigned int k;
1961c1965,1966
< 	int i, j, hiclass, self = 0;
---
> 	unsigned int i, j, hiclass;
> 	int self = 0;
2024c2029
< 				avp[i] = ~0;
---
> 				avp[i] = (access_vector_t) -1;
2222c2227,2228
< 	int i, ret;
---
> 	unsigned int i;
> 	int ret;
2277c2283
< 	int i;
---
> 	unsigned int i;
2320c2326
< 	int i, j;
---
> 	unsigned int i, j;
2401c2407
< 	int i, j;
---
> 	unsigned int i, j;
2465c2471,2472
< 	int i, depth;
---
> 	unsigned int i;
> 	int depth;
2575,2576c2582,2583
< static constraint_expr_t *
<  define_cexpr(__u32 expr_type, void* arg1, void* arg2)
---
> static uintptr_t
>  define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2)
2589c2596
< 		return (constraint_expr_t *)1; /* any non-NULL value */
---
> 		return 1; /* any non-NULL value */
2595c2602
< 		return NULL;
---
> 		return 0;
2611c2618
< 			return NULL;
---
> 			return 0;
2614c2621
< 		return (struct constraint_expr *) arg1;
---
> 		return arg1;
2626c2633
< 			return NULL;
---
> 			return 0;
2639c2646
< 			return NULL;
---
> 			return 0;
2642c2649
< 		return (struct constraint_expr *) arg1;
---
> 		return arg1;
2644,2646c2651,2653
< 		expr->attr = (__u32)arg1;
< 		expr->op = (__u32)arg2;
< 		return expr;
---
> 		expr->attr = arg1;
> 		expr->op = arg2;
> 		return (uintptr_t) expr;
2648,2649c2655,2656
< 		expr->attr = (__u32)arg1;
< 		expr->op = (__u32)arg2;
---
> 		expr->attr = arg1;
> 		expr->op = arg2;
2658c2665
< 					return NULL;
---
> 					return 0;
2668c2675
< 					return NULL;
---
> 					return 0;
2674c2681
< 					return NULL;
---
> 					return 0;
2680c2687
< 				return NULL;
---
> 				return 0;
2686c2693
< 				return NULL;
---
> 				return 0;
2690c2697
< 		return expr;
---
> 		return (uintptr_t) expr;
2694c2701
< 		return NULL;
---
> 		return 0;
2699c2706
< 	return NULL;
---
> 	return 0;
2707c2714
< 	int i;
---
> 	unsigned int i;
3140c3147
< static int define_fs_context(int major, int minor)
---
> static int define_fs_context(uintptr_t major, uintptr_t minor)
3157c3164
< 	newc->u.name = (char *) malloc(6);
---
> 	newc->u.name = malloc((size_t) 6);
3163c3170,3171
< 	sprintf(newc->u.name, "%02x:%02x", major, minor);
---
> 	sprintf(newc->u.name, "%02lx:%02lx", (unsigned long) major,
> 	                 (unsigned long)minor);
3196c3204
< static int define_port_context(int low, int high)
---
> static int define_port_context(uintptr_t low, uintptr_t high)
3295c3303
< static int define_node_context(int addr, int mask)
---
> static int define_node_context(uintptr_t addr, uintptr_t mask)

--jho1yZJdad60DJr+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
