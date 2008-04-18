Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3I90Sc9008495
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 05:00:28 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3I90PER002999
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 09:00:26 GMT
Received: from ns.i.cz (unknown [192.168.24.10])
	by vidle.i.cz (Postfix) with ESMTP id 900091CC09
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 11:00:20 +0200 (CEST)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 1568A5C06
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 11:00:21 +0200 (CEST)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1JmmSC-0005EW-Ny
	for selinux@tycho.nsa.gov; Fri, 18 Apr 2008 11:00:20 +0200
Date: Fri, 18 Apr 2008 11:00:20 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: refpolicy: loadable_module.spt improvement?
Message-ID: <20080418090020.GA19371@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
while looking into the policy/support/loadable_module.spt I could not
catch handling of the policy_call_depth in the template and the
interface macro.

define(`interface',` dnl
        ifdef(`$1',`refpolicyerr(`duplicate definition of $1(). Original definition on '$1.) define(`__if_error')',`define(`$1',__line__)') dnl
        `define(`$1',` dnl
        define(`policy_temp',incr(policy_call_depth)) dnl
        pushdef(`policy_call_depth',policy_temp) dnl
        undefine(`policy_temp') dnl
        policy_m4_comment(policy_call_depth,begin `$1'(dollarsstar)) dnl
        $2
        define(`policy_temp',decr(policy_call_depth)) dnl
        pushdef(`policy_call_depth',policy_temp) dnl
        undefine(`policy_temp') dnl
        policy_m4_comment(policy_call_depth,end `$1'(dollarsstar)) dnl
        '')
')

The policy_call_depth is incremented using temporal policy_temp
- I don't know why. The new definition is pushed into the m4 stack, ok.
On the leaving side of macro is the original value not popped from the
stack, but new decremented value is pushed into the stack. So stack of
the policy_call_depth definitions is growing up.

I prepared fix for this - it is attached. The policy is generated faster
by at least 5% with this (intermediate files are smaller and less work
for m4 and less memory footprint of m4 I hope).

Best Regards
-- 
Zito

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interface

Index: refpolicy-svn/policy/support/loadable_module.spt
===================================================================
--- refpolicy-svn.orig/policy/support/loadable_module.spt	2008-04-18 08:29:38.000000000 +0200
+++ refpolicy-svn/policy/support/loadable_module.spt	2008-04-18 10:13:05.000000000 +0200
@@ -62,14 +62,10 @@
 define(`template',` dnl
 	ifdef(`$1',`refpolicyerr(`duplicate definition of $1(). Original definition on '$1.) define(`__if_error')',`define(`$1',__line__)') dnl
 	`define(`$1',` dnl
-	define(`policy_temp',incr(policy_call_depth)) dnl
-	pushdef(`policy_call_depth',policy_temp) dnl
-	undefine(`policy_temp') dnl
+	pushdef(`policy_call_depth',incr(policy_call_depth)) dnl
 	policy_m4_comment(policy_call_depth,begin `$1'(dollarsstar)) dnl
 	$2 dnl
-	define(`policy_temp',decr(policy_call_depth)) dnl
-	pushdef(`policy_call_depth',policy_temp) dnl
-	undefine(`policy_temp') dnl
+	popdef(`policy_call_depth') dnl
 	policy_m4_comment(policy_call_depth,end `$1'(dollarsstar)) dnl
 	'')
 ')
@@ -83,14 +79,10 @@
 define(`interface',` dnl
 	ifdef(`$1',`refpolicyerr(`duplicate definition of $1(). Original definition on '$1.) define(`__if_error')',`define(`$1',__line__)') dnl
 	`define(`$1',` dnl
-	define(`policy_temp',incr(policy_call_depth)) dnl
-	pushdef(`policy_call_depth',policy_temp) dnl
-	undefine(`policy_temp') dnl
+	pushdef(`policy_call_depth',incr(policy_call_depth)) dnl
 	policy_m4_comment(policy_call_depth,begin `$1'(dollarsstar)) dnl
 	$2
-	define(`policy_temp',decr(policy_call_depth)) dnl
-	pushdef(`policy_call_depth',policy_temp) dnl
-	undefine(`policy_temp') dnl
+	popdef(`policy_call_depth') dnl
 	policy_m4_comment(policy_call_depth,end `$1'(dollarsstar)) dnl
 	'')
 ')

--VS++wcV0S1rZb1Fb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
