Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOKDcIi022614
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:13:38 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOKDeC8008498
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 20:13:40 GMT
Date: Wed, 24 Nov 2004 20:24:12 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Neugebauer, Rolf" <rolf.neugebauer@intel.com>,
   Mark Williamson <maw48@hermes.cam.ac.uk>, xen-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [Xen-devel] protecting xen startup
Message-ID: <20041124202412.GB15740@lkcl.net>
References: <39CC97884CA19A4D8D6296FE94357BCBF5CCD7@swsmsx404> <20041124152402.GQ5146@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041124152402.GQ5146@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 03:24:02PM +0000, Luke Kenneth Casson Leighton wrote:

>  where xen->sid contains "xen_vm_0_t", "xen_vm_1_t" etc.
>  and tsec->sid contains "xen_xm_bin_t" - representing the xen control
>  binary /usr/bin/xm.
> 
>  the question i can't answer (the bit that i don't quite grok) is
>  how do you get hold of the right xen_info struct and how do you blat
>  the sid into it?

 sorry to be replying to my own message with another question,
 but would it be reasonable to have a function which adds
 some state info into the VM?

 what i mean by that is, would it be reasonable to add some functions
 xen_get_selinux_sid and xen_set_selinux_sid which are
 effectively the same as ext2/3 get and set xattrs "security.selinux"?

 such that it would be possible, on creation of a new xen guest session,
 to associate a SID with that session (e.g. "xen_vm_0_t") and then to be
 able to retrieve it again in the ioctls?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
