Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15259
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 09:38:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA26700
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 14:37:45 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA26696 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 14:37:44 GMT
Date: Mon, 25 Mar 2002 09:38:20 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Leslie J. French" <ljf@semandex.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Location of policy rules
In-Reply-To: <BFEMIIHKHLALNELLMPOMEEMPCAAA.ljf@semandex.net>
Message-ID: <Pine.GSO.4.33.0203250922180.1015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 23 Mar 2002, Leslie J. French wrote:

> I want to enable the "halt" userid for console login and ssh access to shut
> down a machine remotely, *without* allowing root access over ssh.
> Naturally, I want to limit the exposure this gives. So, I created a "halt_t"
> domain similar to the other
> daemon-type domains, and I lock the "halt" user id into that domain, giving
> it exec access to /sbin/halt, which is now of type halt_exec_t etc...

So /sbin/halt (halt_exec_t) is the entrypoint for the halt_t domain, and
this domain can be entered from local_login_t or sshd_t.

> This has the side-effect of locking out /sbin/halt from root, since it
> doesn't have any access to halt_exec_t.

I don't think so.  If you associated the "exec_type" attribute with
halt_exec_t (which you should have done), then sysadm_t should still be
able to execute /sbin/halt without any problem, since it includes the
can_exec_any macro and this macro grants execute access to all of the
exec_type types.  By default, sysadm_t would not transition to halt_t, and
there is no obvious reason to define a domain transition in that case,
since sysadm_t already has the necessary permissions to halt the system.
Notice that domain transitions are context-dependent (i.e. you can have
login or sshd transition to halt_t upon executing /sbin/halt while
leaving sysadm_t unchanged when executing /sbin/halt).

Restricting execute access to /sbin/halt has little meaning for the user
domains (user_t, sysadm_t), since a user domain can always create its own
halt program unless you impose restrictions on the creation of executables
by user domains.  The issue is not whether a user domain can execute
/sbin/halt, but whether the user domain has the necessary permissions to
invoke the kernel operations required to perform a halt (e.g. Can the user
domain signal init?  Can the user domain invoke the reboot system call?).
The user_t domain lacks these permissions, while the sysadm_t domain has
them.

> Here is my question:
> Assuming this is the right approach [if not, do tell what is], where should
> I put the additional rules to allow sysadm to halt the machine.  Is it:
> (a) in sysadm.te so that all the sysadm rules are in the same place; or
> (b) in halt.te so that this "feature" becomes a stand-alone domain
> definition in the system?
>
> I know they all end up in the same place, but I'm torn between wanting to
> build a modular configuration vs not introducing potentially dangerous
> sysadm_t permissions in an unexpected place.

The sysadm_t domain shouldn't require any changes to continue being able
to execute /sbin/halt or to halt the machine.

With regard to the general question of where to place rules, it is
difficult to define a single convention that always applies.  My original
intent was to always place rules in the .te file of the source domain, so
that you could see all permissions and outgoing transitions for a given
domain by inspecting its .te file.  But this convention is often contrary
to cleanly encapsulating domains, and it doesn't work well in many cases
where you have domains or types that are instantiated through macro
definitions.  Hence, we've been gradually seeking to provide greater
encapsulation of each program and daemon domain.  Ultimately, policy
analysis tools should make it easy to obtain either "view" of a domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
