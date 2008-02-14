Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1E3ohds029093
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 22:50:43 -0500
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1E3og6g011383
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 03:50:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 3/4] REFPOL: Remove the unlabeled_t SECMARK policy in kernel_sendrecv_unlabeled_association
Date: Wed, 13 Feb 2008 22:50:32 -0500
Cc: selinux@tycho.nsa.gov
References: <20080208212534.491651808@hp.com> <20080208212825.408095221@hp.com> <1202827041.30706.7.camel@gorn>
In-Reply-To: <1202827041.30706.7.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802132250.32516.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 February 2008 9:37:21 am Christopher J. PeBenito wrote:
> On Fri, 2008-02-08 at 16:25 -0500, paul.moore@hp.com wrote:
> > plain text document attachment (refpol-secmark_perms_fix)
> > There is really no need for the SECMARK policy hack in the
> > kernel_sendrecv_unlabeled_association() interface since we already have
> > an interface call, kernel_sendrecv_unlabeled_packets(), which handles the
> > unlabeled SECMARK case.  Remove the hack and use the
> > kernel_sendrecv_unlabeled_packets() where appropriate.
>
> I don't think this is any better as, in reality, there should be no
> mixing of secmark rules with labeled networking rules since they are
> orthogonal.

First, thanks for merging the other changes.  Second, I suppose you are right 
about these changes, mixing them (never thought about it that way which is 
kinda funny everything considered) probably isn't the best thing to do long 
term.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
