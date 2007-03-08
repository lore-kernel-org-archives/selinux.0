Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EBN49003353
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:11:23 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l28EBMko029313
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:11:22 GMT
Subject: Re: Don't audit restart of nscd daemon in strict policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <45EF1EB9.3030307@redhat.com>
References: <200702261729.l1QHTPdT030641@localhost.localdomain>
	 <1173196621.917.0.camel@sgc>  <45EDB652.90306@redhat.com>
	 <1173284638.10747.15.camel@sgc>  <45EF1EB9.3030307@redhat.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 09:11:46 -0500
Message-Id: <1173363106.10747.30.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-07 at 15:21 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2007-03-06 at 13:43 -0500, Daniel J Walsh wrote:
> >   
> >> Christopher J. PeBenito wrote:
> >>     
> >>> On Mon, 2007-02-26 at 12:29 -0500, dwalsh@localhost.localdomain wrote:
> >>>       
> >>>> +',`
> >>>> +    userdom_dontaudit_use_sysadm_ttys(nscd_t)
> >>>> +    userdom_dontaudit_use_sysadm_ptys(nscd_t)
> >>>>         
> >>> This should go with a run interface, then you get the transition, the
> >>> role and these dontaudits.
> >>>   
> >>>       
> >> Ok how about this one.

Yes thats it, merged.  I fixed the groupadd one, which was in the
domtrans interface rather than run.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
