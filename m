Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LEt7Gt017211
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 10:55:07 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2LEt44b023588
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 14:55:05 GMT
Received: by py-out-1112.google.com with SMTP id a78so97129pyh
        for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 07:55:04 -0700 (PDT)
Message-ID: <46014742.8060208@kaigai.gr.jp>
Date: Wed, 21 Mar 2007 23:54:58 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: The reason why SEPostgreSQL use original userspace AVC
References: <45FE9A2F.40200@kaigai.gr.jp>	 <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil> <1174487732.22565.384.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1174487732.22565.384.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Did you measure performance using both your own AVC vs. using the
> libselinux one to see what the real impact was of these changes?

No.
I considered that it was a obvious case.
At least, two psid_to_context() and two avc_context_to_sid() per
a avc_has_perm() will be necessary additionally.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
