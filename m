Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7VD9atb006178
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 09:09:36 -0400
Received: from e33.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7VD9Zjc000414
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 13:09:35 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7VD9ZIb030183
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 09:09:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7VD9ZPG465160
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 07:09:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7VD9Yrq020623
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2007 07:09:34 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Mimi Zohar <selinux@tycho.nsa.gov>, zohar@us.ibm.com,
        safford@watson.ibm.com, sailer@us.ibm.com
In-Reply-To: <20070830211243.GA20414@sergelap.austin.ibm.com>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <20070830205810.GA7692@sergelap.austin.ibm.com>
	 <20070830211243.GA20414@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 31 Aug 2007 09:15:14 -0400
Message-Id: <1188566114.10618.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 16:12 -0500, Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > > This is a second attempt to verify and measure file integrity, by
> > > adding the new Linux Integrity Modules(LIM) API calls to SElinux.
> > > This posting addresses comments previously made on this list. 
> > > I will also post the current set of LIM patches, as well as an
> > > initial integrity.te example. 
> > > 
> > > The integrity of the SELinux metadata is verified when the xattr
> > > is initially retrieved.  On an integrity failure, normal selinux 
> > > error processing occurs.
> > > 
> > > This patch defines a new 'integrity' class with the permission 
> > > 'measure'.  Measurement calls are made in selinux_file_mmap(), 
> > > selinux_bprm_check_security, and selinux_inode_permission(),
> > > based on policy.  (Additional calls might be required.)
> > 
> > Just curious - wouldn't you want to also define a 'update' permission to
> > allow policy to permit some domains to update xattrs?  Or does that not
> > make sense?
> 
> Oops, I see, that's what measure is...   nm then.

A LIM provider that implements integrity_verify_metadata/data would protect 
its own integrity xattrs, just as an LSM module protects its own xattrs, but 
that is not an SElinux issue.  Based on a 'measure' policy, SELinux decides
whether or not to add a measurement to the measurement list and extend the 
PCR value.

Mimi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
