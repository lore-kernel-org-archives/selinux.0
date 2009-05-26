Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QMWmAI025661
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 18:32:48 -0400
Received: from g5t0009.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QMX1qO025953
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 22:33:01 GMT
From: Paul Moore <paul.moore@hp.com>
To: Nigel Rumens <wooky@btconnect.com>
Subject: Re: selinux and sctp
Date: Tue, 26 May 2009 18:32:44 -0400
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>
In-Reply-To: <4A1A7DF6.8080706@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200905261832.44705.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 25 May 2009 07:16:06 am Daniel J Walsh wrote:
> On 05/24/2009 06:00 AM, Nigel Rumens wrote:
> > Hi,
> >
> > Does selinux understand sctp?
> >
> > When I run (for example)
> >
> > sctp_darn -H 0 -P 9876 -l
> >
> > It results in an avc denial message which tells me the target object is
> > of type None[rawip_socket]
> >
> > Also semanage port -l shows only udp and tcp
> >
> > Machine tested on was F11 (fully updated) - I also tried it F10 with the
> > same results

Hi Nigel,

Can you send us the AVC denial messages?  If you are running a recent kernel 
(F11/Rawhide should qualify and F10 will likely as well) there should only be 
a handful of areas where you should be hitting transport protocol specific 
code that isn't SCTP aware in the kernel, it would be nice to verify that so 
we could better identify what work needs to be done.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
