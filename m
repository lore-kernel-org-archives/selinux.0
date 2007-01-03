Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03NZsmx015916
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 18:35:54 -0500
Received: from ug-out-1314.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03NadTD024481
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 23:36:39 GMT
Received: by ug-out-1314.google.com with SMTP id y2so5999350uge
        for <selinux@tycho.nsa.gov>; Wed, 03 Jan 2007 15:36:36 -0800 (PST)
Message-ID: <f71a82820701031536j26d9d4epb84e3fe7ed95feb6@mail.gmail.com>
Date: Thu, 4 Jan 2007 08:36:35 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: cron on strict policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi
,
I'm in trouble on cron, again.
I've installed strict policy 21 on FC6 to my internet server.
I found cron does not run at all.
I imagine it's a role problem perhaps ?
Should I write role statement in cron.te ?

I semodule -r cron ed, and using
refpolicy's cron.te I used to use on FC5.

I edited /etc/crontab and
#crontab /etc/crontab
on permissive mode.

When permissive mode, it runs leaving messages something like
"Unauthorized SELinux context but persissive mode continuing"
Of course I'm now running my server on strict mode, so the cron
goes like this...
This is the cron log.
---------------------------------------
#less /var/log/cron

STARTUP (V5.0)
Dec 30 07:17:20 intrajp crond[1637]: (system_u) Unauthorized SELinux
context (/etc/crontab)
Dec 30 07:17:20 intrajp crond[1637]: (root) Unauthorized SELinux
context (cron/root)

Unauthorized SELinux context
---------------------------------------
This is the security context.
[root@intrajp ~]# ls -laZ /etc/crontab
-rw-r--r-- root root system_u:object_r:system_cron_spool_t:s0 /etc/crontab

Thanks in advance.


My homepage
http://intrajp.no-ip.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
