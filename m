Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA22938
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 16:15:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA07658
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 20:14:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA07654 for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2002 20:14:19 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Errors from your policy
Date: Thu, 15 Aug 2002 22:15:44 +0200
References: <20020815194304.70183.qmail@web40005.mail.yahoo.com>
In-Reply-To: <20020815194304.70183.qmail@web40005.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020815201545.4A6BB346@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 Aug 2002 21:43, Brad Chapman wrote:
> Attached to this e-mail is a partial listing of all the errors I got when I
> loaded your policy. What should I do so that I don't repeat my earlier
> problems (re: Swollen su_macros.te file) ?

For the samba policy talk to the guy who wrote it.

For alsa there is no policy, you'll have to write your own.

For syslogd and klogd, what distribution are you running?
Change this:
domain_auto_trans(initrc_t, syslogd_exec_t, syslogd_t)
To this:
domain_auto_trans({ init_t initrc_t }, syslogd_exec_t, syslogd_t)
and do the same for klogd.

For the login issue, make sure /bin/bash2 has shell_exec_t.

Where is /dev/dsp coming from?  On devfs you should have it automatically 
created in /dev/sound.

Your problems with /dev/pts indicate that you are using an old version of the 
kernel patch.

The problem with su is that your bash2 shell has the wrong type.  See my 
previous messages on this topic...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
