MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: newrole in the background
Date: Thu, 13 Dec 2007 10:56:47 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F597812@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net> <476047A9.90000@gmail.com> <436A69503F99214D9EBC27415F66C40C0F517AD3@blums0008.bluelnk.net> <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil> <cadfc0e40712130641r301dd959x895f33ff1e72f581@mail.gmail.com> <1197558486.20226.40.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F597703@blums0008.bluelnk.net> <1197567614.20226.141.camel@moss-spartans.epoch.ncsc.mil>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Xavier Toth" <txtoth@gmail.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All right I'll clean it up.

Thanks


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, December 13, 2007 12:40 PM
To: Reed, Tim (US SSA)
Cc: Xavier Toth; SE Linux
Subject: RE: newrole in the background

On Thu, 2007-12-13 at 09:06 -0800, Reed, Tim (US SSA) wrote:
> New patch...I have added checks around the calls that deal with the
tty.
> So if ttyn is an empty string (something had a heartache with it being
> NULL) then it skips the processing.  It does appear to work but more
> testing is needed.  Please review and comment.

Patch is reversed, and doesn't seem to be complete (test for a NULL
ttyname still remains and is fatal in main).

ttyn should really be NULL if not defined - just fix the code.  Cleaner
and faster to test for NULL than for empty string.  Looks like
authenticate_via_pam() needs a check.

You can simplify the logic a fair amount, e.g. on entry to relabel_tty()
and restore_tty_label(), just do a if (!ttyn) return 0;

Coding style doesn't match.

> Now say if someone ran `newrole -l SystemHigh -- -c "su - foo"` in the
> background of a script, you would not be able to give su input as it
is
> in the background and has no tty.  su in this case exits gracefully I
> guess you could say.  
> 
> My point is that if you have an application that needs to run from
> newrole, in the background AND requires user input, you will not be
able
> to give the application input while it is in the background and have
it
> work successfully.

You can't do that anyway, by definition.

> Example:
> foo.sh
> ---------------
> #!/bin/bash
> 
> ./bar.sh &
> ---------------
> bar.sh
> ---------------
> #!/bin/bash
> 
> su - root -c /bin/date
> ---------------
> 
> su exits because there is no tty for input.  So is chasing down having
> newrole run in a pseudo tty in the background and accept input worth
the
> time?

It doesn't help - there is no input to accept.

We just need to make sure that the pam modules and chkpwd don't block
forever or seg fault when handed a NULL PAM_TTY.

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
