Date: Tue, 17 Dec 2002 12:10:38 -0500
From: forrest whitcher <fw@fwsystems.com>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: russell@coker.com.au, SELinux@tycho.nsa.gov
Subject: Re: Domain transition -- enabling user_r in eklogin
Message-Id: <20021217121038.7bd1df69.fw@fwsystems.com>
In-Reply-To: <200212171614.LAA01255@moss-shockers.ncsc.mil>
References: <200212171614.LAA01255@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Tue, 17 Dec 2002 11:14:38 -0500 (EST) (unchecked - local sync NTPstrat4)
"Stephen D. Smalley" <sds@epoch.ncsc.mil> did inscribe thusly:

fw:
> > 
> > Also this test is being done on a slackware setup, because I was able to
> > get telnetd working in a redhat system more easily there may be some system 
> > layout issues causing problems, not sure yet.
> 
"Stephen D. Smalley" <sds@epoch.ncsc.mil> 

> The example policy includes rules to transition from inetd_t or tcpd_t to 
> rlogind_t upon executing a file labeled with the rlogind_exec_t type (assigned 
> to in.rlogind and in.telnetd in the file contexts configuration), and to 
> transition from rlogind_t to remote_login_t upon executing a file labeled with 
> the login_exec_t type (assigned to login in the file contexts configuration).  
> The remote_login_t domain can then transition to user_t, at which point
> the user can run newrole if the user has an entry in the policy/users
> file and is authorized for any other roles.  If the user lacks an entry in the 
> policy/users file and you retain the user_u entry in policy/users, then the user 
> will be mapped to the generic user_u identity for the SELinux security context 
> and will be limited to operating in user_r.
> 

Stephen, Ok, I see you're right, I'd thought that this: (login.te)
--
# Only permit unprivileged user domains to be entered via rlogin,
# since very weak authentication is used.
domain_trans(remote_login_t, shell_exec_t, unpriv_userdomain)
--

was the source of the behavior, that wasn't it, local console login was also
broken and like an idiot I hadn't connected this, on console login also, the
context is system_u:system_r and I get the following messages:

avc:  denied  { ioctl } for  pid=142 exe=/bin/bash path=/dev/tty1 dev=08:02 ino=22757 scontext=system_u:system_r:user_t tcontext=system_u:object_r:tty_device_t tclass=chr_file
avc:  denied  { ioctl } for  pid=142 exe=/bin/bash path=/dev/tty1 dev=08:02 ino=22757 scontext=system_u:system_r:user_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

Those failures kill the shell in enforcing mode of course.

so some transition in the local_login domain is missing, I'll try to dig out the
root of that problem. ssh login is working fine on the slackware installation.

forrest


> --
> Stephen Smalley, NSA
> sds@epoch.ncsc.mil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
