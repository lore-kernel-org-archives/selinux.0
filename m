Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l226rYlf013732
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 01:53:34 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l226svBK016566
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 06:54:57 GMT
Received: by wr-out-0506.google.com with SMTP id 37so219949wra
        for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2007 22:54:57 -0800 (PST)
Message-ID: <e739902b0703012254j5b078fckd364da8b8ccfb4ab@mail.gmail.com>
Date: Thu, 1 Mar 2007 22:54:56 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Failed write to /selinux/context in selinux_trans_to_raw_contex()
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702282357i2f5645bbmab4c04a0bdb1d3f3@mail.gmail.com>
	 <1172751150.19041.536.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703010810g64146e59h184dfe13365e16ce@mail.gmail.com>
	 <1172765760.19041.578.camel@moss-spartans.epoch.ncsc.mil>
	 <e739902b0703011324y561503a0v49ded6db4b700b8c@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

As you suggested, I found adding the following two lines to the
policy.conf file allowed me to successfully login.

type sysadm_t;
role sysadm_r types sysadm_t;

Just wanted to let you know I got it working!

Thanks,

- Ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
