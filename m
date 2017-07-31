Message-ID: <1501504288.9814.8.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Bolton <paul.a.bolton@m0noc.net>, selinux@tycho.nsa.gov
Date: Mon, 31 Jul 2017 08:31:28 -0400
In-Reply-To: <f3a307fd-ebd6-5815-8db5-73442bd07fe3@m0noc.net>
References: <f3a307fd-ebd6-5815-8db5-73442bd07fe3@m0noc.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Email problems with this mailing list
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-07-29 at 10:42 +0100, Paul Bolton via Selinux wrote:
> Whilst current 3rd party archives suggest my last mail got through,
> since circa Jul 24 things have failed intermittently until Jul 27
> when
> no more mail is being received by me from this list.
> 
> It appears the issue is to do with validation of the DNS name of the
> outbound NSA mail server in that not all the names are listed/exposed
> in
> DNS. This then lead to a "disable" for my mailing list account; which
> ironically for I got the email to which I replied.
> 
> Not sure if others may be experiencing such issues; which I guess is
> more of an answer for the admins of this list - are you getting a
> spike
> in rejects and/or account disablements?
> 
> e.g.
> 
> I will now see:
> 
> NOQUEUE: reject: RCPT from uphb19pa09.eemsg.mail.mil[214.24.26.83]:
> 450
> 4.7.1 <USFB19PA12.eemsg.mail.mil>: Helo command rejected: Host not
> found; from=<selinux-bounces@tycho.nsa.gov> to=<paul.a.bolton@m0noc.n
> et>
> proto=ESMTP helo=<USFB19PA12.eemsg.mail.mil>
> 
> If I then use Google's DNS rather than my own so as to be sure it
> isn't
> a local DNS issue...
> 
> nslookup USFB19PA12.eemsg.mail.mil. 8.8.8.8
> Server:         8.8.8.8
> Address:        8.8.8.8#53
> 
> ** server can't find USFB19PA12.eemsg.mail.mil.: NXDOMAIN
> 
> others inc. but not limited to:
> 
> ** server can't find USFB19PA14.eemsg.mail.mil: NXDOMAIN
> ** server can't find USFB19PA13.eemsg.mail.mil.: NXDOMAIN
> 
> Some do work:
> 
> Name:   upbd19pa07.eemsg.mail.mil
> Address: 214.24.27.82
> 
> Name:   upbd19pa10.eemsg.mail.mil
> Address: 214.24.27.85
> 
> Any thoughts on the resolution. Should I be expected to change my
> config
> or should the NSA mail server setup be adjusted to pass these checks?

Thanks for the report; we'll raise it with the responsible parties. 
However, in the future, please report mailing list problems to
selinux-owner@tycho.nsa.gov
rather than posting to the list itself about them.
