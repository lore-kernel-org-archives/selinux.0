Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAKKX3kd019037
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 15:33:03 -0500
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAKKX1oB028602
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2007 20:33:02 GMT
Date: Wed, 21 Nov 2007 07:32:57 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Joy Latten <latten@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: Problems with Labeled IPsec, IKE and ECN
In-Reply-To: <200711191517.34487.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0711210729560.31381@us.intercode.com.au>
References: <200711191517.34487.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Nov 2007, Paul Moore wrote:

> Needless to say this is a problem and we need to move away from using the 
> IKE/IPsec attribute value of "10" as soon as possible.  Further, simply 
> picking a new number is not a good solution, we should really petition IANA 
> to get an attribute number assigned for this purpose.  However, doing so will 
> most likely require documenting the Linux Labeled IPsec design and submitting 
> it to the IETF as a draft specification for approval[4].

How likely is this approach viable, given the moratorium on ISAKMP/IKE v1 
features?

>  If this is not 
> possible we will need to start investigating alternatives as "poaching" 
> existing standards is not a viable, maintainable solution.

Note (from http://www.iana.org/assignments/isakmp-registry)

"The values 32001-32767 are reserved for private use amongst
cooperating systems."

If we can't get an official number for use with IKEv1, then perhaps this 
will be our only option.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
