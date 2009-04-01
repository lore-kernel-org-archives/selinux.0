Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n317QMfh024280
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 03:26:22 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n317QKXa018440
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 07:26:21 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n317QJID028542
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 16:26:19 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id n317QI729891 for selinux@tycho.nsa.gov; Wed, 1 Apr 2009 16:26:18 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id n317QI0l024077
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 16:26:18 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 9260DE482DF
	for <selinux@tycho.nsa.gov>; Wed,  1 Apr 2009 16:26:18 +0900 (JST)
Message-ID: <49D3171A.3020708@ak.jp.nec.com>
Date: Wed, 01 Apr 2009 16:26:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Correct manner to handler undefined classes/permissions? (Re: Some
 ideas in SE-PostgreSQL enhancement)
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com> <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>
In-Reply-To: <49C9D524.9050208@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 5. Handle unsupported object classes/access vectors
> 
> What is the correct behavior for userspace object managers,
> when it tries to check undefined object classes or access
> vectors?
> 
> For example, we don't define db_database:{superuser} in the
> security policy. We cannot decide whether it is denied, or not.
> How the SE-PostgreSQL should perform for this?
> 
> In the current implementation, it simply ignores undefined
> permissions because string_to_av_perm() cannot return a valid
> access vector.
> 
> One possible idea is it performs according to /selinux/deny_unknown.
> If so, a new interface on libselinux is desirable.

This topic has been left for a week.

How should it be handled when we cannot find required classes or
permissions in the security policy?

The kernel allows anything or nothing for undefined object classes
based on policydb.allow_unknown. However, if the security policy
does not have a definition of the required access vector, it is
always denied (due to lack of explicit permission).

My preference is filling up the undefined access vectores with
policydb.allow_unknown. It seems to me quite natural.

Userspace object managers also have same issue.
Now it's unclear for me what is the preferable behavior.
For example, how should it handle the db_database:{superuser}
on the older security policy?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
