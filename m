Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94ExpVN017128
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 10:59:51 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94ExFCa014465
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 14:59:16 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com, russell@coker.com.au
Subject: Re: [redhat-lspp] Re: gpm & mls
Date: Wed, 4 Oct 2006 11:00:27 -0400
Cc: Steve G <linux_4ever@yahoo.com>, Chad Hanson <chanson@TrustedCS.com>,
        selinux@tycho.nsa.gov
References: <20061002144738.61005.qmail@web51515.mail.yahoo.com> <200610030844.25270.russell@coker.com.au>
In-Reply-To: <200610030844.25270.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610041100.27191.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 02 October 2006 18:44, Russell Coker wrote:
> It shouldn't be difficult to have a configuration option for GPM to not
> allow cut/paste to different VCs.

NACK.

This should not be too hard to do, the internal buffer needs to carry the 
label of the screen it was copied from and a dominance check be done before 
doing the paste. We also need to record avc denials to the audit system.

> That plus an option to flush the buffer on logout 

Yep.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
