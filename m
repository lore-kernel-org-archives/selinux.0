Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3GIwWt000929
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 11:18:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA3GIvKl005296
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 16:18:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hA3GIv5m005293 for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 16:18:57 GMT
Subject: Re: default policy package
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, Diyab <diyab@diyab.net>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20031103152920.GD29928@vnl.com>
References: <20031103114353.GC13273@vnl.com> <3FA65A60.3010802@diyab.net>
	 <200311040140.04077.russell@coker.com.au>  <20031103152920.GD29928@vnl.com>
Content-Type: text/plain
Message-Id: <1067876334.21113.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Nov 2003 11:18:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-03 at 10:29, Dale Amon wrote:
> On Tue, Nov 04, 2003 at 01:40:04AM +1100, Russell Coker wrote:
> > My initial thought was to try compiling all combinations of packages.  But 
> > that would involve hundreds of thousands of compilations.  So my current idea 
> > is to m4 process each .te file with only the macro files and then search for 
> > type declarations.  Then make a list of all .te files which reference those 
> > types or attributes that they posess.  Then once the list of inter-dependence 
> > between policy files is prepared it should be only a few hundred compilations 
> > needed to prove that the policy will compile in all valid configurations.

What exactly are you trying to achieve that isn't provided by Colin's
policy regression testing support (i.e. 'make check-all')?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
