Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEG2IWl025904
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 11:02:19 -0500
Received: from e5.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEG2oKl014016
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 16:02:51 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBEG2m5T002885
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 11:02:48 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBEG2cxq278176
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 11:02:44 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBEG2b6W010531
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 11:02:37 -0500
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
From: Joy Latten <latten@austin.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Klaus Weidner <klaus@atsec.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <458075BA.5030007@hp.com>
References: <20061212072825.GA3362@w-m-p.com> <458067B3.20107@hp.com>
	 <20061213214047.GC3362@w-m-p.com>  <458075BA.5030007@hp.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:48:39 -0600
Message-Id: <1166111320.12468.132.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-12-13 at 16:50 -0500, Paul Moore wrote:
> Klaus Weidner wrote:
> > On Wed, Dec 13, 2006 at 03:50:59PM -0500, Paul Moore wrote:
> > 
> >>The bad news is that I realized we never added NetLabel receive permissions to
> >>any of the application domains (try to telnet into a machine with NetLabel);
> >>only the user domains have the NetLabel receive permissions.  As a result I
> >>wasn't able to try any more elaborate tests without fixing the policy.  It will
> >>probably take a little while to get a patch out to address this as there are a
> >>lot of domains which need to be changed; that said I'm probably about a third of
> >>the way through at this point.
> >>
> >>In case anyone is interested, the policy changes boil down to the following:
> >>
> >> ifdef(`enable_mls',`
> >>        corenet_tcp_recv_netlabel(app_domain_t)
> >>        corenet_udp_recv_netlabel(app_domain_t)
> >> ')
> > 
> > 
> > Have you considered adding those lines to the existing interfaces in
> > policy/modules/kernel/corenetwork.if.in instead? For example, telnetd
> > currently uses corenet_tcp_sendrecv_all_if(telnetd_t), and you could make
> > that interface provide the needed netlabel rights also.
> 
> I did consider doing something similar but I figured sticking with the existing
> refpolicy convention was the going to be the path of least resistance and in the
> "userdom_basic_networking_template" code the corenet_* NetLabel permissions are
> kept separate from the rest of the corenet_* permissions.  It makes more sense
> conceptually too I think.
> 
> I added Chris to the CC line as he might be able to provide some thoughts on
> what he would like to see.
> 
> > Do we need something equivalent for labeled IPSEC?
> 
> I would think so, but I believe Joy said she is working on that; however, the
> policy for NetLabel and labeled IPsec is radically different so labeled IPsec
> may have a different approach.
> 
> With NetLabel you only need a single allow rule for each domain wishing to
> receive labeled network traffic:
> 
>  allow my_domain_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;
> 
> With labeled IPsec it's a bit more involved.
> 
Yes, it was a bit more involved for labeled IPsec. 
I have completed the policy changes required for labeled ipsec 
and it appears to be working ok so far. I will send out the
patch sometime today. I had to touch a lot of files... so it
took me a while. 

Klaus, I am in the process of patching my mls policy with
your changes and running a simple test to ensure all the
changes are working. I hope to run a stress test on 57
with the policy changes.

Regards,
Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
