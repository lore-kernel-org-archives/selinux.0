Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2GjIok000507
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 11:45:18 -0500
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2GiQKL026507
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 16:44:28 GMT
Date: Thu, 2 Nov 2006 11:45:14 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "'Paul Moore'" <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <Pine.LNX.4.64.0611021140130.23444@d.namei>
Message-ID: <Pine.LNX.4.64.0611021144520.23444@d.namei>
References: <000f01c6fe91$bb0926d0$cc0a010a@tcssec.com>
 <Pine.LNX.4.64.0611021140130.23444@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Nov 2006, James Morris wrote:

> On Thu, 2 Nov 2006, Venkat Yekkirala wrote:
> 
> > > 1. What would the policy look like?
> > 
> > Let's say you secmark a packet coming from a certain host with
> > webonly_packet_t.
> > 
> > You could have a filter point defined as:
> > 
> > iptables -t filter -A FORWARD -d webserver -dport 80 -j SECFILTER --selctx
> > "system_u:object_r:webserver_t:s4-s5"
> > 
> > Your policy could say:
> > 
> > allow webonly_t webserver_t:secfilter { flow_out }
> 
> Is this contstruct needed for anything other than the forwarding case?  

In fact, this appears to be entirely indepdent to xfrm labeling...



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
