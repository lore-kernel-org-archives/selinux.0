Subject: Re: security_task_getsecid and selinux_get_task_sid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <698109.14273.qm@web36607.mail.mud.yahoo.com>
References: <698109.14273.qm@web36607.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 16:54:16 -0400
Message-Id: <1186001656.15215.377.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 13:39 -0700, Casey Schaufler wrote:
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Wed, 2007-08-01 at 12:49 -0700, Casey Schaufler wrote:
> > > Is there any difference between calls to security_task_getsecid() and
> > > selinux_get_task_sid() with selinux installed? It doesn't look like
> > > there is, but I could be missing something.
> > 
> > No, there is known duplication between the direct SELinux exports and
> > certain LSM hooks, a consequence of audit going one direction and
> > labeled networking going the other.  On our todo list for cleanup unless
> > you get to it first.  Same thing applies for e.g.
> > security_secid_to_secctx vs. selinux_sid_to_string.
> 
> OK, thank you.
> 
> On a related note, selinux_get_inode_sid() has no LSM equivilent.
> This isn't surprising, but it's one of the interfaces I need to
> address for my own nefarious purposes. Which would you prefer:
> 
>    security_inode_getsecid()
>    security_inode_sid()
>    security_get_inode_sid()
> 
> I would lean toward security_inode_getsecid() because of the existing
> security_task_getsecid(), but as it's your code I'm mucking with I
> wouldn't want to impose my taste without asking.

See patch 1/7 in the labeled NFS series.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
