Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA29347
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 15:32:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA11728
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 20:32:25 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA11724
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2001 20:32:24 GMT
Date: Tue, 20 Nov 2001 15:32:10 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dan Berberich <dberb@bellatlantic.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: sendmail config question
In-Reply-To: <5.1.0.14.0.20011120145757.009e7820@impop.bellatlantic.net>
Message-ID: <Pine.GSO.4.33.0111201514160.17556-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 20 Nov 2001, Dan Berberich wrote:

> When simply sending mail from root to user or form user to user on
> localhost I get an avc denial message
> avc: denied { remove_name search } for pid=675 exc=/bin/mail
> path=/var/spool/mail/user_02 dev=03:05 ino=310085
> 	scontext=user_02:user_r:user_t
> 	tcontext=system_u:object:r:mail_spool_t
> 	class=dir

This indicates that the /bin/mail program is trying to directly drop the
message into /var/spool/mail.  Since /bin/mail doesn't run in a separate
domain and the ordinary user domain lacks these permissions, this access
is denied.

On my system, when I send mail to a local user (whether from root to a
user or from a user to a user), the sendmail program is executed by mail,
which does cause a transition to a new domain (either user_mail_t or
sysadm_mail_t, depending on whether you were logged in as user_t or
sysadm_t) that can write to /var/spool/mail.  And even if I were to place
/bin/mail into a domain that can write to /var/spool/mail, the Unix
permissions wouldn't allow this behavior, since /bin/mail isn't setuid or
setgid and /var/spool/mail isn't world writeable.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
