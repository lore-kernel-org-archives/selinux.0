Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3MGaTI4026473
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 12:36:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3MGaNVf024163
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:36:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3MGaM4D024160
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:36:22 GMT
Subject: Re: kmod_t v. kernel_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: david caplan <dac@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <GBEAJBKHFOBIBBJBCGAGCEBCCMAA.dac@tresys.com>
References: <GBEAJBKHFOBIBBJBCGAGCEBCCMAA.dac@tresys.com>
Content-Type: text/plain
Message-Id: <1051029057.14761.68.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Apr 2003 12:30:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-04-21 at 15:57, david caplan wrote:
> Back on March 28th, Stephen Smalley wrote:
> >
> >The attached patch for selinux/policy folds the kmod_t domain into
> >kernel_t and removes every_domain from kernel_t.  kmod.te can then be
> >removed.  These changes have also been committed to the sourceforge CVS
> >tree.
> 
> Does this mean that kmod_t should/can be replaced by kernel_t everywhere?
> If so, vmware.te and hotplug.te need to be fixed -- at least in the policy
> on the sourceforge site.

Yes, I've now fixed them in the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
