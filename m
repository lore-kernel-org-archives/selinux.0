Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
In-Reply-To: <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
References: <1188340501.11528.14.camel@localhost.localdomain>
	 <46D4F337.1030704@manicmethod.com>
	 <1188382494.6129.35.camel@localhost.localdomain>
	 <1190230883.7323.3.camel@localhost.localdomain>
	 <1190235840.25863.98.camel@moss-spartans.epoch.ncsc.mil>
	 <1190252058.7323.33.camel@localhost.localdomain>
	 <1190293949.12553.23.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 10:02:39 -0400
Message-Id: <1190383359.11091.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-20 at 09:12 -0400, Stephen Smalley wrote:

> In any event, I don't think we are really at the point of just cleaning
> up implementation nits in these integrity patches - I think there needs
> to be more discussion and work on the overall design, hook placement and
> coverage, how it will be used in practice, who would use it, etc.  Which
> goes beyond just how it would be integrated with selinux.  I haven't
> really seen a compelling argument and concept of operations so far.  As
> a general concept, I can see potential value in integrity measurement
> (although lots of pitfalls too), but I'm not sure that this approach is
> going to yield that value.
> 
> I had hoped that others more involved or interested in integrity
> measurement might have weighed in on the discussion (hint, hint).

We were just about to post the latest LIM patches as an RFC to LMKL.  If
we can get a discussion going here first, that would be great.  I will
repost the latest set of patches.

In terms of design, the integrity provider would be responsible for
maintaining file integrity information, which an LSM module could query
via the LIM integrity_verify_metadata/data() API.  For now, we are
releasing an IMA-only integrity provider, which implements the LIM
integrity_measure() API.  When integrity_measure() is called, IMA
submits the measurement (hash) of the file to the TPM chip, for
inclusion in one of the chip's Platform Configuration Registers (PCR).
IMA also keeps a list of all file names and hashes that have been
submitted to the TPM, which can be viewed through securityfs.

We have a number of enterprise customers who use the old LSM based IMA
(http://sourceforge.net/projects/linux-ima).  They use it to monitor
file integrity and version level on large server farms. Their top two
requests have been to get IMA off of LSM, so that they can use it with
Selinux and AppArmor, and to get it upstream, so that it will be
supported. These customers are using just the measurement/attestation
portion of LIM. The verification of labels and data is more oriented to
enterprise verification of configuration of the labels, and to protect
clients and servers from off-line attacks.

This is a request for comments for updates to the LIM integrity 
service framework, previously accepted into -mm, an IMA-only 
integrity service provider, and a SELinux integrity patch. 

Patch 1/4 integrity: LIM api, hooks, and dummy provider
Patch 2/4 integrity: IMA service provider
Patch 3/4 integrity: TPM internal kernel interface
Patch 4/4 integrity: SELinux LIM calls

Mimi Zohar
David Safford



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
