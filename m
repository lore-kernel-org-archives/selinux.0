Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0CHLxbq023821
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 12:21:59 -0500
Received: from web36613.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0CHMo8g011138
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:22:50 GMT
Date: Fri, 12 Jan 2007 09:22:34 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] clarifications for -l to newrole.1
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45A7B31D.6000001@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <587927.74563.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Michael C Thompson <thompsmc@us.ibm.com> wrote:

> Currently, in the MLS policy, the default behaviour
> is to have users 
> login at SystemLow. If this is not what you would
> expect, then we should 
> probably change the default levels assumed for users
> on login.

Allowing users to log in at SystemLow would not
be consistant with current best practice. I know
that neither Trusted Solaris nor Trusted Irix
allows that, and I don't think that HP/UX does
either. Even allowing for the additional
protections provided by TE letting users run with
the same MLS value as system files (unless you
have something lower than low!) is going to
set off warning bells in certain circles. Why
have MLS if you aren't going to use it to
protect your system data, after all? And yes,
I understand that there's lots more to SELinux
policy enforcement than MLS, and that the other
protections are more than sufficient to protect
the system files from users. Even with that,
users should be segregated from the system using
MLS since MLS is available. Belts, bracers,
garters, elastic and velcro make for a happy
and swift evaluation and an end user that
understands how the system is protected.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
