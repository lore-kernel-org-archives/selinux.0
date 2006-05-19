Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JI6Z4D012816
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:06:35 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JI6Zk7024064
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 18:06:35 GMT
Subject: Re: Is SELinux appropriate for my use?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Valdis.Kletnieks@vt.edu,
        Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1148061813.31984.76.camel@sgc.columbia.tresys.com>
References: <446A0CE9.6020708@gmail.com> <446CD37D.1020500@gmail.com>
	 <200605190708.k4J78PwJ013208@turing-police.cc.vt.edu>
	 <200605192354.31161.russell@coker.com.au>
	 <1148061813.31984.76.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 19 May 2006 14:08:38 -0400
Message-Id: <1148062118.31984.79.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 14:03 -0400, Christopher J. PeBenito wrote:
> The file contexts would need to be updated, and the interfaces
> that deal with sbin_t and ls_exec_t would need a m4 errprint() to warn
> that the interfaces are deprecated and say what the new interface to
> use, in addition to the alias.

Also the callers of the deprecated interfaces should be fixed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
