Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8TKpmsJ014765
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 16:51:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8TKpkCG021230
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 20:51:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h8TKpkqJ021226 for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 20:51:46 GMT
Subject: Re: SELinux & UML FAQ
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Davis <nicholas-davis@utulsa.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F7895A0.2030207@utulsa.edu>
References: 
	 <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com>
	 <200309260247.39337.russell@coker.com.au> <3F73854B.1080408@diyab.net>
	 <200309261242.07521.russell@coker.com.au>  <3F7895A0.2030207@utulsa.edu>
Content-Type: text/plain
Message-Id: <1064868705.10464.206.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 29 Sep 2003 16:51:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-29 at 16:27, Nick Davis wrote:
> Is there anything special required for getting UML working with 2.6
> SELinux?  I've downloaded the patch and
> applied it to 2.6.0-test3, which seemed to work fine.  But I get errors
> when doing a 'make linux ARCH=um' as
> suggested on the UML website documentation.  I was wondering if anything
> has changed since the 2.4.x days; the docs are at least a couple years old.

I'd suggest using a newer kernel, as 2.6.0-test3 is fairly old.  We
should have an updated release on the NSA site soon based on 2.6.0-test6
along with updated userland components.  We did update the sourceforge
CVS tree last week, but that was prior to the release of 2.6.0-test6.

As for UML, I think Russell Coker had a trivial one line patch for it
a while back, available under http://www.coker.com.au/uml/.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
