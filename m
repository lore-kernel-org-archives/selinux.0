Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPN0eRb016890
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 18:00:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAPN0dqY013824
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 23:00:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAPN0d0o013821 for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 23:00:39 GMT
Date: Tue, 25 Nov 2003 23:00:38 +0000
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: Still no authentication from new debian packages
Message-ID: <20031125230038.GO2718@vnl.com>
References: <20031125140255.GI2718@vnl.com> <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the advice. I think by framing the question
in greater detail I gave myself an answer... of course
finally being able to access the net from the test machine
(because of kernel bug fixes) helped a bit!

It is the login package.

Russell's Release has a package that requires:
	 conflict login <  1:4.0.3-11.se1

Colin's package supplies a package that satisfies
that:
	login 1:4.9.3-8.selinux.1

However, the sid distribution supplies a newer
package that both satisfies Russell's rules and 
overrides Colin's version with one which does not
support selinux:

	login 1:4.9.3-12

I have managed to get it working manually, now the
question becomes whether a virgin install with a
slightly modified preference will solve just this
without doing the bean-bag thing on me...

That system build will be in progress very shortly. Should
be ready for me to test tomorrow morning...

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
