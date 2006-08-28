Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7SCK9gb009031
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 08:20:09 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7SCJnW5009597
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 12:19:49 GMT
Received: by py-out-1112.google.com with SMTP id 39so2098463pyu
        for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 05:20:07 -0700 (PDT)
Message-ID: <44F2DF61.3050505@kaigai.gr.jp>
Date: Mon, 28 Aug 2006 21:19:45 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: himainu-ynakam@miomio.jp, selinux@tycho.nsa.gov
Subject: [OT] a trouble with posting to '*.@tycho.nsa.gov'
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

In recent days, I have faced to a trouble when I tried to post
messages into '*@tycho.nsa.gov'.
The phenomenon was that any messages were not delivered when we
used some specific SMTP servers. Today, I heard that Y.Nakamura
is also faced to same trouble when he tried to post a message
into NSA SELinux list from his office.

After I changed my SMTP server from mail.kaigai.gr.jp to smtp.gmail.com,
some messages are delivered without any troubles.
(Therefore, I could post a small patch some days ago.)

But it was so inconvenient. Especially, we also cannot post a message
from my office. :(
The following smtp servers were NOT available at least.
- mail.kaigai.gr.jp
- tyo201.gate.nec.co.jp

Is there any spam filtering configuration by smtp server?
Or, are any other reason possible?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
