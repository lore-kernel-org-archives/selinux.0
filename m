Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CLbla5015947
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 17:37:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k5CLbkZt022814
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 21:37:46 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <448DC130.4010309@redhat.com>
References: <448DC130.4010309@redhat.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 17:39:16 -0400
Message-Id: <1150148356.18657.32.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-12 at 15:32 -0400, Daniel J Walsh wrote:
> Fix prelink file context
> 
> Add unconfined_domain transition to rpm_script_t,
> also moved bootloader transition out of targeted policy ifdef
> 
> webalizer wants to do udp.
> 
> One last fix for allowing mounting any file on any file.

Is this supposed to be all files or non security files?  The docs and
interface name are inconsistent with the implementation.

> gfs2 supports extended attributes.
> gfs does not, so I am calling them nfs
> 
> New version of automount wants new privs.
> 
> I am looking into updating prelink cron entry to do restorecon to 
> eliminate avc messages, also trying
> to get prelink maintainer to modify program which would make this change 
> not as important
> 
> hplib is communicating with nfs somehow.

Interesting, I always thought this access (which was in can_network())
was a leaked fd.  If possible, can you find out more?  Moved the add up
a few lines in the file.

> proftpd uses a socket to communicate with itself
> 
> hald needs nsswitch stuff
> 
> krb5kdc needs to read kernel network state.
> 
> mysql uses nsswitch
> 
> NetworkManager neets to transition to pppd to bring up dialup networking.
> 
> ntpd - nsswitch
> 
> procmail transition to clamav
> 
> pegasus we need to setup a chat with pegasus maintainer.  He wants 
> transition from unconfined_t.
> 
> pyzor wants to read home dir.
> 
> xfs - nsswitch
> 
> Fix auditd config files specs

dropped some hunks that reverted some of my changes

> semanage needs additional perms to work with setrans file
> 
> merged unconfined_execmem into unconfined.te

dropped the fc changes.  see my previous email on mplayer, and for the
others, unconfined_execmem_exec_t only exists in the targeted policy, so
these lines have to be wrapped with the targeted_policy ifdef.  also
dropped hunks that reverted my changes.

> remove todo stuff from userdomain.
> 
> useradd needs to be able to create user_home_dir_t in mls policy

The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
