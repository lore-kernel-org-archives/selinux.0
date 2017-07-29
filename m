Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6T9gj6f014031
 for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2017 05:42:45 -0400
Received: from [10.255.0.13] (unknown [10.255.0.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "Paul Bolton", Issuer "M0NOC" (verified OK))
 by tbhext01.m0noc.net (Postfix) with ESMTPSA id 3xKLNZ2dkQz2TC7k
 for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2017 10:42:38 +0100 (BST)
To: selinux@tycho.nsa.gov
From: Paul Bolton <paul.a.bolton@m0noc.net>
Message-ID: <f3a307fd-ebd6-5815-8db5-73442bd07fe3@m0noc.net>
Date: Sat, 29 Jul 2017 10:42:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Email problems with this mailing list
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Whilst current 3rd party archives suggest my last mail got through,
since circa Jul 24 things have failed intermittently until Jul 27 when
no more mail is being received by me from this list.

It appears the issue is to do with validation of the DNS name of the
outbound NSA mail server in that not all the names are listed/exposed in
DNS. This then lead to a "disable" for my mailing list account; which
ironically for I got the email to which I replied.

Not sure if others may be experiencing such issues; which I guess is
more of an answer for the admins of this list - are you getting a spike
in rejects and/or account disablements?

e.g.

I will now see:

NOQUEUE: reject: RCPT from uphb19pa09.eemsg.mail.mil[214.24.26.83]: 450
4.7.1 <USFB19PA12.eemsg.mail.mil>: Helo command rejected: Host not
found; from=<selinux-bounces@tycho.nsa.gov> to=<paul.a.bolton@m0noc.net>
proto=ESMTP helo=<USFB19PA12.eemsg.mail.mil>

If I then use Google's DNS rather than my own so as to be sure it isn't
a local DNS issue...

nslookup USFB19PA12.eemsg.mail.mil. 8.8.8.8
Server:         8.8.8.8
Address:        8.8.8.8#53

** server can't find USFB19PA12.eemsg.mail.mil.: NXDOMAIN

others inc. but not limited to:

** server can't find USFB19PA14.eemsg.mail.mil: NXDOMAIN
** server can't find USFB19PA13.eemsg.mail.mil.: NXDOMAIN

Some do work:

Name:   upbd19pa07.eemsg.mail.mil
Address: 214.24.27.82

Name:   upbd19pa10.eemsg.mail.mil
Address: 214.24.27.85

Any thoughts on the resolution. Should I be expected to change my config
or should the NSA mail server setup be adjusted to pass these checks?

-- 
Paul
----
http://blog.m0noc.com/ | https://keybase.io/m0noc
4329 E4C5 71F3 58B2 2246  D04D 25DA 39C2 3876 FE3D
