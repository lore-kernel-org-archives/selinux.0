Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84L9Vrf005442
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 17:09:31 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84L9Ub6000090
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 21:09:30 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC]integrity: SELinux patch
Date: Tue, 4 Sep 2007 17:08:03 -0400
Cc: Steve G <linux_4ever@yahoo.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        zohar@us.ibm.com, safford@watson.ibm.com
References: <604663.1384.qm@web51501.mail.re2.yahoo.com> <1188938810.5595.5.camel@localhost.localdomain>
In-Reply-To: <1188938810.5595.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709041708.05629.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 September 2007 16:46:50 Mimi Zohar wrote:
> Based on Stephen's request, I've removed the kernel integrity logging in
> the selinux integrity patch. I've added audit calls to IMA, which log PCR
> violations.  The integrity_audit() calls would be made from a LIM provider
> that implements integrity_verify_metadata() and integrity_verify_data().

And these were sent to linux-audit mail list for review?

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
