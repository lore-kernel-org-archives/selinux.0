Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24868
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 17:46:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19311
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:43:59 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id WAA19307
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:43:56 GMT
Date: Thu, 21 Nov 2002 09:48:51 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov, jabiru_croc@yahoo.com
Subject: Re: SELinux distro building
Message-ID: <20021120224851.GB17578@snoopy.apana.org.au>
References: <sddba22a.029@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sddba22a.029@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 20, 2002 at 02:54:18PM -0600, Joshua Brindle wrote:
> much closer
> i used --with-lsm=/usr/src/linux-2.4.19-selinux because it was looking
> in ../../.. for lsm-2.4, instead of just ../ (i dunno)
> anyway, it compiled almost everything then i got this error
> (if you prefer i can pipe the entire compile to a file and attach..
> Thanks

Looks like another directory that needs to include LSM directories.

What directories need these include files?

So far it seems to be:

libsecure/src
libsecure/test
modules/checkpolicy

Is that all? Are there any others I might have missed?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
