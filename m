Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82DcQrT029002
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 09:38:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82DcMv0008923
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 13:38:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Latest Patches
Date: Thu, 2 Sep 2004 23:38:20 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409022338.20644.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Sep 2004 23:10, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > diff --exclude-from=exclude -N -u -r
> > nsapolicy/domains/program/unused/named.te
> > policy-1.17.9/domains/program/unused/named.te ---
> > nsapolicy/domains/program/unused/named.te 2004-08-27 14:44:11.000000000
> > -0400 +++ policy-1.17.9/domains/program/unused/named.te 2004-09-02
> > 08:15:02.739588362 -0400 @@ -113,7 +113,6 @@
> >  allow ndc_t self:unix_stream_socket create_stream_socket_perms;
> >  allow ndc_t self:unix_stream_socket connect;
> >  allow ndc_t self:capability { dac_override net_admin };
> > -allow ndc_t var_t:dir search;
> >  allow ndc_t var_run_t:dir search;
> >  allow ndc_t named_var_run_t:sock_file rw_file_perms;
> >  allow ndc_t named_t:unix_stream_socket connectto;
>
> You can't reach /var/run if you can't search /var.

The mistake here was removing the occurrence of that rule at line 116 instead 
of at line 145.  The rule is included twice if you enable ndc_shell_script.

> > diff --exclude-from=exclude -N -u -r
> > nsapolicy/domains/program/unused/udev.te
> > policy-1.17.9/domains/program/unused/udev.te ---
> > nsapolicy/domains/program/unused/udev.te 2004-09-01 14:00:02.000000000
> > -0400 +++ policy-1.17.9/domains/program/unused/udev.te 2004-09-02
> > 08:15:02.742588026 -0400 @@ -43,7 +43,8 @@
> >  allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom
> > relabelto create_file_perms };
> >
> >  # to read the file_contexts file
> > -r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t }
> > ) +allow udev_t { selinux_config_t default_context_t }:dir search; +allow
> > udev_t file_context_t:file { getattr read };
>
> To access the file_contexts file, udev must be able to read
> /etc/selinux/config (requires search to selinux_config_t:dir and read to
> selinux_config_t:file) and
> /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts (requires search
> to default_context_t:dir and file_context_t:dir and read to
> file_context_t:file).  Simpler to just express this using the single
> r_dir_file() line that is in our policy, even it is a bit more
> permissive than strictly necessary (your rules aren't sufficient).

My most recent patch for this is sufficient.  It seems that Dan merged in an 
earlier patch that was in a development stage.

> > diff --exclude-from=exclude -N -u -r
> > nsapolicy/macros/program/ssh_macros.te
> > policy-1.17.9/macros/program/ssh_macros.te ---
> > nsapolicy/macros/program/ssh_macros.te 2004-08-27 14:44:11.000000000
> > -0400 +++ policy-1.17.9/macros/program/ssh_macros.te 2004-09-02
> > 08:22:53.013807132 -0400 @@ -89,6 +89,14 @@
> >  can_network($1_ssh_t)
> >  can_ypbind($1_ssh_t)
> >
> > +if (user_tcp_server) {
> > +# for sshing to a ssh tunnel
> > +can_tcp_connect($1_ssh_t, $1_ssh_t)
> > +
> > +# for other connections to a ssh tunnel
> > +can_tcp_connect($1_t, $1_ssh_t)
> > +}
> > +
> >  # Use capabilities.
> >  allow $1_ssh_t self:capability { setuid setgid dac_override
> > dac_read_search };
>
> Where is this diff coming from?  can_tcp_connect expands to _nothing_ in
> the present policy; it was only applicable to the pre-2.6 SELinux with
> labeled network buffers.

It was in my tree.  When the tunables were converted to booleans I just made 
equivalent changes to the policy in my tree.

> > +# Connect to sshd.
> > +ifdef(`inetd.te', `
> > +ifdef(`run_ssh_inetd', `
> > +can_tcp_connect($1_ssh_t, inetd_t)
> > +', `
> > +can_tcp_connect($1_ssh_t, sshd_t)
> > +')', `
> > +can_tcp_connect($1_ssh_t, sshd_t)
> > +')
> > +
>
> Ditto, and run_ssh_inetd is no longer a tunable; it is a boolean.

I've removed both of them from my tree to avoid further confusion.

 > diff --exclude-from=exclude -N -u -r
> > nsapolicy/macros/program/userhelper_macros.te
> > policy-1.17.9/macros/program/userhelper_macros.te ---
> > nsapolicy/macros/program/userhelper_macros.te 2004-08-27
> > 14:44:11.000000000 -0400 +++
> > policy-1.17.9/macros/program/userhelper_macros.te 2004-09-02
> > 08:15:02.751587016 -0400 @@ -17,7 +17,7 @@
> >  ifdef(`single_userdomain', `
> >  typealias $1_t alias $1_userhelper_t;
> >  ', `
> > -type $1_userhelper_t, domain, userhelperdomain, privlog, privrole,
> > privowner, auth_chkpwd, privfd, privuser; +type $1_userhelper_t, domain,
> > userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd
> > ifdef(`user_canbe_sysadm', `, privuser');
> >
> >  in_user_role($1_userhelper_t)
> >  role sysadm_r types $1_userhelper_t;
>
> No, this is a reversion (where are these diffs coming from?).  privuser
> is always needed by userhelper with the current code (always switches to
> "root").

Probably from my tree.  There's a bunch of differences between my tree and the 
CVS which are because of my tree being outdated.  I am fairly careful about 
what I push, and also about what I accept for my tree.

There are some things in the CVS that I have not yet put in my tree because I 
suspect that there is a better way of achieving the same goal.  There are 
other things in the CVS that aren't in my tree because I haven't had time to 
consider the policy in question.

> > @@ -127,7 +130,9 @@
> >  allow $1_xserver_t mtrr_device_t:file rw_file_perms;
> >  allow $1_xserver_t apm_bios_t:chr_file rw_file_perms;
> >  allow $1_xserver_t framebuf_device_t:chr_file rw_file_perms;
> > +ifdef(`redhat', `
> >  allow $1_xserver_t device_t:lnk_file { getattr read };
> > +')
> >  allow $1_xserver_t devtty_t:chr_file rw_file_perms;
> >  allow $1_xserver_t devtty_t:lnk_file read;
>
> Wrapping such a trivial rule with a distro-specific ifdef is pointless,
> IMHO, and makes maintenance a pain.

OK, I'll remove that from my tree.

> > diff --exclude-from=exclude -N -u -r nsapolicy/Makefile
> > policy-1.17.9/Makefile --- nsapolicy/Makefile 2004-09-02
> > 08:03:26.130772258 -0400
> > +++ policy-1.17.9/Makefile 2004-09-02 08:15:02.754586679 -0400
> > @@ -147,6 +147,7 @@
> >   @grep -v "^/root" $@.tmp > $@.root
> >   @/usr/sbin/genhomedircon . $@.root  > $@
> >   @grep "^/root" $@.tmp >> $@
> > + @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk
> > -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >>
> > $@ || true; done @-rm $@.tmp $@.root
> >
> >  clean:
>
> Requires that the policy be rebuilt on every machine, as it depends on
> local /proc information.

True.  The general consensus seems to be that Colin Walters has the best idea 
of how to solve this.  But until his solution gets implemented this seems 
like a good work-around.

Also something to note is that we really don't want to use this when producing 
a file_contexts file for distributing to other machines.  It would be likely 
to grant inappropriate access to block devices.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
