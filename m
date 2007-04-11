Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BFAw4l026964
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 11:10:58 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BFArEM001696
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 15:10:55 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>,
        "Joshua Brindle" <method@manicmethod.com>
Cc: "John Wan" <J.Wan@mbs.edu>, <selinux@tycho.nsa.gov>
Subject: RE: Would the SELinux  act as a TippingPoint IPS to block the nasty Trojan traffic?
Date: Wed, 11 Apr 2007 10:10:16 -0500
Message-ID: <000301c77c4b$83b18870$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200704110916.30573.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just FYI-I did propose filtering in the filter table in the past,
and this has been on my todo list.

"Implementation issues aside, lately I have been wondering about doing
something in the filter table using something we could call secfilter
or so.

You would still use secmark to label the packets, but they (along with
any external labels) could get filtered in the secfilter module. This
way we could control what external labels could come thru from what peers.
For internal labels it would be more of an assurance thing. This would also
automatically take care of forwarding controls."

More at: http://marc.info/?l=selinux&m=116232831800159&w=2

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Wednesday, April 11, 2007 8:16 AM
> To: Joshua Brindle
> Cc: John Wan; selinux@tycho.nsa.gov
> Subject: Re: Would the SELinux act as a TippingPoint IPS to block the
> nasty Trojan traffic?
> 
> 
> On Tuesday, April 10 2007 10:58:13 pm Joshua Brindle wrote:
> > >> I'd love to see your suggestions on solving the 
> forwarding problem, I
> > >> suppose those are forthcoming? :)
> > >
> > > Right now you'll have to make do with the discussion from 
> the developer's
> > > summit and my lovely emails ;)  The patches will be 
> forthcoming but I
> > > need to wrap up some loose ends on another project right now ..
> >
> > for some reason I don't remember a design being discussed 
> at the summit,
> > I'm probably just forgetting. This is not secpoint based right?
> 
> It was discussed but towards the end of the day in the 
> networking discussion 
> block.  See the notes that Stephen posted a while ago.
> 
> The idea is to create a new iptables "target" (probably the 
> wrong term, but 
> I'm not an iptables expert ... yet) which had an assigned 
> label, you would 
> then create iptables rules which would match certain traffic to 
> that "target".  The packets which hit the "target" would have 
> an access check 
> similar to the following:
> 
>  allow <target_label> <external_packet_label> : class perm;
> 
> So it's very similar to the secpoint (or whatever it was 
> being called) idea.  
> Also, just to re-iterate this - I HAVE NO PLANS TO MERGE THE 
> INTERNAL AND 
> EXTERNAL LABELS.  The original intent is to only provide support for 
> external, i.e. NetLabel and labeled IPsec, labeling 
> mechanisms; if we decide 
> to provide support for internal labeling mechanisms like 
> SECMARK we will do 
> so in parallel with additional access checks.
> 
> -- 
> paul moore
> linux security @ hp
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
