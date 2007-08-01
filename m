Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71KdJup028123
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 16:39:19 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l71KdHdm005451
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 20:39:17 GMT
Date: Wed, 1 Aug 2007 13:39:17 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: security_task_getsecid and selinux_get_task_sid
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1185999146.15215.375.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <698109.14273.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2007-08-01 at 12:49 -0700, Casey Schaufler wrote:
> > Is there any difference between calls to security_task_getsecid() and
> > selinux_get_task_sid() with selinux installed? It doesn't look like
> > there is, but I could be missing something.
> 
> No, there is known duplication between the direct SELinux exports and
> certain LSM hooks, a consequence of audit going one direction and
> labeled networking going the other.  On our todo list for cleanup unless
> you get to it first.  Same thing applies for e.g.
> security_secid_to_secctx vs. selinux_sid_to_string.

OK, thank you.

On a related note, selinux_get_inode_sid() has no LSM equivilent.
This isn't surprising, but it's one of the interfaces I need to
address for my own nefarious purposes. Which would you prefer:

   security_inode_getsecid()
   security_inode_sid()
   security_get_inode_sid()

I would lean toward security_inode_getsecid() because of the existing
security_task_getsecid(), but as it's your code I'm mucking with I
wouldn't want to impose my taste without asking.

Thank you again.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
