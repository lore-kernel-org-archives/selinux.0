Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i149mbRb010834
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 04:48:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i149ma1I003473
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:48:36 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id i149mGbs003469 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:48:20 GMT
To: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
References: <401FF280.8070301@treblig.org>
From: Brian May <bam@snoopy.apana.org.au>
Date: Wed, 04 Feb 2004 09:43:57 +1100
In-Reply-To: <401FF280.8070301@treblig.org> (Dave Gilbert's message of "Tue,
 03 Feb 2004 19:12:00 +0000")
Message-ID: <84d68vlr6a.fsf@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>>> "Dave" == Dave Gilbert (Home) <gilbertd@treblig.org> writes:

    Dave> Hi, I've been following the document 'Getting Started With
    Dave> SE Linux HOWTO' by Faye Coker (12 March 2003) and am having
    Dave> problems. Any help much appreciated.

    Dave> I'm using Debian Woody and the 'stable' set of tools from
    Dave> Brian May (www.microcomaustralia.com.au)

Hello,

Currently the "stable" set of tools are all for the old selinux,
I suspect you have a kernel with the new selinux.

These packages, for woody, are still in the "unstable" section of my
archive.

Unless anybody has any serious objections, I plan to delete the old
selinux files in my "stable" archive and replace them with the new
selinux files in my "unstable" archive.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
