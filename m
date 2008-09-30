Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8U4JY5n002933
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 00:19:34 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8U4JW8J008688
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 04:19:34 GMT
Message-ID: <48E1A8BF.6060107@ak.jp.nec.com>
Date: Tue, 30 Sep 2008 13:19:11 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
Subject: sepostgresql.pp conflicts on F9 (Re: How to find SELinux policy type?)
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	 <48DC5C16.9040607@ak.jp.nec.com>	 <1222421896.24783.7.camel@sulphur.notebook.internal>	 <48DCB88E.3080503@kaigai.gr.jp> <1222425714.24783.13.camel@sulphur.notebook.internal> <48DCE45B.3040900@kaigai.gr.jp> <48DE5718.2050404@kaigai.gr.jp>
In-Reply-To: <48DE5718.2050404@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick,

Show the package:
  http://koji.fedoraproject.org/koji/buildinfo?buildID=64748

It will be able to help your matter.

BTW, I could not describe its dependency well.
Please tell me, if someone knows the way to describe "Require" section well.

Require: selinux-policy >= 3.3.1-96
                                ^^^
The rpmbuild made an error because it contains %{Release} part,
so I omit it like "Require: selinux-policy >= 3.3.1".
Of cource, it is not a correct description.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
