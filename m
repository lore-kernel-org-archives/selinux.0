Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBINKRXf019827
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 18:20:27 -0500 (EST)
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBINKOB6014277
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 23:20:25 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBINKP63014725
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 18:20:26 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBINM93c077484
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 16:22:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBINKPTB000670
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 16:20:25 -0700
Date: Sun, 18 Dec 2005 17:20:18 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: Reference Policy Release
Message-ID: <20051218232018.GA9064@sergelap.austin.ibm.com>
References: <1133973607.8185.10.camel@sgc.columbia.tresys.com> <20051215222809.GA17384@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051215222809.GA17384@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Hmm, I'm trying to compile this as a modular policy.  I've selected
> "nis = off" in my modules.conf.  But I get
> 
> 	policy/modules/admin/netutils.te:88:ERROR 'syntax error' at token
> 	'nis_use_ypbind' on line 33005:
> 	#line 88
> 		nis_use_ypbind(netutils_t)
> 
> when I try 'make load'.

Also, I needed the following patch to get cvs refpolicy to compile as a
static policy without unconfined.  Of course the offending statement was
"cjp: temporary hack"  :)

thanks,
-serge

Index: refpolicy/policy/modules/system/selinuxutil.te
===================================================================
--- refpolicy.orig/policy/modules/system/selinuxutil.te	2005-12-17 22:24:11.000000000 -0600
+++ refpolicy/policy/modules/system/selinuxutil.te	2005-12-18 17:13:38.000000000 -0600
@@ -198,7 +198,9 @@ ifdef(`targeted_policy', `
 # cjp: temporary hack to cover
 # up stray file descriptors.
 dontaudit load_policy_t selinux_config_t:file write;
-unconfined_dontaudit_read_pipe(load_policy_t)
+optional_policy(`unconfined',`
+	unconfined_dontaudit_read_pipe(load_policy_t)
+')
 
 ########################################
 #

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
