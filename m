Date: Wed, 30 Nov 2005 19:04:32 +0100
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Subject: Another thing... console logins
Message-ID: <20051130180432.GA15661@legolas.drinsama.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi again,
I just tried a console login while in enforcing mode...
avc:  denied  { use } for  pid=15513 comm="bash" name="tty1" dev=md1
ino=118355 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:system_r:getty_t tclass=fd

(the only error during login when in permissive mode, apart from some
staff_t accessing sysadm_home_t)

and my iptables seems to need to be able to read etc_runtime_t:
avc:  denied  { read } for  pid=28226 comm="iptables" name="mtab"
dev=ida/c0d0p5 ino=102335 scontext=root:system_r:iptables_t
tcontext=system_u:object_r:etc_runtime_t tclass=file

Regards,
Erich Schubert
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
   There was never a good war or a bad peace. - Benjamin Franklin    //\
  Wenn zwei gute Freunde sind, die einander kennen, Sonn' und Mond   V_/_
    begegnen sich, ehe sie sich trennen. --- Clemens von Brentano

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
