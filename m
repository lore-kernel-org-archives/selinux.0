Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8K3WOrT015166
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 23:32:24 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8K3WONX016824
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 03:32:24 GMT
Subject: Re: [RFC] Upstream policy handling
From: Colin Walters <walters@verbum.org>
To: Joshua Brindle <method@gentoo.org>
Cc: russell@coker.com.au, selinux <selinux@tycho.nsa.gov>,
   Chris PeBenito <pebenito@gentoo.org>
In-Reply-To: <414E1AC3.2070209@gentoo.org>
References: <414DA0A7.1000708@gentoo.org>
	 <200409200646.51865.russell@coker.com.au> <414DF5F2.9030700@gentoo.org>
	 <200409200729.50087.russell@coker.com.au>  <414E1AC3.2070209@gentoo.org>
Content-Type: text/plain
Date: Sun, 19 Sep 2004 23:33:52 -0400
Message-Id: <1095651232.4431.123.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-09-19 at 19:48 -0400, Joshua Brindle wrote:
> >
> I'm not totally sure at this moment, Chris will have to say something here
> We do have the desire to make sweeping changes to the current policy 
> however, these changes would not be possible to merge into the upstream 
> policy (though past feedback here suggests they wouldn't be appreciated 
> anyway)

As we discussed on IRC, at least for the sysadmfile removals, there's an
easy way to preserve the existing semantics and keep the patch
mergeable: just use another attribute instead of sysadmfile.  



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
