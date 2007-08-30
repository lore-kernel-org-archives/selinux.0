Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7ULChgk024067
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 17:12:53 -0400
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7ULCguK024373
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 21:12:43 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7ULE6Ma021213
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 17:14:06 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l7ULCgBP635916
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 17:12:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l7ULCgCc012976
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 17:12:42 -0400
Date: Thu, 30 Aug 2007 16:12:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
Message-ID: <20070830211243.GA20414@sergelap.austin.ibm.com>
References: <1188340501.11528.14.camel@localhost.localdomain> <20070830205810.GA7692@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830205810.GA7692@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
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
> 
> Just curious - wouldn't you want to also define a 'update' permission to
> allow policy to permit some domains to update xattrs?  Or does that not
> make sense?

Oops, I see, that's what measure is...   nm then.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
