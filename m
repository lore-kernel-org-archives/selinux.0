Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFwqIi020494
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:58:53 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOFvMgi023442
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:57:22 GMT
Subject: Re: xen 2.0 - adding selinux permissions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041124154936.GB14100@lkcl.net>
References: <20041123220352.GF5146@lkcl.net>
	 <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124150927.GP5146@lkcl.net>
	 <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124154936.GB14100@lkcl.net>
Content-Type: text/plain
Message-Id: <1101311675.22014.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 10:54:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-24 at 10:49, Luke Kenneth Casson Leighton wrote:
>  okay, regarding the second argument to avc_has_perm(),
>  i asked the nice xen developers if it'd be possible to
>  associate a sid with each virtual machine.
> 
>  i mean, if nothing else, it's a matter of grabbing the
>  number (id) of the xen machine being contacted and faking up
>  a sid - sprintf(sid, "xen_vm_%d_t", xen_id);
> 
>  which is pretty yuk.
> 
>  how would i go about _not_ hacking something like that up?
> 
>  how would it be possible for the xen master machine to create
>  a sid per xen machine?  xen_vm_0_t, xen_vm_1_t etc.

I'm not clear on how you intend to use these distinct security contexts
(and let's not confuse them with SIDs), particularly for the management
interface.  You are applying a check as to whether a given process on
the master can perform a given control operation; in what case would you
need to distinguish on a per-VM basis?

Now, if you want to control interactions among the VMs or access by a VM
to a resource, that is another matter, but I'm not clear that is going
to be visible to SELinux at all.  IIUC, with NetTop/VMWare, there was a
process on the host OS for each VM and the host OS was used for access
to files, devices, etc, so SELinux on the host could associate a
different domain with each of those processes and control their access
to files, devices, etc.  But I don't think the situation is the same
with Xen.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
