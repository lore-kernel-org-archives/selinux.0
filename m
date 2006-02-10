Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AJ3CXf013926
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:03:13 -0500 (EST)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AJ38TR003082
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 19:03:08 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1AJ3A2m025667
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:03:10 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1AJ384C219910
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:03:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k1AJ38pY001499
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:03:08 -0500
Date: Fri, 10 Feb 2006 13:03:07 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: seref: trivial patch:
Message-ID: <20060210190307.GC26183@sergelap.austin.ibm.com>
References: <20060209194236.GF10534@sergelap.austin.ibm.com> <1139582505.13925.84.camel@sgc.columbia.tresys.com> <20060210155933.GA26183@sergelap.austin.ibm.com> <1139598040.13925.98.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1139598040.13925.98.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Fri, 2006-02-10 at 09:59 -0600, Serge E. Hallyn wrote:
> > A question that's not clear in my mind - if a module, like certwatch.te,
> > uses the apache_exec_modules() interface, should that call automatically be
> > defined away to nothing if apache is not defined, or does that call
> > still need to be inside of a 'optional_policy(`apache'' block?  The
> > former sounds like preferred behavior to keep policies clean, but that'
> > not what is happening right now, judging by the otput under tmp/.
> 
> No, we want those rules in an optional_policy().  Its implementation is
> an ifdef for monolithic policy/base module, and an optional{} block for
> loadable modules.  Optional{} blocks are compiled in and are resolved at
> link time; then you don't have to recompile the module to change the
> optional policy blocks.

Ok - then the following patch will be needed  :)

thanks,
-serge

Index: refpolicy/policy/modules/admin/certwatch.te
===================================================================
--- refpolicy.orig/policy/modules/admin/certwatch.te
+++ refpolicy/policy/modules/admin/certwatch.te
@@ -27,7 +27,9 @@ logging_send_syslog_msg(certwatch_t)
 miscfiles_read_certs(certwatch_t)
 miscfiles_read_localization(certwatch_t)
 
-apache_exec_modules(certwatch_t)
+optional_policy(`apache',`
+	apache_exec_modules(certwatch_t)
+')
 
 optional_policy(`cron',`
 	cron_system_entry(certwatch_t,certwatch_exec_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
