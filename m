Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Eric Gingras (LMC)" <Eric.Gingras@ericsson.ca>,
        "SELinux Mailing list (E-mail)" <SELinux@tycho.nsa.gov>,
        "LSM Mailing List (E-mail)" <linux-security-module@wirex.com>
Subject: Re:
Date: Thu, 29 Aug 2002 18:21:59 +0200
References: <7B2A7784F4B7F0409947481F3F3FEF8304ACC35A@eammlnt051.lmc.ericsson.se>
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8304ACC35A@eammlnt051.lmc.ericsson.se>
MIME-Version: 1.0
Message-Id: <20020829162159.761989285@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Aug 2002 17:48, Eric Gingras (LMC) wrote:
> When using the sysadm_r role, starting HTTPServer, and checking the process
> with ps --context, the domain of the process is "HTTPServer_t".  So
> everything looks normal.  But when using the user_r role, starting
> HTTPServer, and checking the process with ps --context, the domain of the
> process is "user_t".

The HTTPServer_t domain is not permitted in the user_r role.

There is only a domain_auto_trans rule for starting from sysadm_t not from 
user_t.

Also for a system daemon you should put it in role system_r, and have the 
domain_auto_trans rule define a transition from initrc_t (or just use the 
daemon_domain macro).

Look at slapd.te or the latest named.te for an example of how to setup a 
daemon properly.

Also such a daemon then needs a start script in the /etc/init.d directory and 
has to be started by run_init.

> The goal was to allow the execution of HTTPServer to the sysadm_r and not
> to user_r.  A couple of things (e.g. commenting transition rules) to block
> the transition from HTTPServer_t to user_t, were tried without success.
>
> Would you have any helpful recommandation or ressource ?

The macro in macros/user_macros.te calls can_exec_any() from 
macros/global_macros.te which allows it to execute any file type with the 
attribute exec_type.  Remove exec_type from the type declaration for 
HTTPServer_exec_t and the user won't be able to execute it.


Russell Coker


PS It's not really a LSM issue.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
