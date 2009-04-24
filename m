Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3OLshEU020049
	for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2009 17:54:43 -0400
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3OLsgEl001595
	for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2009 21:54:42 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3OLpFlT000763
	for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2009 15:51:15 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n3OLsfOt038282
	for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2009 15:54:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n3OLseGv007172
	for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2009 15:54:41 -0600
Subject: Re: labeled network aware kernel
From: Joy Latten <latten@austin.ibm.com>
Reply-To: latten@austin.ibm.com
To: Mark Webb <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com>
	 <C61510C5.A6A7F%csellers@tresys.com>
	 <9f066ee90904222001xb31b39ajf6953ca0767f3494@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 24 Apr 2009 16:44:06 -0500
Message-Id: <1240609446.13724.20.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Mark,

If interested, there are ietf drafts for labeled ipsec,
http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev1-security-context-00.txt
and
http://www.ietf.org/internet-drafts/draft-jml-ipsec-ikev2-security-context-00.txt.

Also, I'd be happy to help by answering any questions. 

regards,
Joy Latten

On Wed, 2009-04-22 at 23:01 -0400, Mark Webb wrote:
> I am looking at the IPSec-based labeled networking.
> 
> BTW.  I will be at the Tresys Advanced Policy course next week.  Is
> any of this covered there?
> 
> Thanks,
> 
> On Wed, Apr 22, 2009 at 6:21 PM, Chad Sellers <csellers@tresys.com> wrote:
> > Josh's article talks about IPSec labeled networking (as well as using
> > SECMARK which provides firewall-level networking controls), as opposed to
> > Netlabel labeled networking. I played with the IPSec-based stuff in Fedora 9
> > and everything was there, so I'd imagine it's still there in F10. Just make
> > sure you install ipsec-tools.
> >
> > Chad Sellers
> >
> >
> > On 4/22/09 7:26 AM, "Mark Webb" <elihusmails@gmail.com> wrote:
> >
> >> I am interested in experimenting with the labeled networking that SE
> >> Linux offers.  I am reading through Josh Brindle's blog
> >>
> >> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/
> >>
> >> My question is, how do I know if my kernel is capable of supporting
> >> this?  I am currently running Fedora 10 with all the latest updates
> >> but not sure how to check.
> >>
> >> Also if I compile a kernel from source, is there anything that needs
> >> to be done in the configuring of the kernel build to enable the
> >> labeled networking?
> >>
> >> Thanks,
> >> Mark
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> >> the words "unsubscribe selinux" without quotes as the message.
> >
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
