Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFDLIi020015
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:13:21 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOFDNC8027624
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:13:23 GMT
Date: Wed, 24 Nov 2004 15:24:02 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Neugebauer, Rolf" <rolf.neugebauer@intel.com>
Cc: Mark Williamson <maw48@hermes.cam.ac.uk>, xen-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [Xen-devel] protecting xen startup
Message-ID: <20041124152402.GQ5146@lkcl.net>
References: <39CC97884CA19A4D8D6296FE94357BCBF5CCD7@swsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39CC97884CA19A4D8D6296FE94357BCBF5CCD7@swsmsx404>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 11:48:15AM -0000, Neugebauer, Rolf wrote:
> Yes, in principle you should be able to do that (and we have been
> thinking along similar lines). However, at the moment the linux kernel
> in the exporting VM (BE) does not know anything about other VMs so as
> far as my understanding goes you can't apply SELinux policies to it as
> you don't have a subject.
 
 okay.

 that can be dealt with by... (this is speculation, here!)

 by writing an selinux policy in advance that defines how many
 virtual machines you have, and creating xen_vm0_t, xen_vm1_t
 etc. to represent them.

 you then define what operations can be carried out, and then
 grant a program the right to perform that operation on SPECIFIC
 machines.  [yes there is a short-hand which allows you to specify an
 operation be allowed by a program on all machines].

 then it would be necessary to modify the linux kernel to call the
 avc_has_perm() function at the appropriate point to check, at the time
 that an operation was being done (e.g. read from block device), as to
 whether that process had the right to perform that operation on that
 xen virtual machine.

 in order for this to work, it would be necessary to have a translation
 mechanism between the numbering xen_vm_0_t etc. and the actual xen
 virtual machines.

 looking at avc_has_perm(), you'd need a SID per virtual machine,
 as the second argument...

 xen_communication_has_perm(struct task_struct *tsk,
                            struct xen_info *xen,
							u32 perms)
 {
	 return avc_has_perm(tsec->sid,
	                     xen->sid, SECCLASS_XEN, perms, NULL, NULL);
 }

 where xen->sid contains "xen_vm_0_t", "xen_vm_1_t" etc.
 and tsec->sid contains "xen_xm_bin_t" - representing the xen control
 binary /usr/bin/xm.

 the question i can't answer (the bit that i don't quite grok) is
 how do you get hold of the right xen_info struct and how do you blat
 the sid into it?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
