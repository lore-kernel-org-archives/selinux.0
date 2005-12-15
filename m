Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBFMSBMA027094
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 17:28:11 -0500 (EST)
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBFMS8sl021026
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 22:28:08 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBFMSAf6015150
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 17:28:10 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBFMSAFX117988
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 17:28:10 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id jBFMSAKJ022449
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2005 17:28:10 -0500
Date: Thu, 15 Dec 2005 16:28:09 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: Reference Policy Release
Message-ID: <20051215222809.GA17384@sergelap.austin.ibm.com>
References: <1133973607.8185.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1133973607.8185.10.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hmm, I'm trying to compile this as a modular policy.  I've selected
"nis = off" in my modules.conf.  But I get

	policy/modules/admin/netutils.te:88:ERROR 'syntax error' at token
	'nis_use_ypbind' on line 33005:
	#line 88
		nis_use_ypbind(netutils_t)

when I try 'make load'.

Is this me misunderstanding how I can use modules.conf, or is
the module policy mostly unsupported?  (I'm happy to help get it
working, just am not sure how it's supposed to work now :)  My first
instinct of course is that the "optional_policy" macro in
policy/support/loadable_module.spt would need to be more complicated
to handle using modules.conf...  But man that's one ugly macro.

thanks,
-serge

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> A new release of the SELinux Reference Policy is now available on
> SourceForge from http://serefpolicy.sourceforge.net.  The primary
> activity for this release has been preparing and testing Reference
> Policy for inclusion in Fedora Core 5 as it's targeted policy.  In
> addition, several build issues have been fixed.  The change log follows
> at the bottom of the email.
> 
> Again, for those that are interesting in contributing, right now the
> best help would be to convert existing policies over to reference
> policy; there is a list of modules on the reference policy status page
> on SourceForge.
> 
> * Wed Dec 07 2005 Chris PeBenito <selinux@tresys.com> - 20051207
> - Add unlabeled IPSEC association rule to domains with
>   networking permissions.
> - Merge systemuser back in to users, as these files
>   do not need to be split.
> - Add check for duplicate interface/template definitions.
> - Move domain, files, and corecommands modules to kernel
>   layer to resolve some layering inconsistencies.
> - Move policy build options out of Makefile into build.conf.
> - Add yppasswd to nis module.
> - Change optional_policy() to refer to the module name
>   rather than modulename.te.
> - Fix labeling targets to use installed file_contexts rather
>   than partial file_contexts in the policy source directory.
> - Fix build process to use make's internal vpath functions
>   to detect modules rather than using subshells and find.
> - Add install target for modular policy.
> - Add load target for modular policy.
> - Add appconfig dependency to the load target.
> - Miscellaneous fixes from Dan Walsh.
> - Fix corenetwork gen_context()'s to expand during the policy
>   build phase instead of during the generation phase.  
> - Added policies:
> 	amanda
> 	avahi
> 	canna
> 	cyrus
> 	dbskk
> 	dovecot
> 	distcc
> 	i18n_input
> 	irqbalance
> 	lpd
> 	networkmanager
> 	pegasus
> 	postfix
> 	procmail
> 	radius
> 	rdisc
> 	rpc
> 	spamassassin
> 	timidity
> 	xdm
> 	xfs
> 
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
