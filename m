Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6GN9LO9026996
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 19:09:21 -0400
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6GN9FwV003617
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 23:09:15 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6GN3TQI012553
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 19:03:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6GN99W2234010
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 17:09:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6GN98Pi030654
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 17:09:09 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com
In-Reply-To: <469BBB9B.3040108@manicmethod.com>
References: <1184594240.5860.5.camel@localhost.localdomain>
	 <469BBB9B.3040108@manicmethod.com>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 19:13:06 -0400
Message-Id: <1184627586.10795.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-16 at 14:40 -0400, Joshua Brindle wrote:
> Mimi Zohar wrote:
> > This is a first attempt to verify and measure file integrity, by
> > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > We are planning on posting the corresponding LIM and IMA patches to
> > LKML, but would like comments/suggestions here first, particularly
> > in regards to the policy checking code in selinux_measure() called 
> > from selinux_inode_permission().
> >
> > SELINUX_ENFORCE_INTEGRITY can be configured to either verify and
> > enforce integrity or to just log integrity failures. The default
> > is to just log integrity failures.
> >
> >   
> I haven't reviewed the patch yet but reference to the above comments. 
> This should be controlled with policy I think, its tricky though and I 
> haven't thought about all the ramifications yet, I'll get back to this 
> after I've thought about it.

Without the SELINUX_INTEGRITY_ENFORCE option enabled, everything is
logged, nothing is denied.  This is meant to be similar to the selinux
'enforcing' option.  Currently it is only a compile option, perhaps 
just as enforcing is a runtime option, it should be a runtime option as
well.

> > The integrity of the SELinux metadata is verified when the xattr
> > is initially retrieved.  On an integrity failure, assuming that
> > integrity verification is enforced, normal error processing occurs.
> >
> > By default, all executables and all files that are mmap'ed executable
> > are measured. This patch extends the file class with 'measure'.
> > Additional files can be measured in selinux_inode_permission()
> > based on a FILE__MEASURE policy. (As the policy call is causing too
> > many files to be measured, it is commented out.) For example, to
> > measure kernel modules add:
> >   
> I'd like to say that if SELinux is controlling whether measurements 
> happen or not I don't think there should be a 'default' policy in the 
> module. Being able to avoid the measurement overhead for domains that we 
> don't care about would be a win, fine grained as well as course grained 
> measurement selections can be done with SELinux.

Ok. I can understand that as long as SELinux is making some measurement 
decisions based on policy, it could just as easily make all of the 
measurement decisions. At the moment though, I am having problems with 
the avc_has_perm_noaudit() call in inode_permission.  Without defining a
'measure' policy, it measures a lot of files. Is this because the system
is running with a targeted policy? 

Are you suggesting that there is no need for the measurement calls in
file_mmap()/bprm_check_security() and that there should only be the one  
measurement call in inode_permission(), which is based on policy, or 
are you suggesting that the measurement calls in bprm_check_security() 
and file_mmap() be based on policy?

Thanks!

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
