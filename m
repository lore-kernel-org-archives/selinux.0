From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: apache-ssl mods for Debian
Date: Tue, 13 Apr 2004 21:28:15 +1000
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
References: <20040412201442.A6A473A4058@abyss.simplyaquatics.com>
In-Reply-To: <20040412201442.A6A473A4058@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200404132128.15421.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Apr 2004 06:14, "Ed Street" <edstreet@street-tek.com> wrote:
> When I start apache-ssl, run_init /etc/init.d/apache-ssl I get the
> following.
>
> avc:  denied  { read } for  pid=12580 exe=/usr/sbin/run_init
> path=pipe:[4995] dev= ino=4995 scontext=blacknet:sysadm_r:run_init_t
> tcontext=blacknet:sysadm_r:sysadm_su_t tclass=fifo_file

I plan to change run_init to not use expect.  That file handle is from a bug 
in expect.

> avc:  denied  { getattr } for  pid=12580 exe=/usr/sbin/run_init
> path=/proc/12580/mounts dev= ino=824442896
> scontext=blacknet:sysadm_r:run_init_t tcontext=blacknet:sysadm_r:run_init_t
> tclass=file

This and all the other getattr messages are from the change to libselinux 
which has it using fopen() instead of open() for /proc/mounts.  The next 
policy package I upload will have a macro change to fix this.

> avc:  denied  { read } for  pid=12583 exe=/bin/bash name=selinux dev=hda3
> ino=1785904 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:policy_src_t tclass=lnk_file

Your current directory is /etc/selinux...

> avc:  denied  { search } for  pid=12587 exe=/usr/sbin/apache-ssl
> name=apache-ssl dev=hda3 ino=2457683 scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:httpd_exec_t tclass=dir

The apache.fc I attached to my previous message would not label a directory 
with httpd_exec_t, if you relabel /usr/lib/apache-ssl then it should be OK.

> avc:  denied  { write } for  pid=12592 exe=/usr/sbin/apache-ssl
> name=gcache_port dev=hda3 ino=2539552 scontext=system_u:system_r:httpd_t
> tcontext=system_u:object_r:var_run_t tclass=sock_file

If you relabel /var/run/gcache_port or restart apache in permissive mode (thus 
recreating /var/run/gcache_port) then it will be fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
