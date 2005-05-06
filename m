From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [Fwd: Latest Diff]
Date: Fri, 6 May 2005 23:22:20 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <427A757F.9040009@redhat.com> <200505061533.10266.russell@coker.com.au> <427B6664.6070803@redhat.com>
In-Reply-To: <427B6664.6070803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505062322.23358.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 06 May 2005 22:43, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >+allow kudzu_t proc_t:lnk_file getattr;
> >
> >We already have the following:
> >allow kudzu_t { self proc_t }:lnk_file read;
> >
> >We should probably change it to:
> >allow kudzu_t { self proc_t }:lnk_file { getattr read };
>
> I don't see this.

My mistake, it's in daemon_core_rules().

We should probably change daemon_core_rules() on line 256 of 
macros/global_macros.te from:
allow $1_t { self proc_t }:lnk_file read;
to:
allow $1_t { self proc_t }:lnk_file { getattr read };

> >-dontaudit lvm_t var_run_t:dir getattr;
> >+var_run_domain(lvm)
> >
> >What is this for?  CLVM?
>
> I don't recall but it was trying to write a pid file.

What was the name of the file?  If nothing else we will need a .fc entry for 
it.

> >-allow udev_t tmpfs_t:dir rw_dir_perms;
> >-allow udev_t tmpfs_t:sock_file create_file_perms;
> >+allow udev_t tmpfs_t:dir create_dir_perms;
> >+allow udev_t tmpfs_t:{ sock_file file } create_file_perms;
> >
> >In what situations is this required?  When udev is working correctly it
> > will never try to create files or directories of type tmpfs_t.
>
> This is happening before the /dev is relabeled.

/dev is populated initially before SE Linux is enabled (from the initrd).  It 
is relabeled on line 42 of /etc/rc.sysinit.  How is udev being started in 
between the SE Linux load (start of init) and line 42 of rc.sysinit?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
