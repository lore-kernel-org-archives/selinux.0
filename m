Return-Path: <SRS0=tF6o=Q7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B81C43381
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6BB20663
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 20:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfBXUcb convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:32:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38845 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXUcb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Feb 2019 15:32:31 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C3675612BC
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 21:32:26 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id v62so6161617otb.3
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 12:32:26 -0800 (PST)
X-Gm-Message-State: AHQUAua3xbh6Gbbr2fOJujMq0msdNwiaBWSmg9ZU4uHRCqDi7fZgRY8C
        OO/WaItdhEOb3RCaa4JmV//+RVwgtb+w6/mzWQo=
X-Google-Smtp-Source: AHgI3IbU9DkH4ciJBIPGzA43L7W+6y7zEcqhN6/24Jmu8Cq8tCc1GgVEorBHhOY26iFz0hbpSgSqQ2NMmSfhnlGQ880=
X-Received: by 2002:a05:6830:e:: with SMTP id c14mr9128998otp.144.1551040344985;
 Sun, 24 Feb 2019 12:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20190224165919.GA4310@brutus.lan> <20190224173944.GA18551@brutus.lan>
 <CAJfZ7=njaGvMdSJdpfzK238=BS_u7i+DE61mLic1OezEC20ngQ@mail.gmail.com> <20190224183708.GA3000@brutus.lan>
