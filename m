Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UDfqmW021913
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 09:41:52 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7UDfpAo027639
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 13:41:52 GMT
Received: by ug-out-1314.google.com with SMTP id 30so204038ugs
        for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 06:41:51 -0700 (PDT)
Message-ID: <f71a82820708300641k1bd08f10n44cdd6ba6912f943@mail.gmail.com>
Date: Thu, 30 Aug 2007 22:41:50 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH]interface name of certwatch_run in admin layer
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not certwatach_run but certwatch_run ?

47c47
< interface(`certwatach_run',`
---
> interface(`certwatch_run',`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
