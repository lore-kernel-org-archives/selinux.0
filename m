Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24016
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 17:52:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA12839
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:50:31 GMT
Received: from snipe.mail.pas.earthlink.net (snipe.mail.pas.earthlink.net [207.217.120.62])
        by jazzband.ncsc.mil  with ESMTP id VAA12835 for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:50:30 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: More Samba
Date: Thu, 1 Aug 2002 16:51:33 -0500
Message-ID: <000801c239a5$9a226e50$0300a8c0@donkey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20020801210538.BCB2C772C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On August 1, 2002, Russell Coker wrote:

> Why does logrotate just need read access?

I'm not totally sure. I received messages denying the read access, noted
that they were necessary, and added those - however, in the month that
I've been running this policy, I haven't yet needed anything else.

On a related note, I just realized that I didn't take into consideration
the case where the log files need to be created. In those cases, smbd_t
and nmbd_t both need add_name and write access for dir in samba_log_t. 
 
>> I'm also receiving the following denied message, and I'm like some
>> suggestions on the best way to handle it.
>>
>> avc:   denied   { read } for  pid=3486 exe=/bin/cat
>> path=/var/log/samba/log.nmbd dev=03:02 ino=1753604
>> scontext=system_u:object_r:system_crond_t
>> tcontext=system_u:object_r:samba_log_t tclass=file
>
> What script calls it?

00-logwatch in cron.daily

Thanks.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
