Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3LJwBI4022337
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 15:58:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3LJw97R015480
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 19:58:09 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-196.nas-smoothtransition.com [66.95.157.196] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h3LJw5KP015463 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 19:58:08 GMT
From: "david caplan" <dac@tresys.com>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: kmod_t v. kernel_t
Date: Mon, 21 Apr 2003 15:57:43 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGCEBCCMAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200303281419.JAA04415@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Back on March 28th, Stephen Smalley wrote:
>
>The attached patch for selinux/policy folds the kmod_t domain into
>kernel_t and removes every_domain from kernel_t.  kmod.te can then be
>removed.  These changes have also been committed to the sourceforge CVS
>tree.

Does this mean that kmod_t should/can be replaced by kernel_t everywhere?
If so, vmware.te and hotplug.te need to be fixed -- at least in the policy
on the sourceforge site.

David


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
