Message-ID: <4663EF03.6060301@kaigai.gr.jp>
Date: Mon, 04 Jun 2007 19:52:51 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov,
        KaiGai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
 interface)
References: <C32347D4-3E32-4741-B847-6826EED3BB7A@nall.com> <1180631739.3340.309.camel@moss-spartans.epoch.ncsc.mil> <4661ACEF.3000801@kaigai.gr.jp>
In-Reply-To: <4661ACEF.3000801@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> For example, RDBMS server has two NIC. One is connected to internal network and
> connections from there are defined as SystemLow-SystemHigh, the other is connected
> to external network and defined as SystemLow, like the following image.
> 
> SystemLow-SystemHigh +--------+      SystemLow
>             --> eth0 |SE-PgSQL| eth1 <---
> ---------------------= server =---------------
>             INTERNAL +--------+ EXTERNAL

I drew an illustration to help my explanation.
  http://kaigai.sblo.jp/article/4247935.html

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
