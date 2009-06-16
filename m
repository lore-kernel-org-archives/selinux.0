Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5GHV5hi015005
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 13:31:05 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5GHVUQs024592
	for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 17:31:31 GMT
Received: by ewy7 with SMTP id 7so7834872ewy.18
        for <selinux@tycho.nsa.gov>; Tue, 16 Jun 2009 10:31:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A372B2F.9000804@ak.jp.nec.com>
References: <aa22f0200906152148g77b0c37fo56c78fc5bb7dfa71@mail.gmail.com>
	 <4A372B2F.9000804@ak.jp.nec.com>
Date: Tue, 16 Jun 2009 19:31:03 +0200
Message-ID: <aa22f0200906161031o1bce77a4hce55bdcc95ea8dc4@mail.gmail.com>
Subject: Re: Possible bug with fd class?
From: Jason Johnson <jason.johnson.081@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2009/6/16 KaiGai Kohei <kaigai@ak.jp.nec.com>:
>
> The "fd" class represents a file descriptor object, not any filesystem
> objects. For example, if you open the /tmp/aaa, this file belongs to
> "file" class, but the file descriptor of the file belongs to "fd" class.

I figured it was something like that, but I didn't see any actions I
could take on fd's.

> It seems to me the policy does not allow:
>
>  logrotate_use_fds(syslogd_t)
>
> The fd class inherits the security context of the process which opened
> itself.

Ok, fair enough, but why is syslog-ng seeing /dev/null as a
logrotate_t target?  If logrotate opens /dev/null (as it probably
does) that shouldn't affect any other process that opens that same
device.  If it does that sounds like a potential security problem.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
