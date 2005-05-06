From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: [Fwd: Latest Diff]
Date: Fri, 6 May 2005 11:34:23 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
References: <427A757F.9040009@redhat.com> <1115329465.13097.23.camel@localhost.localdomain>
In-Reply-To: <1115329465.13097.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505061134.27455.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 06 May 2005 07:44, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > > diff --exclude-from=exclude -N -u -r
> > > nsapolicy/domains/program/restorecon.te
> > > policy-1.23.14/domains/program/restorecon.te ---
> > > nsapolicy/domains/program/restorecon.te	2005-04-27 10:28:49.000000000
> > > -0400 +++ policy-1.23.14/domains/program/restorecon.te	2005-05-05
> > > 15:11:06.000000000 -0400 @@ -20,7 +20,7 @@
> > >  role secadm_r types restorecon_t;
> > >
> > >  allow restorecon_t initrc_devpts_t:chr_file { read write ioctl };
> > > -allow restorecon_t { tty_device_t admin_tty_type }:chr_file { read
> > > write ioctl }; +allow restorecon_t { tty_device_t admin_tty_type
> > > devtty_t }:chr_file { read write ioctl };
>
> Perhaps (?):
>
> allow restorecon_t tty_device_t:chr_file { read write ioctl};
> access_terminal(restorecon_t, $2)

You mean:
access_terminal(restorecon_t, sysadm)

> access_terminal(restorecon_t, initrc)

There is no initrc_tty_device_t defined (and we are not going to define one).

> > > diff --exclude-from=exclude -N -u -r
> > > nsapolicy/domains/program/unused/auditd.te
> > > policy-1.23.14/domains/program/unused/auditd.te ---
> > > nsapolicy/domains/program/unused/auditd.te	2005-05-02
> > > 14:06:54.000000000 -0400 +++
> > > policy-1.23.14/domains/program/unused/auditd.te	2005-05-02
> > > 14:57:26.000000000 -0400 @@ -56,3 +56,4 @@
> > >  allow auditctl_t sysctl_kernel_t:file read;
> > >  allow auditd_t self:process setsched;
> > >  dontaudit auditctl_t init_t:fd use;
> > > +allow auditctl_t initrc_devpts_t:chr_file { read write };
>
> Perhaps (?):
>
> access_terminal(auditctl_t, initrc)

Again, it's not going to work.

> > >  allow consoletype_t crond_t:fifo_file { read getattr ioctl };
> > > diff --exclude-from=exclude -N -u -r
> > > nsapolicy/domains/program/unused/cups.te
> > > policy-1.23.14/domains/program/unused/cups.te ---
> > > nsapolicy/domains/program/unused/cups.te	2005-05-02 14:06:54.000000000
> > > -0400 +++ policy-1.23.14/domains/program/unused/cups.te	2005-05-02
> > > 14:57:26.000000000 -0400 @@ -22,6 +22,7 @@
> > >  logdir_domain(cupsd)
> > >
> > >  tmp_domain(cupsd)
> > > +file_type_auto_trans(cupsd_t, tmp_t, cupsd_tmp_t, fifo_file)
>
> tmp_domain(cupsd, `', { file dir fifo_file })

Yes.

> > > @@ -47,6 +47,7 @@
> > >  allow hald_t printer_device_t:chr_file rw_file_perms;
> > >  allow hald_t urandom_device_t:chr_file read;
> > >  allow hald_t mouse_device_t:chr_file r_file_perms;
> > > +allow hald_t memory_device_t:chr_file r_file_perms;
>
> ?? That no longer triggers an assertion violation?
> I specifically had to allow it in the assertion list when
> it was necessary for dmidecode. Why is it still necessary?

I agree, this shouldn't be needed.

> > > diff --exclude-from=exclude -N -u -r
> > > nsapolicy/macros/program/games_domain.te
> > > policy-1.23.14/macros/program/games_domain.te ---
> > > nsapolicy/macros/program/games_domain.te	2005-04-27 10:28:54.000000000
> > > -0400 +++ policy-1.23.14/macros/program/games_domain.te	2005-05-05
> > > 15:10:05.000000000 -0400 @@ -17,11 +17,14 @@
> > >  if (! disable_games_trans) {
> > >  domain_auto_trans($1_t, games_exec_t, $1_games_t)
> > >  }
> > > +can_exec($1_games_t, games_exec_t)
>
> It needs to re-execute itself??

Absolutely.

> Is it better to create orbit-$USER in a startup script, or
> to include selinux support in libORBit2 in order to
> properly set the context of /tmp/orbit-$USER to ROLE_orbit_tmp_t
> when it's created?

What does orbit do exactly?  What needs to access it?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
