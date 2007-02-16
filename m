Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1GLuuE1028927
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 16:56:56 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1GLwAET021144
	for <selinux@tycho.nsa.gov>; Fri, 16 Feb 2007 21:58:10 GMT
Subject: Re: Latest diffs - Resent with additional changes.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45B8ACBF.8090201@redhat.com>
References: <45B8ACBF.8090201@redhat.com>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 16:58:21 -0500
Message-Id: <1171663101.20576.147.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(Karl, see the 3rd part: userdom_executable_file)

On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote: 
> allow_unconfined_execmem_dyntrans is only used on ia64 platforms to run
> 32 bit applications.  kernel does some funny stuff and rexecs
> unconfined_t programs but needs execmem and execstack.  Otherwise ia64
> has to run all apps with execmem execstack.

Almost makes me want to make an arch_ia64 tunable.  Aside from the usual
non-tranquil processes arguments, I'm not sure if this has to be
tunable, since its just going from unconfined to unconfined_execmem,
which are pretty much the same domain.

> The MLS constraints are really screwed up.  Need to come to some kind of
> agreement between you, klaus and tcs.

I'm not familiar with the LSPP requirements, so its mainly up to Klaus
and the TCS guys to iron out what makes sense.

> userdom_executable_file is still in there.  I believe we need to separate
> out the executables that are expected to be run by a user and those
> expected to be run by the system.  This helps prevent accidently running
> of applications under sysadm_t.

I have seen where you were going with this, but I think the ssh agent
unix socket and xserver's xsession-errors.log inheritance (i.e. leak fd
by design) are more evidence that the answer is a little more
comprehensive, like an application domain interface, so we can collect
up the domain and the entry point into attributes.  I don't think this
should go into userdomain since it doesn't have to do with the
definition of user roles.  I also don't think it belongs in the domain
module, since thats a more primitive concept, it should be in a system
layer module (just like init's init_daemon_domain()), so this probably
should get its own system layer module.  The domain_interactive_fd()
stuff should probably be included in this too.  Karl, do you have any
thoughts on this?

> mkinitrd should not be confined and should not be labeled
> bootloader_exec_t.  This just causes too many problems and little
> benifit.

We'll also have to start analyzing the policy to see what can be removed
because of this.  I suspect that most of the distro_* and optionals can
be removed.

> I do not want consoletype and hostname transitioning to their domains
> unless they need the privs,  Having them transition from an init script
> is broken, because you end up with tons of denials when applications
> redirect stdin/stdout

Not transitioning consoletype might work, assuming use in init scripts
don't need the privs, and then sys_admin would probably need to be
dontaudited in initrc_t.  However, I can't see how hostname not
transitioning from initrc can work, since setting the hostname certainly
requires sys_admin, and we don't want to give sys_admin to initrc_t.  I
also noticed that initrc_t has sys_admin for distro_redhat because of
kmodule.  I don't know if thats still needed, but you won't see if stuff
breaks if consoletype and hostname don't transition because of this.

> Certain tools have rpm libraries built into them and these end up
> calling the transition rules and getting denials.  I want to allow
> unconfined_t to transition to rpm_script_t

This sounds weird to me, what would be an example of a tool that has
this problem?  Also if these are redhat tools then this should be in a
distro_redhat.

> rpm execs prelink and chats with hal, also needs to kill processes
> running at different sensitivity levels

a rebasing problem, its there already.

> Added a tzdata domain to allow proper context of /etc/localtime

moved to admin layer

> usermanage was changed to allow useradd to automatically label the
> homedirs correctly.  useradd now has a -s qualifier that allows it to
> select the selinux user.  It also then labels the directory correctly.
> Critical for MLS and Strict policy to work.

I don't understand this part of the change:

+# Required because semanage execs these and hands them useradd_t:fd
+seutil_domtrans_setfiles(useradd_t)
+seutil_domtrans_loadpolicy(useradd_t)

also, why was apache_manage_all_content(useradd_t) added?

> evolution still needs work.  (I mainly use thunderbird...)

I'm merging these, but I think in the long run all the domains in
evolution probably need to be merged; there really isn't anything gained
by having all the separate domains.

There was also a weird ifdef soffice at the bottom of thunderbird.if.

> Not sure why you want if targeted_policy in loadkeys_run?

Well if we want it to act the same in strict and targeted, the ifdefs
need to be removed in both files, but that wasn't happening.

> Still want break out of hi_reserved_port_t from reserved_port_t.

I don't have a problem with breaking them up, but the current
implementation needs some work.  The current interfaces that give access
to reserved_port_t shouldn't also give access to hi_reserved_port_t.

> Several domains want to run telinit.  Added init_exec.

Probably should use init_telinit() and add exec for init_exec_t to the
interface.

> Remove anacron_exec_t.   Just run in crond_t.

What is the motivation for this?  Looks like there are other changes in
here that are MLS-only; should be in an ifdef enable_mls.

> cups changes to run in MLS

moved the first change down.  the second change is already in, at the
top of the file.

> fixes to allow inetd to run on mls

rearranged this, so be careful when you update

> sendmail wants to read clamav_libs

Weird.  moved up.

> fixes for authlogin handling of keyrings and mls, as well as pcscd

Can you elaborate some more on what you're trying to do with the keyring
parts.

> mkswap should not run as fsadm.  Should be labeled sbin_t.

Without it being fsadm_t, you can't run it on disk partitions.

> fixes for iptbales to use nscd

moved this block down

> local_login needs additional privs

Can you elaborate on these; they all seem odd.

> lvm needs privs for multipath

Can you elaborate as to why multipath (dm/lvm) needs net_admin?  A
cursory look through the docs doesn't mention the network at all.

> initrc replace localization files using cp -A to preserve context.  This
> causes many avc messages.

Moved this to distro_redhat.

> modutils fixes for strict policy

Why would depmod delete kernel modules?  Seems more like a mislabeled file.

> Need correct labels for genhomedircon and system-config-selinux to
> create context correctly.

Why would genhomedircon be ran directly instead of semodule or semanage?

> Lots of fixes for polyinstatiation on MLS

Why is corecmd_exec_bin() needed?

----

What is /dev/twe[^/]* and why is it labeled as a fixed disk (esp. since
its a character node)?

The term_unconfined() seems superfluous.

This seems excessive:

+# allow setkey to read a config files in any directory.
+userdom_read_sysadm_home_content_files(setkey_t)
+userdom_read_all_users_home_content_files(setkey_t)

There is an addition which allows ricci_moservice_t to create an init
script, and it can already transition to initrc_t with init scripts
entrypoints.  Does it really need this?

Why?
+allow nmbd_t samba_log_t:file unlink;

I noticed several ptrace additions.  Is there something new that is
causing these domains to trace themselves?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
