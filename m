Date: Tue, 17 Dec 2002 19:28:56 -0500
From: forrest whitcher <fw@fwsystems.com>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition -- enabling user_r in eklogin
Message-Id: <20021217192856.427b5d68.fw@fwsystems.com>
In-Reply-To: <200212171725.MAA01304@moss-shockers.ncsc.mil>
References: <200212171725.MAA01304@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Dec 2002 12:25:33 -0500 (EST) 
"Stephen D. Smalley" <sds@epoch.ncsc.mil> did inscribe thusly:

>
> This looks like you aren't using the SELinux-patched login program.
> The login process needs to set the security context for the user session
> and to relabel the tty based on that security context.  If you use an
> unmodified login, you'll get the behavior above.
> 

Ahh thanks! that was indeed it, darned if I can figure out why /bin/login
wasn't correctly replaced in the 'make install', but anyhow once login
and login.krb5 are replaced with the patched version, yes all works 
nicely.

I'll look into adding kerberos auth to newrole(1) to save retypings of
password next.

forrest

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
