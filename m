Subject: Re: Who is responsible for role assignment?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F34E9E30AB0797D837EDF94AF160@phx.gbl>
References: <BAY114-F34E9E30AB0797D837EDF94AF160@phx.gbl>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 09:34:33 -0400
Message-Id: <1160487273.16807.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-09 at 14:50 +0200, Salvo Giuffrida wrote:
> >From: Joshua Brindle <jbrindle@tresys.com>
> >To: Salvo Giuffrida <giuffsalvo@hotmail.it>
> >CC: selinux@tycho.nsa.gov
> >Subject: Re: Who is responsible for role assignment?
> >Date: Mon, 09 Oct 2006 07:43:09 -0400
> >
> >Salvo Giuffrida wrote:
> >>Who is responsible for role and domain assignment during the login? The 
> >>single programs listed in the default_context file (ssh, login, cron, su, 
> >>etc..)? Or is this a "trasparent" operation, done by the security server?
> >>Thanks
> >The login programs attempt the contexts in default_context in order. The 
> >first to succeed wins. The security server doesn't know about abstract 
> >events like logins and has no reason to.
> I though that, during the creation of the shell process by the login 
> programs (using fork() and execve()), the security server was responsible 
> for correct labeling of the child process created.
> But it looks like this is a responsibility of the login programs 
> themselves....So, this implies that they've been modified to use libselinux 
> APIs (setexeccon(), and so on)?

Yes, they are either modified or leverage existing use of PAM to invoke
pam_selinux in order to set the exec context for the user shell
appropriately.  Note however that it is the kernel policy that governs
the set of authorized contexts that are legitimate for the user and to
which the login programs can transition.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
