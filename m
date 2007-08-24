Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7OEBgM0023939
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 10:11:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7OEBfbR029267
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 14:11:41 GMT
Subject: Re: MLS directory write constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: dwalsh@redhat.com, sgrubb@redhat.com,
        SELinux Mail List <selinux@tycho.nsa.gov>, joe@nall.com
In-Reply-To: <20070823230519.GC23508@w-m-p.com>
References: <1187613297.27524.10.camel@gorn>
	 <20070820205258.GA23508@w-m-p.com> <1187701836.13874.5.camel@gorn>
	 <20070823230519.GC23508@w-m-p.com>
Content-Type: text/plain
Date: Fri, 24 Aug 2007 14:10:44 +0000
Message-Id: <1187964644.13874.151.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 18:05 -0500, Klaus Weidner wrote:
> On Tue, Aug 21, 2007 at 09:10:23AM -0400, Christopher J. PeBenito
> wrote:
> > I see that the constraints are different in the 2.4.6-67 LSPP policy.
> > Is this the final one?  I want to make sure that the LSPP policy changes
> > have been integrated upstream.
> 
> selinux-policy-2.4.6-67.el5 is the evaluated version, that's the one that
> is known to match LSPP requirements. The version in the older thread that
> I linked to wasn't final yet, we had made some minor modifications last
> year to get to the final version. Please use the
> selinux-policy-2.4.6-67.el5 constraints for upstream if possible.

I have updated the refpolicy constraints with the above policy's
constraints.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
