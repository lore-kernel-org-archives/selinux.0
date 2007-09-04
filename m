Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84KfH8q003196
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 16:41:17 -0400
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84KfGb6023433
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 20:41:16 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l84KfBuC026126
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 16:41:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l84KfB5H467776
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:41:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l84KfAa7012113
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 14:41:10 -0600
Subject: Re: [RFC]integrity: SELinux patch
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: James Morris <jmorris@namei.org>, sgrubb@redhat.com,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com
In-Reply-To: <604663.1384.qm@web51501.mail.re2.yahoo.com>
References: <604663.1384.qm@web51501.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Tue, 04 Sep 2007 16:46:50 -0400
Message-Id: <1188938810.5595.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-07-18 at 08:05 -0700, Steve G wrote:
> 
> >> No, it isn't being audited, but should be.  The question is what type of audit
> 
> >> message would be appropriate here.  It could be the normal denied/granted 
> >> message, but that would be confusing as this isn't based on a permission or 
> >> capability check, but an integrity error.  Any suggestions how to handle this 
> >> here and in the other places? 
> 
> MRPP places some requirements on intergrity checking. Maybe it tells you more
> information about what's required. More info:
> 
> http://www.niap-ccevs.org/cc-scheme/pp/pp.cfm?id=PP_OS_ML_MR2.0_V1.91
>
> >If integrity is being enforced, then the final AVC denial should include 
> >information that it was because of an integrity failure.
> 
> Might ought to be an integrity audit record type rather than avc. This way
> aureport can separate it out for its summary report. In
> /usr/include/linux/audit.h is this note:
> 
>  * 1800 - 1999 future kernel use (maybe integrity labels and related events)
> 
> So, we could assign the 1800 block to kernel integrity checking. I think we'd
> need information access decision, creation, modification, and deletion of
> integrity information/labels. We also probably need the ability to audit by
> integrity, too. For a detailed audit discussion, I'd recommend linux-audit mail
> list or at least cc'ing it

As a first take, the "integrity: API, hooks, placement and dummy provider" patch
posted on Aug. 28th, adds the following auditing integrity support.  

Added to audit.h:
#define AUDIT_INTEGRITY         1800    /* Integrity verify success/failure */
#define AUDIT_INTEGRITY_ERR     1801    /* Internal integrity errors */
#define AUDIT_INTEGRITY_PCR     1802    /* PCR invalidation errors */

Added to integrity.h:
void integrity_audit(char *function, const unsigned char *fname, char *cause);
void integrity_audit_pcr(const unsigned char *fname, char *cause);
void integrity_audit_err(char *cause);

These functions are defined in security/integrity_audit.c.

Based on Stephen's request, I've removed the kernel integrity logging in 
the selinux integrity patch. I've added audit calls to IMA, which log PCR 
violations.  The integrity_audit() calls would be made from a LIM provider 
that implements integrity_verify_metadata() and integrity_verify_data().

Mimi Zohar




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
