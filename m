Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15LosRb019250
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 16:50:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i15LnUQk024151
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 21:49:30 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id i15LnQYo024089
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 21:49:27 GMT
To: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
References: <401FF280.8070301@treblig.org>
	<84d68vlr6a.fsf@snoopy.apana.org.au> <402261FE.5060708@treblig.org>
From: Brian May <bam@snoopy.apana.org.au>
Date: Fri, 06 Feb 2004 08:51:32 +1100
In-Reply-To: <402261FE.5060708@treblig.org> (Dave Gilbert's message of "Thu,
 05 Feb 2004 15:32:14 +0000")
Message-ID: <84u125gpp7.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Dave" == Dave Gilbert (Home) <gilbertd@treblig.org> writes:

    >> These packages, for woody, are still in the "unstable" section of my
    >> archive.
    >> Unless anybody has any serious objections, I plan to delete the old
    >> selinux files in my "stable" archive and replace them with the new
    >> selinux files in my "unstable" archive.

    Dave> Hmm - I'm confused - if I look in
    Dave> /debian/dists/unstable/selinux/binary-i386/Packages
    Dave> on your site I just see dpkg, dpkg-dev and dpkg-doc
    Dave> can you give me an exact sources.list line?

You will need to use the "main" section as well as the "selinux"
section.  The "selinux" section is obsolete, as maintaining two
sections become difficult under certain circumstances.

dpkg must be the only package I haven't yet moved...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
