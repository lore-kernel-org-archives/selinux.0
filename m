Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8TF6OHY003234
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 11:06:24 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8TF6OK6001720
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 15:06:24 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [autotools] libselinux build system comments
Date: Mon, 29 Sep 2008 11:06:23 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E669857@exchange2.columbia.tresys.com>
References: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com> <48DE640B.10104@gmail.com> <06A6610D4F464D4EBEAFBF2C5F86911E669856@exchange2.columbia.tresys.com> <48DEEBDA.2050103@gmail.com>
From: "Jason Tang" <jtang@tresys.com>
To: "Vikram Noel Ambrose" <noel.ambrose@gmail.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: owner-selinux@tycho.nsa.gov on behalf of Vikram Noel Ambrose
Sent: Sat 2008-09-27 22:28
To: SE Linux
Subject: Re: [autotools] libselinux build system comments
 
>> libselinux and libsepol should be installed to /lib (or /lib64).  The reason is because /usr/lib may be on a different 
>>filesystem, but /lib (and /lib64) is nearly guaranteed to be available by the time the system will load the SELinux policy.

>And ./configure --libdir=/lib64. doesnt solve this?

No, because then libsemanage would be installed to the wrong location.

-- 
Jason Tang / jtang@tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
