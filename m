Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JFU4gA007320
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 11:30:04 -0400 (EDT)
Received: from web31612.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j6JFObZb013317
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:24:38 GMT
Message-ID: <20050719152504.99856.qmail@web31612.mail.mud.yahoo.com>
Date: Tue, 19 Jul 2005 08:25:04 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: MCS/Targeted Policy...
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <42DD054E.1030301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Daniel J Walsh <dwalsh@redhat.com> wrote:

> Let me try.  SELinux does not give any more access
> then standard DAC 
> Controls.  So I would say SELinux is only
> restrictive  on top of 
> Standard DAC.

Yes, and therein lies a potential problem.
The reason that ACLs are integrated with mode
bits is that DAC -as a whole- needs to be
sensible. If someone decides that SELinux DAC
is better than Unix DAC (somebody will) they
may chose to eschew Unix DAC and make all their
files mode 777 (rwxrwxrwx to those born after
the epoch), counting on the presence of SELinux
to protect them they way they want to be
protected. There is no problem unless there is
a change to the SELinux DAC policy and that
policy is sufficient to meet their needs.

Boot a kernel without SELinux, or with a
different policy and you have a problem.

> ACL, however grant additional access
> over standard DAC, 
> so they are permissive
> on standard DAC.

I don't think you've read the POSIX Draft.
ACLs are intergrated with mode bits. If you
use chmod to set the mode bits the desired
result occurs. The spec is very careful
about that. The statement that ACLs grant
additional access makes no sense to me
whatever, unless you're refering to the
improved granularity of specification.




Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
