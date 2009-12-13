Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBDJeRCw002561
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 14:40:27 -0500
Received: from cp-out11.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBDJgmev018203
	for <selinux@tycho.nsa.gov>; Sun, 13 Dec 2009 19:42:48 GMT
Received: from [192.168.2.2] (151.64.21.76) by cp-out11.libero.it (8.5.119)
        id 4AE04A3D0B3BE718 for selinux@tycho.nsa.gov; Sun, 13 Dec 2009 20:40:24 +0100
Subject: Re: avc's generated causes the system to freeze up
From: Guido Trentalancia <guido@trentalancia.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B252E41.6070501@gmail.com>
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com>
Content-Type: text/plain
Date: Sun, 13 Dec 2009 20:40:23 +0100
Message-Id: <1260733223.2858.23.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Have you tried tuning auditd and its dispatcher which could be audispd ?

So for example, try feeding audispd with the following options:

q_depth: increase it from its default value (which is 80 on Redhat's
recent auditd)
priority_boost = 0

Finally, if things don't improve, you could also try:

overflow_action = suspend

Other than this I don't know how to help. Good luck.

On Sun, 2009-12-13 at 10:11 -0800, Justin P. Mattock wrote:
> On 12/13/09 08:42, Guido Trentalancia wrote:
> > Justin,
> >
> > your question seems more of an audit question.
> >
> > Why don't you use audit2allow to sort this out from a SELinux point of
> > view instead than trying to shut up audit ?
> >
> > Audit2allow can generate custom rules for you from the analysis of your
> > audit log messages. The rules can then be compiled into a custom policy
> > module, that you can install with semodule.
> >
> >
> 
> I can easily create an allow rule with audit2allow.
> 
> The issue is not creating an allow rule,
> but having Xorg.0.log spammed with a denial
> causing the system to freeze up, until
> the avc is done doing with whatever it's doing
> (in this case logging many denials of the same one).
> 
> hence the reason for wondering if theres a mechanism that could
> be put in place like prinkt_ratelimit for
> Xorg.0.log this way I don't get spammed with a denial.
> 
> Justin P. Mattock
> 
> 
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
