Message-Id: <200212171614.LAA01255@moss-shockers.ncsc.mil>
Date: Tue, 17 Dec 2002 11:14:38 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Domain transition -- enabling user_r in eklogin
To: russell@coker.com.au, fw@fwsystems.com
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> For which I've been having problems getting an appropriate transition working.
> (the following may have some typos I don't have either box running just now
> to refer to)
> 
> The remote_login domain was clearly designed with telnet in mind, there is
> no transtion to user_u:user_r.
> 
> Looking this over I moved login.krb5 into the same SID as /bin/login, using
> login.te as an example, however once the user's successfully authenticated
> the domain remains system_u:system_r and 'newrole(1)' is not available.
> 
> I'm going somewhat from memory so there may be some missed details, however
> I've tried re-configuring several times without much luck.
> 
> Also this test is being done on a slackware setup, because I was able to
> get telnetd working in a redhat system more easily there may be some system 
> layout issues causing problems, not sure yet.

The example policy includes rules to transition from inetd_t or tcpd_t to 
rlogind_t upon executing a file labeled with the rlogind_exec_t type (assigned 
to in.rlogind and in.telnetd in the file contexts configuration), and to 
transition from rlogind_t to remote_login_t upon executing a file labeled with 
the login_exec_t type (assigned to login in the file contexts configuration).  
The remote_login_t domain can then transition to user_t, at which point
the user can run newrole if the user has an entry in the policy/users
file and is authorized for any other roles.  If the user lacks an entry in the 
policy/users file and you retain the user_u entry in policy/users, then the user 
will be mapped to the generic user_u identity for the SELinux security context 
and will be limited to operating in user_r.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
