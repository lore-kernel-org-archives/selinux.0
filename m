Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88CPR7O016293
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 08:25:27 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88COoG0017808
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 12:25:03 GMT
Received: by py-out-1112.google.com with SMTP id 39so670059pyu
        for <selinux@tycho.nsa.gov>; Fri, 08 Sep 2006 05:25:27 -0700 (PDT)
Message-ID: <4501612D.2080607@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 21:25:17 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Richard Hally <rhally@mindspring.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp> <45006E1C.8040107@mindspring.com>
In-Reply-To: <45006E1C.8040107@mindspring.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because the SMTP server of my office was not allowed to deliver
SELinux-list, I posted it again from my house.
I'm sorry if you received same message twice.

> Hi,
> > 	First question, how will this interact with the current "privileges"
> > mechanism in PostgreSQL (GRANT and REVOKE commands)?

It's similar to the relationship between DAC and MAC on filesystem.
The mechanism I'm suggesting works purely an additional access control.
Thus any users's operations must be granted on PostgreSQL ACL and allowed
on SELinux security policy.

> > Second, will there be a "user space security server" or will these
> > object classes be included in the kernel policy?

The meaning is a bit unclear for me.
I intend to implement some libselinux functions into PostgreSQL
to enhance security functionality, and those functions referes
the kernel policy which will contain some new object classes.
Is is appropriate for the answer?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
