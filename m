Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24057
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 17:55:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10258
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:54:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10254
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 21:54:37 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: More Samba
Date: Thu, 1 Aug 2002 23:55:14 +0200
References: <000801c239a5$9a226e50$0300a8c0@donkey>
In-Reply-To: <000801c239a5$9a226e50$0300a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020801215515.35EBB493@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Aug 2002 23:51, Ryan Bergauer wrote:
> On August 1, 2002, Russell Coker wrote:
> > Why does logrotate just need read access?
>
> I'm not totally sure. I received messages denying the read access, noted
> that they were necessary, and added those - however, in the month that
> I've been running this policy, I haven't yet needed anything else.

Strange, could you please send me the logrotate configuration file in 
question?

> On a related note, I just realized that I didn't take into consideration
> the case where the log files need to be created. In those cases, smbd_t
> and nmbd_t both need add_name and write access for dir in samba_log_t.

rw_dir_create_file({ smbd_t nmbd_t }, samba_log_t)

> >> I'm also receiving the following denied message, and I'm like some
> >> suggestions on the best way to handle it.
> >>
> >> avc:   denied   { read } for  pid=3486 exe=/bin/cat
> >> path=/var/log/samba/log.nmbd dev=03:02 ino=1753604
> >> scontext=system_u:object_r:system_crond_t
> >> tcontext=system_u:object_r:samba_log_t tclass=file
> >
> > What script calls it?
>
> 00-logwatch in cron.daily

Please send me a copy of that file.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
