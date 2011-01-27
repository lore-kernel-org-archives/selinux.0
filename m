Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0R4JYWm015629
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2011 23:19:39 -0500
Received: from tyo202.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0R4JaIE009822
	for <selinux@tycho.nsa.gov>; Thu, 27 Jan 2011 04:19:37 GMT
Received: from mailgate4.nec.co.jp ([10.7.69.184])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0R4JYV8000804
	for <selinux@tycho.nsa.gov>; Thu, 27 Jan 2011 13:19:34 +0900 (JST)
Received: (from root@localhost) by mailgate4.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p0R4JYD26969 for selinux@tycho.nsa.gov; Thu, 27 Jan 2011 13:19:34 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0R4JXtU002472
	for <selinux@tycho.nsa.gov>; Thu, 27 Jan 2011 13:19:33 +0900 (JST)
Message-ID: <4D40F249.5020606@ak.jp.nec.com>
Date: Thu, 27 Jan 2011 13:19:21 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [libselinux] add db_language support on label_db.c
References: <4D256BE8.2010704@ak.jp.nec.com>
In-Reply-To: <4D256BE8.2010704@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How about getting inclusion of this patch?

The db_language class is already merged to refpolicy.
I think it is also necessary to be merged to libselinux.

Thanks,

(2011/01/06 16:14), KaiGai Kohei wrote:
> The attached patch add support db_language object class
> to the selabel_lookup(_raw) interfaces.
> It is needed to inform object manager initial label of
> procedural language object.
> 
> Thanks,

-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
