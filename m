Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GFeKL7026212
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:40:20 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GFeJif026881
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:40:19 GMT
Received: by fk-out-0910.google.com with SMTP id 18so3389892fks.2
        for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 08:40:18 -0700 (PDT)
Message-ID: <cadfc0e40807160840j3c0aaa8fvc84149c64556faf8@mail.gmail.com>
Date: Wed, 16 Jul 2008 10:40:18 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: python gui gconf policy problem
Cc: "SELinux List" <selinux@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
In-Reply-To: <1216208687.17602.67.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40807150929nf059a31q9b9435b08b8ac7f6@mail.gmail.com>
	 <1216140712.17602.20.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40807151125ifb109ch4384342766d0b2a2@mail.gmail.com>
	 <1216208640.17602.65.camel@moss-spartans.epoch.ncsc.mil>
	 <1216208687.17602.67.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 6:44 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Wed, 2008-07-16 at 07:44 -0400, Stephen Smalley wrote:
>> On Tue, 2008-07-15 at 13:25 -0500, Xavier Toth wrote:
>> > On Tue, Jul 15, 2008 at 11:51 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > >
>> > > On Tue, 2008-07-15 at 11:29 -0500, Xavier Toth wrote:
>> > >> I'm writing policy for a python gui and having a problem getting preferences:
>> > >>
>> > >> gobject.GError: Failed to contact configuration server; some possible
>> > >> causes are that you need to enable TCP/IP networking for ORBit, or you
>> > >> have a stale NFS locks due to a system crash. See
>> > >> http://www.gnome.org/project/gconf/ for information. (Details - 1:
>> > >> Could not send message to gconf daemon: An SELinux policy prevents
>> > >> this sender from sending this message to this recipient (rejected
>> > >> message had interface "org.gnome.GConf member "GetIOR" error name
>> > >> "(unset)" destination "org.gnome.GConf"))
>> > >>
>> > >> The error message states that policy is preventing this operation but
>> > >> there isn't a corresponding AVC in the audit log. I'm using the
>> > >> gnome_stream_connect_gconf_template but that doesn't help and I'm not
>> > >> sure it is the right thing to do anyway.
>> > >
>> > > Sounds like a dbus denial, which would show up as a USER_AVC.
>> > > Or might be dontaudit'd - try semodule -DB.
>> > >
>> > > --
>> > > Stephen Smalley
>> > > National Security Agency
>> > >
>> > >
>> >
>> > I have used 'semodule -DB' and I don't see any dbus AVCs and this
>> > strace shows that a dbus connection is established and some reads and
>> > writes occur
>>
>> dbus denials would show up as USER_AVC messages, and they would
>> successfully connect and read/write, but the daemon would send back an
>> error message in the reply to the client.
>>
>> Is this the system bus or the session bus?  session bus might not be
>> able to audit; I don't recall, but audit required capabilities and the
>> session bus runs as the user.
>
> in which case I believe it will fall back to syslog
> i.e. /var/log/messages for output.
>
>>
>>
>> > 11201 read(6, "", 8192)                 = 0
>> > 11201 close(6)                          = 0
>> > 11201 munmap(0xb802a000, 4096)          = 0
>> > 11201 socket(PF_FILE, SOCK_STREAM, 0)   = 6
>> > 11201 connect(6, {sa_family=AF_FILE, path=@/tmp/dbus-9MZAW1huFg}, 23) = 0
>> > 11201 fcntl64(6, F_GETFL)               = 0x2 (flags O_RDWR)
>> > 11201 fcntl64(6, F_SETFL, O_RDWR|O_NONBLOCK) = 0
>> > 11201 fcntl64(6, F_GETFD)               = 0
>> > 11201 fcntl64(6, F_SETFD, FD_CLOEXEC)   = 0
>> > 11201 geteuid32()                       = 500
>> > 11201 rt_sigaction(SIGPIPE, {SIG_IGN}, {SIG_IGN}, 8) = 0
>> > 11201 poll([{fd=6, events=POLLOUT, revents=POLLOUT}], 1, 0) = 1
>> > 11201 write(6, "\0", 1)                 = 1
>> > 11201 write(6, "AUTH EXTERNAL 353030\r\n", 22) = 22
>> > 11201 poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, -1) = 1
>> > 11201 read(6, "OK 9d1044c841e17b3bd63f63b3487cc"..., 2048) = 37
>> > 11201 poll([{fd=6, events=POLLOUT, revents=POLLOUT}], 1, -1) = 1
>> > 11201 write(6, "BEGIN\r\n", 7)          = 7
>> > 11201 poll([{fd=6, events=POLLIN|POLLOUT, revents=POLLOUT}], 1, -1) = 1
>> > 11201 writev(6,
>> > [{"l\1\0\1\0\0\0\0\1\0\0\0n\0\0\0\1\1o\0\25\0\0\0/org/fre"..., 128},
>> > {"", 0}], 2) = 128
>> > 11201 gettimeofday({1216142988, 595361}, NULL) = 0
>> > 11201 poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
>> > 11201 read(6, "l\2\1\1\n\0\0\0\1\0\0\0=\0\0\0\6\1s\0\5\0\0\0:1.29\0\0\0"...,
>> > 2048) = 260
>> > 11201 read(6, 0x867c4c0, 2048)          = -1 EAGAIN (Resource
>> > temporarily unavailable)
>> > 11201 writev(6,
>> > [{"l\1\2\1\0\0\0\0\2\0\0\0_\0\0\0\1\1o\0\20\0\0\0/org/gno"..., 112},
>> > {"", 0}], 2) = 112
>> > 11201 gettimeofday({1216142988, 598242}, NULL) = 0
>> > 11201 poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
>> > 11201 read(6, "l\3\1\1\315\0\0\0\3\0\0\0m\0\0\0\6\1s\0\5\0\0\0:1.29\0\0\0"...,
>> > 2048) = 333
>> > 11201 read(6, 0x867c4c0, 2048)          = -1 EAGAIN (Resource
>> > temporarily unavailable)
>> > 11201 open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/GConf2.mo",
>> > O_RDONLY) = -1 ENOENT (No such file or directory)
>> > 11201 open("/usr/share/locale/en_US.utf8/LC_MESSAGES/GConf2.mo",
>> > O_RDONLY) = -1 ENOENT (No such file or directory)
>> > 11201 open("/usr/share/locale/en_US/LC_MESSAGES/GConf2.mo", O_RDONLY)
>> > = -1 ENOENT (No such file or directory)
>> > 11201 open("/usr/share/locale/en.UTF-8/LC_MESSAGES/GConf2.mo",
>> > O_RDONLY) = -1 ENOENT (No such file or directory)
>> > 11201 open("/usr/share/locale/en.utf8/LC_MESSAGES/GConf2.mo",
>> > O_RDONLY) = -1 ENOENT (No such file or directory)
>> > 11201 open("/usr/share/locale/en/LC_MESSAGES/GConf2.mo", O_RDONLY) =
>> > -1 ENOENT (No such file or directory)
>> > 11201 writev(6,
>> > [{"l\1\0\1\0\0\0\0\3\0\0\0_\0\0\0\1\1o\0\20\0\0\0/org/gno"..., 112},
>> > {"", 0}], 2) = 112
>> > 11201 gettimeofday({1216142988, 602061}, NULL) = 0
>> > 11201 poll([{fd=6, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
>> > 11201 read(6, "l\3\1\1\315\0\0\0\4\0\0\0m\0\0\0\6\1s\0\5\0\0\0:1.29\0\0\0"...,
>> > 2048) = 333
>> > 11201 read(6, 0x867c4c0, 2048)          = -1 EAGAIN (Resource
>> > temporarily unavailable)
>> > 11201 write(2, "Traceback (most recent call last"..., 35) = 35
>> > 11201 open("/usr/share/ml-launch/ml-launch.py", O_RDONLY|O_LARGEFILE) = 7
>> > 11201 write(2, "  File \"/usr/share/ml-launch/ml-"..., 66) = 66
>> > 11201 fstat64(7, {st_mode=S_IFREG|0755, st_size=7901, ...}) = 0
>> > 11201 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
>> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb802a000
>> > 11201 read(7, "#!/usr/bin/env python\nimport log"..., 4096) = 4096
>> > 11201 read(7, "            gtk.gdk.flush()\n    "..., 4096) = 3805
>> > 11201 write(2, "    ", 4)               = 4
>> > 11201 write(2, "main()\n", 7)           = 7
>> > 11201 close(7)                          = 0
>> > 11201 munmap(0xb802a000, 4096)          = 0
>> > 11201 open("/usr/share/ml-launch/ml-launch.py", O_RDONLY|O_LARGEFILE) = 7
>> > 11201 write(2, "  File \"/usr/share/ml-launch/ml-"..., 62) = 62
>> > 11201 fstat64(7, {st_mode=S_IFREG|0755, st_size=7901, ...}) = 0
>> > 11201 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
>> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb802a000
>> > 11201 read(7, "#!/usr/bin/env python\nimport log"..., 4096) = 4096
>> > 11201 read(7, "            gtk.gdk.flush()\n    "..., 4096) = 3805
>> > 11201 write(2, "    ", 4)               = 4
>> > 11201 write(2, "launchLevelDialog = LabelDialog("..., 46) = 46
>> > 11201 close(7)                          = 0
>> > 11201 munmap(0xb802a000, 4096)          = 0
>> > 11201 open("/usr/share/ml-launch/label_dialog.py", O_RDONLY|O_LARGEFILE) = 7
>> > 11201 write(2, "  File \"/usr/share/ml-launch/lab"..., 69) = 69
>> > 11201 fstat64(7, {st_mode=S_IFREG|0644, st_size=22290, ...}) = 0
>> > 11201 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
>> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb802a000
>> > 11201 read(7, "#!/usr/bin/env python\nimport log"..., 4096) = 4096
>> > 11201 read(7, "ifications[key].sensitivities.va"..., 4096) = 4096
>> > 11201 read(7, "  if wordIndex < wordCount:\n    "..., 4096) = 4096
>> > 11201 write(2, "    ", 4)               = 4
>> > 11201 write(2, "self.init_preferences()\n", 24) = 24
>> > 11201 close(7)                          = 0
>> > 11201 munmap(0xb802a000, 4096)          = 0
>> > 11201 open("/usr/share/ml-launch/label_dialog.py", O_RDONLY|O_LARGEFILE) = 7
>> > 11201 write(2, "  File \"/usr/share/ml-launch/lab"..., 77) = 77
>> > 11201 fstat64(7, {st_mode=S_IFREG|0644, st_size=22290, ...}) = 0
>> > 11201 mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
>> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb802a000
>> > 11201 read(7, "#!/usr/bin/env python\nimport log"..., 4096) = 4096
>> > 11201 read(7, "ifications[key].sensitivities.va"..., 4096) = 4096
>> > 11201 read(7, "  if wordIndex < wordCount:\n    "..., 4096) = 4096
>> > 11201 read(7, "  self.levels_combobox.connect(\""..., 4096) = 4096
>> > 11201 read(7, " %s\" % (key)\n                   "..., 4096) = 4096
>> > 11201 write(2, "    ", 4)               = 4
>> > 11201 write(2, "self.saved_labels_max = self.pre"..., 88) = 88
>> > 11201 close(7)                          = 0
>> > 11201 munmap(0xb802a000, 4096)          = 0
>> > 11201 write(2, "gobject", 7)            = 7
>> > 11201 write(2, ".", 1)                  = 1
>> > 11201 write(2, "GError", 6)             = 6
>> > 11201 write(2, ": ", 2)                 = 2
>> > 11201 write(2, "Failed to contact configuration "..., 483) = 483
>> > 11201 write(2, "\n", 1)                 = 1
>> > 11201 close(3)                          = 0
>> > 11201 rt_sigaction(SIGINT, {SIG_DFL}, {0x4d651c0, [], 0}, 8) = 0
>> > 11200 exit_group(0)                     = ?
>> > 11199 <... waitpid resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 11200
>> > 11199 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> > 11199 --- SIGCHLD (Child exited) @ 0 (0) ---
>> > 11199 waitpid(-1, 0xbf98ea38, WNOHANG)  = -1 ECHILD (No child processes)
>> > 11199 sigreturn()                       = ? (mask now [])
>> > 11199 rt_sigaction(SIGINT, {SIG_DFL}, {0x807c670, [], 0}, 8) = 0
>> > 11199 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
>> > 11199 read(255, "\n", 67)               = 1
>> > 11199 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
>> > 11199 read(255, "", 67)                 = 0
>> > 11199 exit_group(0)                     = ?
>> > 11201 exit_group(1)                     = ?
> --
> Stephen Smalley
> National Security Agency
>
>

Yes there were some dbus AVCs in /var/log/messages which when
addressed seems to have fix the problem.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
