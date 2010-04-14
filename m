Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EIXoUV001850
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 14:33:50 -0400
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EIYgQk029650
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 18:34:42 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Benedict, Phillip M" <phillip.m.benedict@lmco.com>
Subject: Re: MLS telnet question
Date: Wed, 14 Apr 2010 14:33:47 -0400
Cc: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com> <201004141030.47982.paul.moore@hp.com> <6235CF4DC66FD5478F0E350E17C202FF251F46FC60@HVXMSP3.us.lmco.com>
In-Reply-To: <6235CF4DC66FD5478F0E350E17C202FF251F46FC60@HVXMSP3.us.lmco.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201004141433.47312.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 14 April 2010 01:34:11 pm Benedict, Phillip M wrote:
> Thanks,
> 
> 	So one more question if you please...
> 	I seem to recall reading something to the effect of Labeled IPSEC only
> working between two or more Linux/SELinux systems.

Yes, labeled IPsec only works between two SELinux systems running the same, or 
very similar policies.

> 	Can Labeled IPSEC be configured to apply static labels to incoming
> packets?

No.

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Wednesday, April 14, 2010 10:31 AM
> To: Benedict, Phillip M
> Cc: Michal Svoboda; selinux@tycho.nsa.gov
> Subject: Re: MLS telnet question
> 
> On Wednesday 14 April 2010 08:23:02 am Benedict, Phillip M wrote:
> > Thanks, I will take another look at Netlabel's fallback/static labeling.
> > So how can I verify if my kernel (the default RHEL 5.3 kernel 2.6.128)
> > has Netlabel support?
> 
> While the RHEL5.x kernels have NetLabel support, it is very basic as it
> predates most of the labeled networking improvements that have been made
> in the past years.  Unfortunately, this means that the fallback/static
> peer label feature is not part of RHEL5.
> 
> > Also I currently have separate ssh daemons running at certain
> > sensitivities (runcon) and bound to specific IP addresses (separate
> > sshd_config files). Will fallback labeling impact my ssh setup?
> 
> You'll need to be more specific about what you mean by "impact".
> 
> Will NetLabel affect how you bind the multiple SSH daemons?  No.  Will
> NetLabel affect how the SSH daemons are labeled?  No.  Will NetLabel allow
> you to assign peer labels to incoming SSH traffic?  Yes.  Will this mean
> I'll need to change my SELinux policy to add the necessary controls?  It
> depends.
> 
> > -----Original Message-----
> > From: Paul Moore [mailto:paul.moore@hp.com]
> > Sent: Tuesday, April 13, 2010 5:55 PM
> > To: Benedict, Phillip M
> > Cc: Michal Svoboda; selinux@tycho.nsa.gov
> > Subject: Re: MLS telnet question
> > 
> > On Tuesday 13 April 2010 12:42:36 pm Michal Svoboda wrote:
> > > Benedict, Phillip M wrote:
> > > >    The network does not carry any cipso data for evaluation by my
> > > >    server, so I don’t think I can use netlabel.
> > > 
> > > You can use the fallback label feature that can assign labels
> > > statically per remote IP.
> > 
> > NetLabel fallback/static label example configuration:
> >  * http://paulmoore.livejournal.com/1758.html
> 
> --
> paul moore
> linux @ hp

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
