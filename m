Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBHIUARb003171
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 13:30:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBHIU3pn023963
	for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:30:03 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBHIU3ab023960 for <selinux@tycho.nsa.gov>; Wed, 17 Dec 2003 18:30:03 GMT
Subject: Re: [patch] add source line numbers to checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1071478020.17990.8.camel@nexus.verbum.private>
References: <1071478020.17990.8.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1071685779.1403.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 17 Dec 2003 13:29:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-15 at 03:47, Colin Walters wrote:
> Attached are two patches which have checkpolicy emit the source line
> number where an error occurred, if available.  This would have been
> fairly trivial, except it required rewriting the sample policy Makefile
> to not invoke m4 multiple times.  

Thanks, the checkpolicy patch and the updated policy Makefile patch have
been merged into our CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
