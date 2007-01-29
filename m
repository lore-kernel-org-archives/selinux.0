Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TF8dtr013546
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 10:08:39 -0500
Received: from web51505.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0TF9fxX027653
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:09:41 GMT
Message-ID: <20070129150941.41400.qmail@web51505.mail.yahoo.com>
Date: Mon, 29 Jan 2007 07:09:41 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: missing avc message field names
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1170081328.8720.63.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I don't think it is "impossible", but it would require updating of e.g.
>audit2allow, audit2why, madison/sepolgen, setroubleshoot and seaudit
>(setools).

At some point, I'm hoping all those tools can migrate to this new API. This is to
insulate them from other changes that are coming like zlib compression and/or
binary formats.

>Are you proposing changing the raw kernel output format as well, or just
>the auditd-generated output format?

The audit daemon shouldn't really do any changing. It really should just log
exactly what it gets. If we agree that this can be changed, what we could do is
wait until the next kernel development cycle and then make this change (this
allows for some migration time). I can special case the avc message for a while
so there is some backwards compatibility.

>The 4th field could be called "result=".  It has two possible values,
>"denied" or "granted".

That could possibly conflict with syscall auditing which has the same field. You
could be in permissive mode and have denied by syscall reports success. Maybe
"ares", "avcres", "decision", "dec"? Any other suggestions?

>The 6th field could be called "perms=".

That name is already taken also. "aperms=" ?

>Its value is a space separated list, presently delimited by { } brackets.  I
>suppose it could be comma separated and space delimited instead if that matters.

Yes that would be nice.

>"for" could likely be dropped from the message altogether.
>
>"avc:" is redundant with type=AVC, but we don't get the latter in the
>raw kernel output,

No intention to change those. They get dropped by virtue of not having a '='.

>so it is useful for messages emitted when auditd is not running (either before 
>auditd starts, after it exits, or when not using auditd at all).

Thanks,
-Steve


 
____________________________________________________________________________________
Expecting? Get great news right away with email Auto-Check. 
Try the Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
