Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n14EUvgA017155
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2009 09:30:57 -0500
Received: from po-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n14EUtMq017573
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2009 14:30:55 GMT
Received: by po-out-1718.google.com with SMTP id b23so6291806poe.4
        for <selinux@tycho.nsa.gov>; Wed, 04 Feb 2009 06:30:54 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Feb 2009 22:30:54 +0800
Message-ID: <707f057d0902040630q7e3534cle5f5f69ed2e2f0bd@mail.gmail.com>
Subject: How do Netlink work?
From: xing li <lixing.1006@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd1452eac3259046218a263
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd1452eac3259046218a263
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello all,
            I knew that selinux use the mechanism of netlink to broadcast
the event of policy changing. such as
selnl_notify_policyload(seqno); but i could't find the receiver (some object
manager) to handle it?
and according to the Technical Reports of selinux, i also knew the avc in
selinux resolved the problem about
revocation of migrated permissions, but how do implement it?

--000e0cd1452eac3259046218a263
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<div>Hello all,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I knew that&nbsp;selinux&nbsp;use the mechanism of netlink to&nbsp;broadcast the&nbsp;event&nbsp;of&nbsp;policy changing. such as&nbsp;</div>
<div>selnl_notify_policyload(seqno); but i could&#39;t find the receiver (some object manager) to handle it? </div>
<div>and according to&nbsp;the&nbsp;Technical Reports&nbsp;of selinux,&nbsp;i also knew the&nbsp;avc in selinux&nbsp;resolved the problem about </div>
<div>revocation of migrated permissions, but how do&nbsp;implement it? </div>

--000e0cd1452eac3259046218a263--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