In-Reply-To: <20190224183708.GA3000@brutus.lan>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 24 Feb 2019 21:32:13 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==ZFWSGH1FhrmWo=HzG6KCxCdGSS2XpyF9GnuKPKxw_JA@mail.gmail.com>
Message-ID: <CAJfZ7==ZFWSGH1FhrmWo=HzG6KCxCdGSS2XpyF9GnuKPKxw_JA@mail.gmail.com>
Subject: Re: Bash 5 change in behavior and SELinux
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 24 21:32:26 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 24, 2019 at 7:37 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> On Sun, Feb 24, 2019 at 07:17:33PM +0100, Nicolas Iooss wrote:
> > On Sun, Feb 24, 2019 at 6:39 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > >
> > > On Sun, Feb 24, 2019 at 05:59:19PM +0100, Dominick Grift wrote:
> > > > Recently Bash-5 appeared in the Fedora repositories and i instantly noticed an inpleasant change (for the record: this did not happen before):
> > >
> > > I suppose this is just a "feature" or a "bug" in Bash-5 and that i will just have to deal with it. Just seems a bit unnecessary access to me.
> > >
> > > >
> > > > [kcinimod@brutus ~]$ touch mytest1.test
> > > > [kcinimod@brutus ~]$ rm ~/*.test
> > > > rm: cannot remove '/home/kcinimod/*.test': No such file or directory
> > > > [kcinimod@brutus ~]$ rm ~/mytest1.test
> > > > [kcinimod@brutus ~]$ echo $?
> > > > 0
> > > >
> > > > After running `semodule -DB` the following AVC denials surfaced:
> > > >
> > > > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-3" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:files.home.file:s0 tclass=dir permissive=1
> > > > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-1" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:fs.rootfs.fs:s0 tclass=dir permissive=1
> >
> > [For other readers: these are the labels of /home and /, the parent
> > directories of /home/kcinimod/]
> >
> > > > So I took to #bash and they told me:
> > > >
> > > > 17:43 <_abc_> grift: that is exactly what you see on android and is
> > > >               a direct result of the missing x bit equivalent in
> > > >               the selinux policy
> > > >
> > > > 17:44 <_abc_> grift: rephrased: globbing the * requires the x bit
> > > >               set
> > > > 17:44 <_abc_> (it's equivalent in selinux policy)
> > > >
> > > > So why does this show up as a "read"? Its allowed to "search" "/" and "/home", but since Bash 5 this no longer is enough.
> > > >
> > > > Scripts break everywhere because of this
> >
> > What is the syscall associated with the avc entries? This would help
> > finding in bash's source what triggered this behavior.
> > I tried to reproduce your commands in Arch Linux (bash package
> > 5.0.0-1) or Fedora 30 (bash package 5.0.2-1.fc30 for x86_64) by using
> > strace on bash and watching the syscalls, but nothing stood out: I see
> > an "openat(AT_FDCWD, "/home/kcinimod/",
> > O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3" followed by calls to
> > "getdents64(3, ...)", which are like expected. This could be due to
> > several things:
>
> type=SYSCALL msg=audit(02/24/2019 19:33:13.924:18121) : arch=x86_64 syscall=openat success=yes exit=3 a0=0xffffff9c a1=0x561168c81e40 a2=O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC a3=0x0 items=1 ppid=2270 pid=27900 auid=kcinimod uid=kcinimod gid=kcinimod euid=kcinimod suid=kcinimod fsuid=
>
> >
> > * The bash version you are using is not 5.0.2-1.fc30. Which one are you using?
>
> it is 5.0.2-1, downgrading to 4.4.23-7 fixes it
>
> > * It might come from a kernel bug (which would open the parent
> > directories with read access). That would be really strange, but only
> > to be sure: is bash 4 working fine when you downgrade bash package
> > while keeping the same kernel?
>
> Yes 4 is fine
>
> > * Or it might come from a bash dependency (like readline).
>
> Does not look like it: just downgrading "bash" fixes it

I managed to reproduce the issue. Here are the steps I followed:
* Download a Fedora 30 (Rawhide) live CD from
https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Workstation/x86_64/iso/
and boot it in a QEMU virtual machine.
* Audit accesses to listing / from the live user: echo '(auditallow
unconfined_t root_t (dir (read)))' > auditallow_custom.cil && semodule
-i auditallow_custom.cil
* Executing "rm ~/*.test" leads to the following log: type=AVC
msg=audit(1551039100.144:488): avc:  granted  { read } for  pid=5225
comm="bash" name="/" dev="dm-0" ino=2
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:object_r:root_t:s0 tclass=dir
* Executing "rm ./*.test" or anything else without the tilde does NOT
produce the AVC.
* Here is a gdb session with an interesting backtrace (once debug
symbols are installed using "sudo dnf debuginfo-install bash glibc"):

$ gdb -q --args bash -c 'rm ~/*.test'
(gdb) catch syscall openat
Catchpoint 1 (syscall 'openat' [257])
(gdb) commands
Type commands for breakpoint(s) 1, one per line.
End with a line saying just "end".
>p (char*)$rsi
>end
(gdb) r
Starting program: /usr/bin/bash -c rm\ \~/\*.test

[... enter "c" quite some times...]

Catchpoint 1 (call to syscall openat), __GI___open64_nocancel
(file=file@entry=0x55555568bb50 "/", oflag=oflag@entry=591872) at
../sysdeps/unix/sysv/linux/open64_nocancel.c:45
45   return INLINE_SYSCALL_CALL (openat, AT_FDCWD, file, oflag |
EXTRA_OPEN_FLAGS,
$17 = 0x55555568bb50 "/"
(gdb) bt
#0  __GI___open64_nocancel (file=file@entry=0x55555568bb50 "/",
oflag=oflag@entry=591872) at
../sysdeps/unix/sysv/linux/open64_nocancel.c:45
#1  0x00007ffff7e7d0b9 in __opendir (name=name@entry=0x55555568bb50
"/") at ../sysdeps/posix/opendir.c:92
#2  0x00005555555fe699 in glob_vector (pat=pat@entry=0x5555556a1b81
"\\h\\o\\m\\e", dir=dir@entry=0x55555568bb50 "/", flags=flags@entry=0)
at glob.c:717
#3  0x00005555555ff53e in glob_filename (pathname=<optimized out>,
flags=0) at glob.c:1385
#4  0x00005555555ff442 in glob_filename (pathname=<optimized out>,
flags=0) at glob.c:1178
#5  0x00005555555ff442 in glob_filename
(pathname=pathname@entry=0x55555569cc40
"/\\h\\o\\m\\e/\\l\\i\\v\\e\\u\\s\\e\\r/*.test", flags=0) at
glob.c:1178
#6  0x00005555555cc953 in shell_glob_filename (pathname=<optimized
out>) at pathexp.c:434
#7  0x00005555555c77de in glob_expand_word_list (eflags=<optimized
out>, tlist=0x5555556a0450) at subst.c:11035
#8  expand_word_list_internal (list=<optimized out>,
eflags=eflags@entry=31) at subst.c:11472
#9  0x00005555555c7a0e in expand_words (list=<optimized out>) at subst.c:10984
#10 0x000055555559bda5 in execute_simple_command
(fds_to_close=0xffffffff, async=0, pipe_out=-1, pipe_in=-1,
simple_command=<optimized out>) at execute_cmd.c:4317
#11 execute_command_internal (command=<optimized out>,
asynchronous=asynchronous@entry=0, pipe_in=pipe_in@entry=-1,
pipe_out=pipe_out@entry=-1,
fds_to_close=fds_to_close@entry=0x5555556a27c0) at execute_cmd.c:854
#12 0x00005555555eb877 in parse_and_execute (string=<optimized out>,
from_file=0x55555563208d "-c", flags=4) at evalstring.c:436
#13 0x0000555555584adb in run_one_command (command=<optimized out>) at
/usr/include/bits/string_fortified.h:90
#14 0x0000555555583711 in main (argc=3, argv=0x7fffffffd9a8,
env=0x7fffffffd9c8) at shell.c:745
(gdb)

Here is what happens, as far I as understand:
* bash runs execute_simple_command(), which expands the command arguments.
* It expands the ~ in expand_word_internal()
(https://git.savannah.gnu.org/cgit/bash.git/tree/subst.c?h=bash-5.0#n9959)
* glob_expand_word_list() calls
shell_glob_filename(pathname="\001/\001h\001o\001m\001e\001/\001l\001i\001v\001e\001u\001s\001e\001r/*.test")
(frame #6 in the debug backtrace)
* shell_glob_filename() starts by calling quote_string_for_globbing()
(https://git.savannah.gnu.org/cgit/bash.git/tree/pathexp.c?h=bash-5.0#n385).
This function replaces CTLESC (=\001) with backslashes and returns
"/\\h\\o\\m\\e/\\l\\i\\v\\e\\u\\s\\e\\r/*.test".
* shell_glob_filename() calls
glob_filename(pathname="/\\h\\o\\m\\e/\\l\\i\\v\\e\\u\\s\\e\\r/*.test",
flags=0) (frame #5)
* This function calls itself with the directory,
glob_filename(pathname="/\\h\\o\\m\\e/\\l\\i\\v\\e\\u\\s\\e\\r",
flags=0) (frame #4)
* This function calls itself with the directory,
glob_filename(pathname="/\\h\\o\\m\\e", flags=0) (frame #3)
* This function calls glob_vector(pat="\\h\\o\\m\\e", dir="/",
flags=0) (frame #2), implemented in
https://git.savannah.gnu.org/cgit/bash.git/tree/lib/glob/glob.c?h=bash-5.0#n577
* This function checks whether pat is a pattern, by calling
glob_pattern_p(pat). As variable pat contains backslashes, the answer
is yes (cf. https://git.savannah.gnu.org/cgit/bash.git/tree/lib/glob/glob_loop.c?h=bash-5.0#n56).
* glob_vector opens / in order to expand the pattern
(https://git.savannah.gnu.org/cgit/bash.git/tree/lib/glob/glob.c?h=bash-5.0#n709).
* The kernel asks SELinux whether it can list the content of /.

In my humble opinion, bash could be fixed in order not to escape
letters in paths when expanding ~. Could you please forward this
analysis to bash's developers in order to ask them whether they
consider this as a bug?

Cheers,
Nicolas

