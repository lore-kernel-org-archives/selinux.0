Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA10255
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 09:02:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA12493
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 13:01:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA12489 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 13:01:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
Date: Fri, 19 Apr 2002 15:02:24 +0200
References: <20020419143800.B18906@lemuria.org>
In-Reply-To: <20020419143800.B18906@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020419130224.B2E2544E9E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 14:38, Tom wrote:
> Why does it not do a domain transition to initrc_t when the scripts are
> executed by sysadm_t (i.e. manually by the sysadmin) ?

Here's the answer Steve gave when I asked that question:
http://marc.theaimsgroup.com/?l=selinux&m=101170830818619&w=2

> With the example policy, the same process started at system boot or
> manually later will run in different domains. I've added this line to
> domains/program/initrc.te:

You are supposed to use "run_init /etc/init.d/daemon start" to start the 
daemon.

> But please tell me if there's a reason why it's not there, and I'm dumb
> and/or compromising the system's security. In order for this to work
> on debian, I also added to file_contexts:
>
> /etc/init.d(|/.*)               system_u:object_r:initrc_exec_t

I tried that once, but decided it was a bad idea and changed it back.

> The weird part is that SOME of the program.te files have a
> domain_auto_trans line which serves essentially the same purpose. Does

Which ones are you referring to?

>From a casual inspection I can't see any daemon what has such a 
configuration.  There are many utility programs such as fsck and ifconfig 
that do, but they are in a different category.

> Finally, some patches/changes to add proftpd support (using the
> existing ftpd types and files):
>
> add to domains/program/ftpd.te:
> domain_auto_trans(initrc_t, ftpd_exec_t, ftpd_t)

I've put in the following:
domain_auto_trans({ initrc_t inetd_t tcpd_t }, ftpd_exec_t, ftpd_t)

Better one line than 3.

> /etc/proftpd.conf             system_u:object_r:etc_ftp_t
> /usr/sbin/proftpd             system_u:object_r:ftpd_exec_t
>
> plus the ftpd.te line from above and proftpd should be working. the
> etc_ftp_t type was added by me to types/file.te:
>
> type etc_ftp_t, file_type, sysadmfile;

OK, I've merged that in my tree.  But I've changed etc_ftp_t to etc_ftpd_t 
(next you might want a policy for ncftp or some other FTP client that has 
config files in /etc).

> next time, I'll post a real diff file. my current playing-around policy
> is so messed up that making a diff is not practical, sorry.

You could just email me the files complete.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
