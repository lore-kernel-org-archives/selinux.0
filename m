Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i15FXIRb016999
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 10:33:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i15FVtfi008268
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 15:31:55 GMT
Received: from butternut.transitive.com (dsl-217-207-128-218.uk.easynet.net [217.207.128.218] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id i15FVbD3008231
	for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2004 15:31:54 GMT
Message-ID: <402261FE.5060708@treblig.org>
Date: Thu, 05 Feb 2004 15:32:14 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
MIME-Version: 1.0
To: Brian May <bam@snoopy.apana.org.au>
CC: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
References: <401FF280.8070301@treblig.org> <84d68vlr6a.fsf@snoopy.apana.org.au>
In-Reply-To: <84d68vlr6a.fsf@snoopy.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian May wrote:

Hi Brian,

> Currently the "stable" set of tools are all for the old selinux,
> I suspect you have a kernel with the new selinux.

This indeed seems to be the case;  after yesterdays discussions I 
successfully built myself an old selinux kernel and got it to work with 
the packages I had installed. Thanks to both yourself and Russell for 
explaining this.

> These packages, for woody, are still in the "unstable" section of my
> archive.
> 
> Unless anybody has any serious objections, I plan to delete the old
> selinux files in my "stable" archive and replace them with the new
> selinux files in my "unstable" archive.

Hmm - I'm confused - if I look in 
/debian/dists/unstable/selinux/binary-i386/Packages
on your site I just see dpkg, dpkg-dev and dpkg-doc
can you give me an exact sources.list line?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
