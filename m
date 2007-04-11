Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BH1XLD000931
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:01:33 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BH1VT2018489
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:01:32 GMT
Message-ID: <461D1464.7070607@manicmethod.com>
Date: Wed, 11 Apr 2007 13:01:24 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: vyekkirala@TrustedCS.com
CC: "'Paul Moore'" <paul.moore@hp.com>, John Wan <J.Wan@mbs.edu>,
        selinux@tycho.nsa.gov
Subject: Re: Would the SELinux  act as a TippingPoint IPS to block the nasty
 Trojan traffic?
References: <000301c77c4b$83b18870$cc0a010a@tcssec.com>
In-Reply-To: <000301c77c4b$83b18870$cc0a010a@tcssec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
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
>
> More at: http://marc.info/?l=selinux&m=116232831800159&w=2
>   
so from what I gather the secfilter module would be querying the selinux 
policy to determine whether or not to drop something, that would mean a 
change in iptables changes the enforcement policy (not just the labeling 
policy as is the case now) which is a little disconcerting.

How does this work into the idea we had during the summit about SELinux 
having its own table? The table would presumably be a mangle table for 
labeling but could it also be a filter table? I'm not clear on what is 
possible in netfilter.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
