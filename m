Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7VNYH0D006180
	for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2008 19:34:17 -0400
Received: from wf-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7VNYGYE001650
	for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2008 23:34:17 GMT
Received: by wf-out-1314.google.com with SMTP id 28so1776209wff.30
        for <selinux@tycho.nsa.gov>; Sun, 31 Aug 2008 16:34:16 -0700 (PDT)
Message-ID: <dd18b0c30808311634k683b139fm9f17810a66a81074@mail.gmail.com>
Date: Sun, 31 Aug 2008 19:34:16 -0400
From: "Justin Mattock" <justinmattock@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Subject: checkpolicy: error(s) encountered while parsing configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

when loading the latest refpolicy I'm seing a
policy/modules/kernel/kernel.te":237:ERROR 'syntax error' at token 'corenet_raw_
corenet_raw_send_multicast_node(kernel_t)

not sure if this is checkpolicy or refpolicy
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
