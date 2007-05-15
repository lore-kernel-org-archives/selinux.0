Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4FFcK0g030051
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 11:38:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4FFcKdK019626
	for <selinux@tycho.nsa.gov>; Tue, 15 May 2007 15:38:20 GMT
Subject: Re: apcupsd policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <463F4D58.7000702@redhat.com>
References: <200704201926.l3KJQuOH027268@redsox.boston.devel.redhat.com>
	 <1178549446.25271.6.camel@sgc>  <463F4D58.7000702@redhat.com>
Content-Type: text/plain
Date: Tue, 15 May 2007 11:37:37 -0400
Message-Id: <1179243457.725.0.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-07 at 12:01 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > Merged, except for the cgi part.  Also some reordering.  The apcupsd
> > port definition was missing so I commented out the relevant lines for
> > now.
> >
> Added the network defs.
> apcupsd signals itself also.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
