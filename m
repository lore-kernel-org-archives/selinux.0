Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA19511
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 12:54:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1AHsCI27264
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 17:54:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h1AHsCf27260 for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 17:54:12 GMT
Message-Id: <200302101801.NAA08346@moss-shockers.ncsc.mil>
Date: Mon, 10 Feb 2003 13:01:13 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: FOSDEM report
To: selinux@tycho.nsa.gov, russell@coker.com.au
Cc: colin@colino.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Colin Leroy was the first (and AFAIK only) person to solve this.  Firstly he 
> put in a cron job for user "easy" to do "ls" on the easy home directory (mode 
> 0700 which prevented root from inspecting it directly even though both "root" 
> and "easy" were in user_r) and discovered the file /home/easy/FLAG but 
> couldn't read it because it was owned by root and more 0600.

So you are trying to use SELinux to separate two users who are both in
the same role/domain?  That's a job for DAC, not MAC.  Put them into
different roles/domains if you want to separate them via the MAC
policy.

>Then he discovered that he could use the command:
>EDITOR=vi /home/easy/FLAG crontab -e -u easy

>To get at the file.

>I did some experiments later and discovered that I could do "crontab -e -u 
>easy" and then use the ":r" and ":w" commands in vi.

At least part of the problem here is the hardcoded check in crontab for
the root uid.  SELinux can prevent interactions between different
roles/domains, but you would need a wrapper or patched crontab similar
to spasswd to deal with the hardcoded logic in the application that
enables root to operate on other users (as long as they have the same
role/domain).

> Also I noticed that user_crontab_t had capability net_bind_service and could 
> think of no possible reason for that so I removed it from my tree.

Likely an artifact if you are running something like NIS, and crontab
performs any kind of uid/username lookup that translates to a network
request in the library (unless using some kind of proxy).
 
> The next thing that occurred to me is that vi should not run in the 
> user_crontab_t anyway, so I put in a domain_auto_trans rule to transition to 
> user_t when running { bin_t sbin_t exec_type } so that the editor can run in 
> user_t and not have any special access.

Shouldn't matter, as user_crontab_t is a derived domain anyway that can't
touch the crontabs of other roles/domains. 

> Another thing that Colin noticed is that as there was no crontab entry for my 
> account "rjc" he could create one to run cron jobs as rjc:user_r:user_crond_t 
> which gets him access to my identity.  However as I had not allowed 
> transitions from user_r to staff_r or sysadm_r that did not gain much.

crond checks the context that will be used for the cron job process against
the context of the crontab file, so he can't plant a crontab that is run
in a different role/domain.  That is the point of the crond entrypoint 
permission check.  And he can't switch roles without re-authenticating via 
newrole.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
