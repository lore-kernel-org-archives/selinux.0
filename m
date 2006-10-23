Subject: Re: Policy tests failed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610231050.14167.Daniel.Gil-Mayol@brunel.de>
References: <200610191700.20138.Daniel.Gil-Mayol@brunel.de>
	 <200610201458.42923.Daniel.Gil-Mayol@brunel.de>
	 <1161366031.29755.204.camel@moss-spartans.epoch.ncsc.mil>
	 <200610231050.14167.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 08:59:09 -0400
Message-Id: <1161608349.3316.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-23 at 10:50 +0200, Daniel Gil Mayol wrote:
> I have one script called  'exectest.py' labelled as 
> system_u:object_r:initrc_exec_t. This script get a list of all the services 
> to test. Then the "execute test" call one service of this list (supose 
> anacron). All the services, with the name format 'SERVICE_NAME.exectest.py', 
> are links to the script  'exectest.py' but labelled each one as 
> 'SERVICE_NAME_exec_t'. For example, anacron has the following link file:
> 
> lrwxrwxrwx  root     root     system_u:object_r:anacron_exec_t 
> anacron.exectest.py -> /work/SElinux-test/exectest.py
> 
> The idea was the following, we have only one test script program (it is  
> 'exectest.py') and one link for each service (with the corresponding label).

That doesn't work; the context of the symlink isn't relevant to the
context transition on execve (just as the suid bit on a symlink is
irrelevant to setuid execution).  You would need to copy your script and
label the copy with the desired entrypoint type.

> I am trying also to use the macro for dbusd calling "dbusd_domain(system);" 
> but I receive the following error:
> 
> domains/cnsu/messagebus.te:36:ERROR 'unknown boolean read_default_t in 
> conditional expression' at token 'read_default_t' on line 30533:
> if (read_default_t) {
> #line 36
> domains/cnsu/messagebus.te:36:ERROR 'illegal conditional expression' at token 
> 'allow' on line 30553:
> allow system_dbusd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock 
> search ioctl };
> #line 36

You must be using a macro that is normally only used in strict policy,
and thus lacks definitions it requires in the targeted policy.  In this
particular case, you could work around the issue by adding a:
	bool read_default_t false;
statement to your .te file.  But you may run into other problems with
using the macro due to other dependencies on strict policy.

Have you considered switching to strict policy?  RHEL 4 doesn't ship it,
but you can get an upstream one and build it yourself.  It takes a bit
of work to make the transition, but it already includes confined domains
for these processes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
