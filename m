Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFAQIi019962
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:10:26 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOF8ugi019559
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:08:56 GMT
Subject: Re: xen 2.0 - adding selinux permissions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041124150927.GP5146@lkcl.net>
References: <20041123220352.GF5146@lkcl.net>
	 <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
	 <20041124150927.GP5146@lkcl.net>
Content-Type: text/plain
Message-Id: <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 10:06:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-24 at 10:09, Luke Kenneth Casson Leighton wrote:
>  okay, i must have misunderstood.
> 
>  i envisage creating a xen_has_perm() and _that_ means adding
>  something to security/selinux/include/av_permissions.h
>  #define XEN_VM_CREATE  0x00000001UL
>  #define XEN_VM_DESTROY 0x00000002UL, etc.
> 
>  and creating a SECCLASS_XEN?

Those header files are automatically generated.  To add new
classes/permissions:
- Check out a copy of linux-2.6 and selinux-usr from our sourceforge CVS
tree,
- cd selinux-usr/policy/flask
- Edit security_classes and access_vectors, adding your new class at the
end.
- Run make in that directory to generate the headers,
- Run make tokern to push the new headers to
linux-2.6/security/selinux/include or copy them manually,
- Build the new kernel and policy that includes those definitions.

And note that until we merge a patch from you reserving that security
class, someone else may come along and take that value away from you at
any time, at which point you'll have to re-base and rebuild.  Actually,
that reminds me to check on the status of such a patch for the
ipsec-related class.

> 	 /* Check whether a task is allowed to perform a xen virtual machine
> 	    operation. */
> 	int xen_has_perm(struct task_struct *tsk, u32 perms)
> 	{
> 		struct task_security_struct *tsec;
> 
> 		tsec = tsk->security;
> 
> 		return avc_has_perm(tsec->sid, tsec->sid,
> 				SECCLASS_XEN, perms, NULL, NULL);
> 	}

Doesn't task_has_xen() sound better? ;)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
