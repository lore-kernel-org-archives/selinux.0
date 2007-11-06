Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA63vfOq029391
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 22:57:41 -0500
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA63vcVn007213
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 03:57:39 GMT
Message-ID: <472FE68D.4030404@ak.jp.nec.com>
Date: Tue, 06 Nov 2007 12:59:09 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: security context for SPD entries of labeled IPsec
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have to set up several SPD entries with a security context
to apply labeled IPsec, like as:

  spdadd 192.168.1.10 192.168.1.20 any
  -ctx 1 1 "system_u:object_r:unconfined_t:s0"
  -P in ipsec esp/transport//require;

What is the most appropriate context to be specified?
Or, is the security policy to be modified?

In the current reference policy, several domain have permissions
of association class for 'self' or 'unlabeled_t'.
However, it can cause a matter when 'unconfined_t' processes tries
to connect 'postgresql_t' process running on another host via labeled
IPsec, for instance.

We can add additional permissions to avoid the matter, as follows:
  allow postgresql_t unconfined_t : association { ... };

But IMO it makes a bit confusable to apply process's domain as
a type of SPD entries, like unconfined_t and so on.

I prefer the following description to separate subject and object.
  allow postgresql_t postgresql_spd_t : association { ... };
  allow unconfined_t postgresql_spd_t : association { ... };

Is there any reason why SPD entries have same type with domains?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
