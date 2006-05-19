Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JI1UAO012665
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:01:30 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JI1UfP013351
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 18:01:30 GMT
Subject: Re: Is SELinux appropriate for my use?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Valdis.Kletnieks@vt.edu,
        Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <200605192354.31161.russell@coker.com.au>
References: <446A0CE9.6020708@gmail.com> <446CD37D.1020500@gmail.com>
	 <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
	 <200605192354.31161.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 19 May 2006 14:03:32 -0400
Message-Id: <1148061813.31984.76.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 23:54 +1000, Russell Coker wrote:
> Incidentally I still don't think that we need separation of sbin_t and bin_t.  
> The choice of which programs go in which directories is rather arbitrary and 
> is not based on security criteria.  We have no expectation that sbin_t and 
> bin_t will have different integrity (the system integrity entirely depends on 
> the integrity of both those types) and we also expect that there is no secret 
> data labeled with either of those types.  So it seems to me that making 
> sbin_t and ls_exec_t both aliases for bin_t would be the correct thing to do.

I agree.  The file contexts would need to be updated, and the interfaces
that deal with sbin_t and ls_exec_t would need a m4 errprint() to warn
that the interfaces are deprecated and say what the new interface to
use, in addition to the alias.  Care to make a patch Russell?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
