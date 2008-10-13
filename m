Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9DAaSW1004745
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 06:36:28 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9DAaRGA009280
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 10:36:28 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Capabilities audit field
Date: Mon, 13 Oct 2008 06:35:58 -0400
Cc: selinux@tycho.nsa.gov
References: <200810120907.07511.sgrubb@redhat.com> <alpine.LRH.1.10.0810131009520.16356@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810131009520.16356@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810130635.58500.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 12 October 2008 19:12:47 James Morris wrote:
> On Sun, 12 Oct 2008, Steve Grubb wrote:
> > I recently found out that the kernel now allows more than 32
> > capabilities. This means I need to update the audit code that inteprets
> > this value given from SE Linux. When I looked over the 2.6.27 kernel
> > code, I found that SE Linux has not updated the capabilities code. Its
> > still being kept as a simple integer in avc.h, but everywhere else I look
> > in the kernel has moved to kernel_cap_t, which is an array. Are patches
> > for moving to kernel_cap_t scheduled for 2.6.28? Are there security
> > implications for not being able to access or control capabilities > 32?
>
> The AVC can opnly handle 32-bit vectors, so a capability2 class was added
> to handle capabilities over 32-bits.
>
> See
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h
>=b68e418c445e8a468634d0a7ca2fb63bbaa74028

Then does this need some updating in avc.c ?

 570                case AVC_AUDIT_DATA_CAP:
 571                        audit_log_format(ab, " capability=%d", a->u.cap);
 572                        break;


Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
