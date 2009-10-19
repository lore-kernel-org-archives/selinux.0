Subject: Re: sshd error: Failed to get default security context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Oct 2009 09:53:02 -0400
Message-Id: <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-10-17 at 11:17 -0700, Larry Ross wrote:
> 
> 
> On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
>         
>         On 10/16/2009 08:15 PM, Larry Ross wrote:
>         > I have created a custom selinux user for the strict policy
>         on RHEL5.3 who's
>         > purpose is to connect via ssh and scp files off the
>         machine.  When that user
>         > tries to login via ssh, I see the following messages
>         in /var/log/secure:
>         >
>         > In enforcing:
>         > Oct 16 07:49:40 localhost sshd[20461]: Accepted password for
>         scpuser
>         > from 192.168.1.1 port 64680 ssh2
>         > Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get
>         default security
>         > context for scpuser.
>         > Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux
>         failure. Aborting
>         > connection.
>         >
>         > In permissive:
>         > Oct 16 07:55:59 localhost sshd[23302]: Accepted password for
>         scpuser from
>         > 192.168.1.1 port 56254 ssh2
>         > Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get
>         default security
>         > context for scpuser.
>         > Oct 16 07:55:59 localhost sshd[23302]: error: SELinux
>         failure. Continuing in
>         > permissive mode.
>         >
>         > Could someone explain what these messages mean?
>         >
>         > I believe that I have a default context defined in the
>         "default context"
>         > file that should work. I believe I have an executable
>         context available for
>         > this user (using rbash rather than bash).
>         >
>         > How is sshd making this decision?  It looks like it is
>         calling setexeccon,
>         > but I'm not sure how that makes its decision.  Where should
>         I look for clues
>         > as to how to fix it?
>         >
>         >    Thank you,
>         >    Larry
>         >
>         
>         Did you add an entry to default_types?
>  
> I did.  And in default_contexts and in users/scpuser.  None of
> them fixed the issue.
> Could someone explain to me if these files are still used and what
> they are used for?  And if there are other files that might need to be
> modified as well?

Not up to date, but possibly still useful:
http://www.nsa.gov/research/_files/selinux/papers/policy2/x724.shtml
http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation
 
> At this point it looks like I was missing a rule to allow the role
> transition, but it isn't quite fixed yet (and some of the entries in
> the files above may or not have been required as well).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
