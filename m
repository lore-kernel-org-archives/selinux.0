Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA19804
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 13:16:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA14871
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 18:12:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA14867
	for <selinux@tycho.nsa.gov>; Mon, 10 Feb 2003 18:12:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: FOSDEM report
Date: Mon, 10 Feb 2003 19:15:27 +0100
Cc: colin@colino.net
References: <200302101801.NAA08346@moss-shockers.ncsc.mil>
In-Reply-To: <200302101801.NAA08346@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302101915.27009.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 10 Feb 2003 19:01, Stephen D. Smalley wrote:
> > Colin Leroy was the first (and AFAIK only) person to solve this.  Firstly
> > he put in a cron job for user "easy" to do "ls" on the easy home
> > directory (mode 0700 which prevented root from inspecting it directly
> > even though both "root" and "easy" were in user_r) and discovered the
> > file /home/easy/FLAG but couldn't read it because it was owned by root
> > and more 0600.
>
> So you are trying to use SELinux to separate two users who are both in
> the same role/domain?  That's a job for DAC, not MAC.

True.  But testing in unlikely situations is a good idea as it can lead to 
improvements in the recommended usage.

> Put them into
> different roles/domains if you want to separate them via the MAC
> policy.

I agree, that's the recommended way of running serious servers.

> At least part of the problem here is the hardcoded check in crontab for
> the root uid.  SELinux can prevent interactions between different
> roles/domains, but you would need a wrapper or patched crontab similar
> to spasswd to deal with the hardcoded logic in the application that
> enables root to operate on other users (as long as they have the same
> role/domain).

Hopefully Solar Designer's patches will deal with much of this.

> > Also I noticed that user_crontab_t had capability net_bind_service and
> > could think of no possible reason for that so I removed it from my tree.
>
> Likely an artifact if you are running something like NIS, and crontab
> performs any kind of uid/username lookup that translates to a network
> request in the library (unless using some kind of proxy).

Does NIS rely on the client being bound to a low port for correct operation?

> > The next thing that occurred to me is that vi should not run in the
> > user_crontab_t anyway, so I put in a domain_auto_trans rule to transition
> > to user_t when running { bin_t sbin_t exec_type } so that the editor can
> > run in user_t and not have any special access.
>
> Shouldn't matter, as user_crontab_t is a derived domain anyway that can't
> touch the crontabs of other roles/domains.

True.  However there is another benefit for running vi in user_t, if I allow 
user_t to access another file type then the users will expect that they can 
also import from such types into cron with the ":r" command in vi.  Using 
user_t for the editor allows this.

> > Another thing that Colin noticed is that as there was no crontab entry
> > for my account "rjc" he could create one to run cron jobs as
> > rjc:user_r:user_crond_t which gets him access to my identity.  However as
> > I had not allowed transitions from user_r to staff_r or sysadm_r that did
> > not gain much.
>
> crond checks the context that will be used for the cron job process against
> the context of the crontab file, so he can't plant a crontab that is run
> in a different role/domain.  That is the point of the crond entrypoint
> permission check.  And he can't switch roles without re-authenticating via
> newrole.

True.  This method did not get very far.

However there is another issue that just occurred to me.  It would be nice to 
be able to run multiple cron jobs in different roles for the same UID.  When 
a user is granted access several roles they will reasonably expect to be able 
to run cron jobs in all of them.

I plan to add such support to fcron, I don't plan to add such support to Vixie 
cron because it seems that it's been too heavily patched without upstream 
support already.  Also the architecture of fcron makes such things easier.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
