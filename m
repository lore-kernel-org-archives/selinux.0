Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA28603
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 05:31:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA11049
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 09:29:33 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id JAA10997 for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 09:28:40 GMT
Date: Fri, 27 Sep 2002 19:29:47 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux packages
Message-ID: <20020927092947.GJ15981@snoopy.apana.org.au>
References: <20020920022148.GA12250@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020920022148.GA12250@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am currently copying newer versions of kernel-patch, kernel-source,
kernel-image, and selinux, to the same location:

deb http://www.microcomaustralia.com.au/debian/ woody main selinux

(the "main" part is optional)

These have been updated to use Russell's latest files.

Also, I have now deviated from the "Debian" standard, and enabled DMA
and multimode for IDE by default in the kernel images (since there I saw
reports that enabling it during startup could cause data loss; not sure
how accurate they are...)

I have also packaged the latest version of devfsd (required for
SE-Linux) and put it here.

I have not yet had a chance to test any of this, and it may take several
hours to rsync my changes over my 64kbs, so please be patient if try
straight away and get file not found errors.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
