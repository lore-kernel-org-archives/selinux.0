From: "david caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>,
        "Eric Gingras \(LMC\)" <Eric.Gingras@ericsson.ca>,
        "SELinux Mailing list \(E-mail\)" <SELinux@tycho.nsa.gov>
Subject: RE: 
Date: Thu, 29 Aug 2002 13:32:25 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGEENBCEAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020829162159.761989285@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It doesn't matter that any user can run the server.  What matters is that
when the server is started from an untrusted domain, such as user_t, it
remains in that domain instead of transitioning to the server domain,
HTTPServer_t.  Just because any user can run the server doesn't give them
the permissions, for example, to bind the server process to port 80.  Or, if
you defined a type for the web page files, you could allow only processes in
the HTTPServer_t domain to read them.

Narrowing down the permissions of the server domain also limits an attacker,
who finds a vulnerability in your server code (e.g., a buffer overflow), to
only the capabilities you have given that domain (i.e., even though the
server might have been started by root it still couldn't read the password
file or run a shell because it is now in the more limited HTTPServer_t
domain).

Like Russell suggested below, look at how other daemons have been setup and
you'll get a good idea of what needs to be done.

David

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Russell Coker
>
> On Thu, 29 Aug 2002 17:48, Eric Gingras (LMC) wrote:
> > When using the sysadm_r role, starting HTTPServer, and checking
> the process
> > with ps --context, the domain of the process is "HTTPServer_t".  So
> > everything looks normal.  But when using the user_r role, starting
> > HTTPServer, and checking the process with ps --context, the
> domain of the
> > process is "user_t".
>
> The HTTPServer_t domain is not permitted in the user_r role.
>
> There is only a domain_auto_trans rule for starting from sysadm_t
> not from
> user_t.
>
> Also for a system daemon you should put it in role system_r, and have the
> domain_auto_trans rule define a transition from initrc_t (or just use the
> daemon_domain macro).
>
> Look at slapd.te or the latest named.te for an example of how to setup a
> daemon properly.
>
> Also such a daemon then needs a start script in the /etc/init.d
> directory and
> has to be started by run_init.
>
> > The goal was to allow the execution of HTTPServer to the
> sysadm_r and not
> > to user_r.  A couple of things (e.g. commenting transition
> rules) to block
> > the transition from HTTPServer_t to user_t, were tried without success.
> >
> > Would you have any helpful recommandation or ressource ?
>
> The macro in macros/user_macros.te calls can_exec_any() from
> macros/global_macros.te which allows it to execute any file type with the
> attribute exec_type.  Remove exec_type from the type declaration for
> HTTPServer_exec_t and the user won't be able to execute it.
>
>
> Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
