Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LDiLdW017506
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 08:44:22 -0500 (EST)
Received: from mail-old.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LDdspm005512
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:39:54 GMT
Received: from mailr1.asahi-net.or.jp (mailr1.asahi-net.or.jp [202.224.39.211])
	by mail-old.asahi-net.or.jp (Postfix) with ESMTP id 086C7C6CB
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 22:42:07 +0900 (JST)
Received: from ayu.kaigai.gr.jp (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by mailr1.asahi-net.or.jp (8.11.7/3.7W) with ESMTP id j1LDg6Z19933
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 22:42:06 +0900 (JST)
Received: from [192.168.1.32] (noah.kaigai.gr.jp [192.168.1.32])
	by ayu.kaigai.gr.jp (Postfix) with ESMTP id D8D78CD0043
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 22:37:08 -0500 (EST)
Message-ID: <4219E45B.2020501@kaigai.gr.jp>
Date: Mon, 21 Feb 2005 22:38:35 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: What is typealias and typeattribute
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I noticed some sentence structures not to understand the meaning well,
when I read policy_parse.y in checkpolicy.tgz.

I think we can replace 'typealias' and 'typeattribute' with
'type ...' sentence structure completely.
So, It's not writen in 'Configuring the SELinux Policy', orz.

Is it historical syntax? or does it have another purpose?
Please tell me.

Thanks.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
