Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA16083
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 22:48:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id CAA20455
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 02:46:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id CAA20451 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 02:46:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: Indentifying SE-Linux version
Date: Mon, 30 Sep 2002 04:48:03 +0200
References: <20020930002206.GB24855@snoopy.apana.org.au>
In-Reply-To: <20020930002206.GB24855@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200209300448.03455.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 02:22, Brian May wrote:
> The version of the SELinux libraries seem to be constantly
> changing, and introducing new incompatabilities, etc.

I wouldn't go as far as to say it's constantly changing, but it does change 
more than we'd like...

> I think we need a way to identify what version of selinux
> a given binary has been compiled against.

I've been thinking about this some more since we first discussed the matter.

I think that it's more important for the application to be able to determine 
what version of the API it's running against (policy versions may not require 
a new version of the API).

The application should be able to query the kernel for which version of the 
API it provides and then shut down if it's not what we want.  Alternately the 
application should be able to say "I want to talk version 12, is that OK" and 
the kernel responds with a boolean.  If running an application and a kernel 
that were compiled at the same time then this will not be a problem.  If the 
kernel is newer it may support a compatability mode and flag that application 
as an application to use the old interface with (but this is a feature for 
after a 1.0 release).  If the application is newer then it could conceivably 
then try enquiring about older versions of the ABI until it finds one it can 
work with (but that would be too difficult for most people to deal with - so 
maybe we'll never do it).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
