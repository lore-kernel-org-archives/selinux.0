Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFcwIi020273
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:38:58 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOFbNgi021833
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:37:28 GMT
Date: Wed, 24 Nov 2004 15:49:36 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: xen 2.0 - adding selinux permissions
Message-ID: <20041124154936.GB14100@lkcl.net>
References: <20041123220352.GF5146@lkcl.net> <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil> <20041124150927.GP5146@lkcl.net> <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 10:06:09AM -0500, Stephen Smalley wrote:
> On Wed, 2004-11-24 at 10:09, Luke Kenneth Casson Leighton wrote:
> >  okay, i must have misunderstood.
> > 
> >  i envisage creating a xen_has_perm() and _that_ means adding
> >  something to security/selinux/include/av_permissions.h
> >  #define XEN_VM_CREATE  0x00000001UL
> >  #define XEN_VM_DESTROY 0x00000002UL, etc.
> > 
> >  and creating a SECCLASS_XEN?
> 
> Those header files are automatically generated.  To add new
> classes/permissions:
> - Check out a copy of linux-2.6 and selinux-usr from our sourceforge CVS
> tree,
> - cd selinux-usr/policy/flask
> - Edit security_classes and access_vectors, adding your new class at the
> end.
> - Run make in that directory to generate the headers,
> - Run make tokern to push the new headers to
> linux-2.6/security/selinux/include or copy them manually,
> - Build the new kernel and policy that includes those definitions.

 ack.

 
> > 	 /* Check whether a task is allowed to perform a xen virtual machine
> > 	    operation. */
> > 	int xen_has_perm(struct task_struct *tsk, u32 perms)
> > 	{
> > 		struct task_security_struct *tsec;
> > 
> > 		tsec = tsk->security;
> > 
> > 		return avc_has_perm(tsec->sid, tsec->sid,
> > 				SECCLASS_XEN, perms, NULL, NULL);
> > 	}
> 
> Doesn't task_has_xen() sound better? ;)
 
 yes?

 yes - i get it :)


 okay, regarding the second argument to avc_has_perm(),
 i asked the nice xen developers if it'd be possible to
 associate a sid with each virtual machine.

 i mean, if nothing else, it's a matter of grabbing the
 number (id) of the xen machine being contacted and faking up
 a sid - sprintf(sid, "xen_vm_%d_t", xen_id);

 which is pretty yuk.

 how would i go about _not_ hacking something like that up?

 how would it be possible for the xen master machine to create
 a sid per xen machine?  xen_vm_0_t, xen_vm_1_t etc.

 *clueless*.

 l.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
