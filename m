Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88CPLxO016281
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 08:25:21 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88COoFx017808
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 12:24:57 GMT
Received: by py-out-1112.google.com with SMTP id 39so670059pyu
        for <selinux@tycho.nsa.gov>; Fri, 08 Sep 2006 05:25:21 -0700 (PDT)
Message-ID: <45016127.3090607@kaigai.gr.jp>
Date: Fri, 08 Sep 2006 21:25:11 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [RFC] SELinux and PostgreSQL
References: <44FFEB42.90203@kaigai.gr.jp>	 <1157633535.14982.9.camel@twoface.columbia.tresys.com>	 <200609072324.51487.russell@coker.com.au> <45002CA4.40907@kaigai.gr.jp>	 <3FCBC9B9.8000302@tresys.com>  <45004041.3020407@kaigai.gr.jp>	 <1157648557.22185.8.camel@twoface.columbia.tresys.com> <1157649490.22185.11.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157649490.22185.11.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Because the SMTP server of my office was not allowed to deliver
SELinux-list, I posted it again from my house.
I'm sorry if you received same message twice.

>> At a minimum you should have the different kinds of objects (databases,
>> tables, columns, stored procedures) and label them either explicitly or
>> via security_compute_create.
> 
> Speaking of stored procedures, Karl reminded me that we probably want
> stored procedures to be entrypoints into other domains so that you can
> use them as trusted info flow filters.

I also think it's a good idea.
This mechanism makes none-privileged users deal with sensitive data like
password safety.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
