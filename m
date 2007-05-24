Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4ODsbTo005627
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 09:54:37 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4ODsYc3027921
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 13:54:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: AVC: IPv6 problems
Date: Thu, 24 May 2007 09:53:29 -0400
Cc: SELinux List <selinux@tycho.nsa.gov>
References: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com> <200705230927.09084.paul.moore@hp.com> <E60164DE-429F-4B6A-8C3C-8405BF7AD41F@sf-net.com>
In-Reply-To: <E60164DE-429F-4B6A-8C3C-8405BF7AD41F@sf-net.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705240953.29986.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, May 24 2007 1:04:09 am Stefan Schulze Frielinghaus wrote:
> On 23.05.2007, at 15:27, Paul Moore wrote:
> > On Wednesday, May 23 2007 8:21:27 am Stefan Schulze Frielinghaus
> >
> > wrote:
> >> On 22.05.2007, at 21:24, Paul Moore wrote:
> >>> On Tuesday, May 22 2007 2:22:09 pm Stefan Schulze Frielinghaus
> >>>
> >>> wrote:
> >>>> periodically I receive the following AVC denial:
> >>>>
> >>>> audit(1179815459.477:213): avc:  denied  { rawip_send } for
> >>>> saddr=fe80:0000:0000:0000:0211:d8ff:feea:XXXX
> >>>> daddr=fe80:0000:0000:0000:0211:24ff:fee1:YYYY netif=eth0
> >>>> scontext=system_u:system_r:kernel_t:s15:c0.c255
> >>>> tcontext=system_u:object_r:link_local_node_t:s0 tclass=node
> >>>
> >>> It's hard to say what the solution is because it most likely
> >>> depends on what
> >>> you are trying to do.  You might want to share your goals with the
> >>> list and
> >>> perhaps we can help, otherwise I would recommend you look at the MLS
> >>> reference policy interfaces.

Assuming you are not trying to enforce MLS access controls across the network 
using link_local_node_t you could always make it a trusted object:

 # this interface is defined in the mls.if file in reference policy
 mls_trusted_object(link_local_node_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
