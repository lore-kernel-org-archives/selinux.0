Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17929
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 13:52:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA14447
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 18:50:53 GMT
Received: from gricklegrass.epoch.ncsc.mil (gricklegrass.epoch.ncsc.mil [144.51.25.138])
	by jazzswing.ncsc.mil  with ESMTP id SAA14443
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 18:50:53 GMT
Date: Tue, 19 Mar 2002 13:52:07 -0500
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: sec rating
Message-ID: <20020319135207.A11727@gricklegrass.epoch.ncsc.mil>
References: <20020319192257.C16554@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020319192257.C16554@lemuria.org>; from tom@lemuria.org on Tue, Mar 19, 2002 at 07:22:57PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux has not been evaluated against any security criteria as far as
I'm aware, and I'd expect to be among the very first to know.  B1 is a
rating of the Trusted Computing System Evaluation Criteria (TCSEC) which
is no longer used.  It has been replaced by the Common Criteria.  In the
US, CC evaluations are done by the Common Criteria Evaluation and Validation
Scheme (CCEVS) of the National Information Assurance Partnership (NIAP).
See <http://niap.nist.gov/cc-scheme/> and <http://naip.nist.gov/>.  What
may have been said, and would be true, is that SELinux includes features
that would have been expected in B1 systems and not expected in systems
rated against lower levels of the TCSEC.  That does NOT imply that SELinux
has all the features and assurances necessary for that or any other
particular level.

As Tom correctly pointed out, an actual evaluation or certification
would (in general) have to take into account an entire system configuration
of both hardware and software.

On Tue, Mar 19, 2002 at 07:22:57PM +0100, Tom wrote:
> I heard someone claim today that SE Linux has a security rating of B1 -
> but I can't remember reading anything about certification and unless
> I'm mistaken it would've to be a specific software + hardware
> configuration. Can someone shed light on this?

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
