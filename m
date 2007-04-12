Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3CHdxER001553
	for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2007 13:39:59 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3CHduh9012778
	for <selinux@tycho.nsa.gov>; Thu, 12 Apr 2007 17:39:57 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>
Cc: "Joshua Brindle" <method@manicmethod.com>, "John Wan" <J.Wan@mbs.edu>,
        <selinux@tycho.nsa.gov>, "Chad Hanson" <chanson@tcsfw4.tcs-sec.com>
Subject: RE: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Thu, 12 Apr 2007 12:39:23 -0500
Message-ID: <000001c77d29$83134dc0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200704111117.42747.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Wednesday, April 11, 2007 10:18 AM
> To: vyekkirala@trustedcs.com
> Cc: Joshua Brindle; John Wan; selinux@tycho.nsa.gov
> Subject: Re: Would the SELinux act as a TippingPoint IPS to block the
> nasty Trojan traffic?
> 
> 
> On Wednesday, April 11 2007 11:10:16 am Venkat Yekkirala wrote:
> > Just FYI-I did propose filtering in the filter table in the past,
> > and this has been on my todo list.
> >
> > "Implementation issues aside, lately I have been wondering 
> about doing
> > something in the filter table using something we could call 
> secfilter
> > or so.
> >
> > You would still use secmark to label the packets, but they 
> (along with
> > any external labels) could get filtered in the secfilter 
> module. This
> > way we could control what external labels could come thru 
> from what peers.
> > For internal labels it would be more of an assurance thing. 
> This would also
> > automatically take care of forwarding controls."
> 
> This is what I was talking about, although I called it 
> "secpoint" (too many 
> names <g>).  The approach seemed to have promise in that it 
> seemed to be 
> easily understood be everyone and I brought it up again 
> because I didn't want 
> it to get lost; the discussion trailed off after initial idea 
> was proposed 
> and you hadn't posted anyting regarding it since then.

Well, thanks for keeping it under the limelight. As for
the name, I think secfilter will do full justice since it's
really filtering (only security context-based) and would thus
be intuitive. Also, secpoint might confuse people that were
already exposed to the failed secpoint paradigm.

> 
> Do you have an estimate of when you are planning to work on 
> it?  I want to try 
> and avoid duplicating our efforts.

I am getting very close to getting to it. Will keep y'all posted.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
