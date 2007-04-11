Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BFIbYR027331
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 11:18:37 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BFIZp1009353
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 15:18:36 GMT
From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Wed, 11 Apr 2007 11:17:42 -0400
Cc: "Joshua Brindle" <method@manicmethod.com>, "John Wan" <J.Wan@mbs.edu>,
        selinux@tycho.nsa.gov
References: <000301c77c4b$83b18870$cc0a010a@tcssec.com>
In-Reply-To: <000301c77c4b$83b18870$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704111117.42747.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, April 11 2007 11:10:16 am Venkat Yekkirala wrote:
> Just FYI-I did propose filtering in the filter table in the past,
> and this has been on my todo list.
>
> "Implementation issues aside, lately I have been wondering about doing
> something in the filter table using something we could call secfilter
> or so.
>
> You would still use secmark to label the packets, but they (along with
> any external labels) could get filtered in the secfilter module. This
> way we could control what external labels could come thru from what peers.
> For internal labels it would be more of an assurance thing. This would also
> automatically take care of forwarding controls."

This is what I was talking about, although I called it "secpoint" (too many 
names <g>).  The approach seemed to have promise in that it seemed to be 
easily understood be everyone and I brought it up again because I didn't want 
it to get lost; the discussion trailed off after initial idea was proposed 
and you hadn't posted anyting regarding it since then.

Do you have an estimate of when you are planning to work on it?  I want to try 
and avoid duplicating our efforts.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
