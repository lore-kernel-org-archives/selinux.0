Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3FTSWt000534
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 10:29:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3FT7C7017657
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:29:07 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hA3FT6uw017651
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:29:07 GMT
Date: Mon, 3 Nov 2003 15:29:20 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Diyab <diyab@diyab.net>, Dale Amon <amon@vnl.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
Message-ID: <20031103152920.GD29928@vnl.com>
References: <20031103114353.GC13273@vnl.com> <3FA65A60.3010802@diyab.net> <200311040140.04077.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311040140.04077.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 04, 2003 at 01:40:04AM +1100, Russell Coker wrote:
> My initial thought was to try compiling all combinations of packages.  But 
> that would involve hundreds of thousands of compilations.  So my current idea 
> is to m4 process each .te file with only the macro files and then search for 
> type declarations.  Then make a list of all .te files which reference those 
> types or attributes that they posess.  Then once the list of inter-dependence 
> between policy files is prepared it should be only a few hundred compilations 
> needed to prove that the policy will compile in all valid configurations.

Isn't this a dual with the halting problem? ;-)

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
