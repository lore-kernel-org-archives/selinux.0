Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAI9aDMA018939
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 04:36:29 -0500 (EST)
Received: from nproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAI9Rkuc020167
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 09:27:46 GMT
Received: by nproxy.gmail.com with SMTP id x30so547770nfb
        for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 01:28:23 -0800 (PST)
Message-ID: <c92980110511180128j4d08130bh588dd1261829c924@mail.gmail.com>
Date: Fri, 18 Nov 2005 10:28:23 +0100
From: Andreas Bernauer <andreas.bernauer@gmx.de>
Reply-To: andreas.bernauer@gmx.de
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: (new?) problems installing with checkinstall
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1131979809.5415.90.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051113184615.GB3618@tierbergli.Informatik.Uni-Tuebingen.De>
	 <1131979809.5415.90.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

thanks for your response.  Sorry that I answer with delay, I've been busy.

On 11/14/05, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > [problem using checkinstall 1.6.0 with selinux]
> > ----------------------
> > /usr/bin/install: warning: failed to change context of /usr/doc/mutt/samples/gpg
> > .rc to system_u:object_r:usr_t: No such file or directory
> > /usr/bin/install: setting permissions for `/usr/doc/mutt/samples/pgp2.rc': No su
> > ch file or directory
> > [...]
> >   /usr/bin/install -c 'pgpewrap' '/usr/bin/pgpewrap'
> > /usr/bin/install: setting permissions for `/usr/bin/pgpewrap': No such file or d
> > irectory
> > /usr/bin/install: warning: failed to change context of /usr/bin/pgpewrap to syst
> > em_u:object_r:bin_t: No such file or directory
>
> Can you run checkinstall under strace or autrace and identify the
> specific failing syscall and its arguments?

The short story: Your question lead me to the following archived mail,
which resolved my problem.
http://tux.oclug.on.ca/pipermail/oclug/2004-May/038916.html
It seems to be a bug/problem in checkinstall with file system
translation.  The suggested workaround is to disable file system
translation in checkinstall with (I cite Felipe Sanchez)
checkinstall <options> --fstrans=no --install=yes <install_command>

I guess, this can be set in the configuration file, too.

Thank you for helping me finding this mail, Stephen.

Andreas.

For the record:
I tried to use autrace, but I was unsuccessful.
autrace did not work at all and I don't know why: I followed the
intstructions from the manpage, but autrace refuses to start.  Any
hints how I can get autrace running?

---------- terminal log ----------------
[root@tierbergli mutt-1.5.10]# getenforce
Enforcing
[root@tierbergli mutt-1.5.10]# service auditd stop
Stopping auditd:                                           [  OK  ]
[root@tierbergli mutt-1.5.10]# rm -f /var/log/audit/audit.log
[root@tierbergli mutt-1.5.10]# service auditd start
Starting auditd:                                           [  OK  ]
[root@tierbergli mutt-1.5.10]# auditctl -l
No rules
File system watches not supported
[root@tierbergli mutt-1.5.10]# autrace /usr/local/sbin/checkinstall
Error - can't get rule count.
[root@tierbergli mutt-1.5.10]# auditctl -s
AUDIT_STATUS: enabled=1 flag=1 pid=13222 rate_limit=0
backlog_limit=256 lost=0 backlog=0
--------------- terminal log END -----------------
I tried to add a rule, but this did not help:

------------- terminal log -------------------
[root@tierbergli mutt-1.5.10]# auditctl -a entry,always -S all
[root@tierbergli mutt-1.5.10]# auditctl -l
AUDIT_LIST: entry,always syscall=all
File system watches not supported
[root@tierbergli mutt-1.5.10]# autrace /usr/local/sbin/checkinstall
Error - can't get rule count.
------------ terminal log END -----------------
[Of course, I removed this general rule immediately after trying.]

So I tried strace -f, which worked.  Digging into the log, I found
that the failing syscall looks like
15077 stat64("/var/tmp/RkgJnLjLKTDQegBMaDiM/META/TRANSL/usr/share/locale/fr/LC_MESSAGES/mutt.mo",
0xbf9fd6bc) = -1 ENOENT (No such file or directory)

which made me think, why the program is searching for a file in such
an strange place.  Searching for the "TRANSL" in the checkinstall
script I found that checkinstalll is doing "file system translation".
Googling for this lead me directly to
the aforementioned web page. Using the suggested workaround resolved my problem.

Thank you Stephen for pointing me to a way helping myself. :-) And:
thank you, Dave Edwards, for forwarding Felipe Sanchez' message to a
publicly archived mailing list.

Cheers,

Andreas.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
