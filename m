Subject: Re: gnome and dbus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200903042204.34105.russell@coker.com.au>
References: <200903042204.34105.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 08:51:03 -0500
Message-Id: <1236174663.2679.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-03-04 at 22:04 +1100, Russell Coker wrote:
> type=AVC msg=audit(1236164018.240:156): avc:  denied  { execute_no_trans } for  
> pid=6554 comm="dbus-daemon" path="/usr/lib/gnome-vfs-2.0/gnome-vfs-daemon" 
> dev=hda2 ino=393873 
> scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
> tcontext=system_u:object_r:lib_t:s0 tclass=file
> 
> So what would this gnome-vfs-daemon program be and why would a dbus-daemon 
> process be running it?

In Fedora, it is installed as /usr/libexec/gnome-vfs-daemon.
And the dbus config for it is installed
as /usr/share/dbus-1/services/gnome-vfs-daemon.service.

These postings might be useful in understanding it, although they are
old:
http://mail.gnome.org/archives/gtk-devel-list/2006-September/msg00072.html
http://mail.gnome.org/archives/gtk-devel-list/2007-February/msg00062.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
