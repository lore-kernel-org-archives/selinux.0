Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA1FeHdX022722
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 10:40:17 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kA1FdPOY004835
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 15:39:27 GMT
Subject: Re: New MLS constraint?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Matt Anderson <mra@hp.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4547EE97.5040101@hp.com>
References: <4533B60E.8010802@hp.com> <1161020854.26428.32.camel@sgc>
	 <4547EE97.5040101@hp.com>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 10:41:00 -0500
Message-Id: <1162395661.31675.165.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 19:47 -0500, Matt Anderson wrote:
> Christopher J. PeBenito wrote:
> > We could add another 'or' on the above constraint:
> > 
> > or ( (t2 == mlsfilewrite_in_range) and (l1 dom l2) and (h1 domby h2) )
> > 
> > I believe that would be the constraint you were looking for.  I don't
> > like the name of that attribute, but I couldn't come up with a better
> > one off the top of my head. :)
> > 
> 
> Attached is a patch which I've tested against selinux-policy-2.4.2-1
> that implements this additional constraint.  The name is still a bit
> forced, but it works.

Merged.  Moved the printer_device_t line to devices.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
