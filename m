Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7TA9K1H020665
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 06:09:31 -0400
Received: from e34.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7TA9JNP019065
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 10:09:20 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7TA9IR4016962
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 06:09:18 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7TA9Ha4486844
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 04:09:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7TA9Gk1013286
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2007 04:09:17 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
In-Reply-To: <46D4F337.1030704@manicmethod.com>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
Content-Type: text/plain
Date: Wed, 29 Aug 2007 06:14:54 -0400
Message-Id: <1188382494.6129.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-29 at 00:16 -0400, Joshua Brindle wrote:
> Mimi Zohar wrote:
> > This is a second attempt to verify and measure file integrity, by
> > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > This posting addresses comments previously made on this list. 
> > I will also post the current set of LIM patches, as well as an
> > initial integrity.te example. 
> >
> > The integrity of the SELinux metadata is verified when the xattr
> > is initially retrieved.  On an integrity failure, normal selinux 
> > error processing occurs.
> >
> > This patch defines a new 'integrity' class with the permission 
> > 'measure'.  Measurement calls are made in selinux_file_mmap(), 
> > selinux_bprm_check_security, and selinux_inode_permission(),
> > based on policy.  (Additional calls might be required.)
> >
> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> > <snip>
> >  
> > Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
> > ===================================================================
> > --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_permissions.h
> > +++ linux-2.6.23-rc3-mm1/security/selinux/include/av_permissions.h
> > @@ -824,3 +824,4 @@
> >  #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
> >  #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
> >  #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
> > +#define INTEGRITY__MEASURE                        0x00000001UL
> > Index: linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
> > ===================================================================
> > --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/av_perm_to_string.h
> > +++ linux-2.6.23-rc3-mm1/security/selinux/include/av_perm_to_string.h
> > @@ -159,3 +159,4 @@
> >     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
> >     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
> >     S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
> > +   S_(SECCLASS_INTEGRITY, INTEGRITY__MEASURE, "measure")
> >   
> 
> Do you really need another object class for this? What is wrong with the 
> file object class? eg., a rule like:
> 
> allow insmod_t modules_object_t : file { read measure };
> would require a measurement.

The original version attempted to add file measure, but even without
adding measure to the policy, files were being measured.  The following
is taken from Stephen's July 19th posting.

> > > Unfortunately for you, policy uses "*" in allow rules for unconfined
> > > domains, and this means that your new permission is actually allowed by
> > > existing policies (because the policy compiler is just turning "*" into
> > > ~0UL and likewise turning "~{ a b c}" into the complement of that set,
> > > so the access vectors can have the bits turned on even if the permission
> > > wasn't defined yet.
> 
> > Thank you for the explanation.  At OLS, there was a suggestion to use
> > avc_has_perm_noaudit().  As this is not measuring the appropriate files,
> > do you, or anyone else, have any other recommendations?

> Defining a new class for this purpose will free you from having any
> legacy policies implicitly granting the permission.

> > Index: linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
> > ===================================================================
> > --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/flask.h
> > +++ linux-2.6.23-rc3-mm1/security/selinux/include/flask.h
> > @@ -50,6 +50,7 @@
> >  #define SECCLASS_KEY                                     58
> >  #define SECCLASS_DCCP_SOCKET                             60
> >  #define SECCLASS_MEMPROTECT                              61
> > +#define SECCLASS_INTEGRITY                               62
> >  
> >  /*
> >   * Security identifier indices for initial entities
> > Index: linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
> > ===================================================================
> > --- linux-2.6.23-rc3-mm1.orig/security/selinux/include/class_to_string.h
> > +++ linux-2.6.23-rc3-mm1/security/selinux/include/class_to_string.h
> > @@ -64,3 +64,4 @@
> >      S_(NULL)
> >      S_("dccp_socket")
> >      S_("memprotect")
> > +    S_("integrity")
> > Index: linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > ===================================================================
> > --- linux-2.6.23-rc3-mm1.orig/security/selinux/ss/services.c
> > +++ linux-2.6.23-rc3-mm1/security/selinux/ss/services.c
> > @@ -305,12 +305,12 @@ static int context_struct_compute_av(str
> >  		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
> >  			tclass = SECCLASS_NETLINK_SOCKET;
> >  
> > -	if (!tclass || tclass > policydb.p_classes.nprim) {
> > -		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > -		       tclass);
> > -		return -EINVAL;
> > -	}
> > -	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > +//	if (!tclass || tclass > policydb.p_classes.nprim) {
> > +//		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
> > +//		       tclass);
> > +//		return -EINVAL;
> > +//	}
> > +//	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> >  
> >   
> 
> Err? Did you mean to submit it like this? This should be fixed by Eric's 
> patch to handle unknown classes anyway.

I'm working off the latest -mm tree and that patch hasn't made it in yet,
as well as some other patches.  For example, additional security class 
numbers have been defined.  So I will need to update SECCLASS_INTEGRITY
as well. The above code was added in order to test the patch. Once the 
basic integrity concept has been reviewed and accepted, I will repost 
based on the latest selinux development source tree.

> >  	/*
> >  	 * Initialize the access vectors to the default values.
> > @@ -321,6 +321,10 @@ static int context_struct_compute_av(str
> >  	avd->auditdeny = 0xffffffff;
> >  	avd->seqno = latest_granting;
> >  
> > +	if (!tclass || tclass > policydb.p_classes.nprim)
> > +		return 0;
> > +	tclass_datum = policydb.class_val_to_struct[tclass - 1];
> > +
> >   
> 
> Ditto.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
