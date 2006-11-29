Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU057xP006853
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 19:05:07 -0500
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU03NbM014035
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 00:03:24 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAU05TI1000333
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 19:05:29 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAU05Tk6549526
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 17:05:29 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAU05SjL003714
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 17:05:29 -0700
Subject: RE: [redhat-lspp] Re: labeled ipsec policy
From: Joy Latten <latten@austin.ibm.com>
To: vyekkirala@TrustedCS.com
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>, redhat-lspp@redhat.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <001701c713f6$e02b11b0$cc0a010a@tcssec.com>
References: <001701c713f6$e02b11b0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:51:56 -0600
Message-Id: <1164844316.17737.513.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 14:42 -0600, Venkat Yekkirala wrote:
> > I'm not very sure how users will use the SPD labeling.  I suspect that
> > they will be labeled with probably the other side's domain type.  For
> > example, if httpd_t and mozilla_t are connected, the SPD would be
> > mozilla_t on the http machine and httpd_t on the mozilla machine.
> >
> 
> In the simplest case, you would just have a generic "labeled_ipsec_t" Type
> that would be specified for all the spd rules that pertain to labeled-ipsec.
> All the different domains that need to use labeled-ipsec would then polmatch
> to labeled_ipsec_t.
> 
> The SAs will always and automatically be using the originating domain Type.
> So, the SA from the client to server would be auto-labeled mozilla_t,
> rss_aggregator_t, etc. (on both ends), and the SA from the server to client
> would be auto-labeled httpd_t (again on both ends).

Ok, so then I will go with my original idea of a type ipsec_spd_t and
create an interface that allows sysadmins to create selinux policy for
"polmatching" ipsec SAs to the ipsec policy type, ipsec_spd_t. Thanks!!

Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
