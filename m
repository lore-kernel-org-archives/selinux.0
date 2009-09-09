Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89DUJst019119
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 09:30:19 -0400
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n89DTcVo000842
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 13:29:38 GMT
Subject: Re: [refpolicy] shutdown domain
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1252417999.2600.3.camel@vogon.seekline.net>
References: <1252256475.22458.5.camel@vogon.seekline.net>
	 <1252415710.17700.1.camel@gorn.columbia.tresys.com>
	 <1252417999.2600.3.camel@vogon.seekline.net>
Content-Type: multipart/mixed; boundary="=-1jsFdhyDgd/wuozNK/jH"
Date: Wed, 09 Sep 2009 15:29:53 +0200
Message-Id: <1252502993.2657.18.camel@vogon.seekline.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1jsFdhyDgd/wuozNK/jH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2009-09-08 at 15:53 +0200, Stefan Schulze Frielinghaus wrote:
> On Tue, 2009-09-08 at 09:15 -0400, Christopher J. PeBenito wrote:
> [...]
> > I'm not sure what the purpose of this would be.  I would think it would
> > effectively telinit to the shutdown runlevel, which would be fine for
> > apcupsd to do.  The shutdown actions would then be performed by init
> > scripts.
> 
> Every app which executes /sbin/shutdown needs the following permissions:
> 
> files_rw_generic_pids()
> init_exec()
> init_rw_initctl()
> init_write_utmp()
> 
> And I don't like the idea that my daemon may write to generic pids e.g..
> A shutdown domain may solve such a problem because I
> trust /sbin/shutdown but not my daemon ;-)

For a proper discussion I created a policy for shutdown just to see what
permissions it actually needs. What makes me a headache is that shutdown
needs files_manage_generic_pids() and init_rw_utmp(). I guess most of
the daemons who call shutdown wouldn't need userdom_use_user_terminals()
because they do not pipe the output of shutdown to a user tty/pty. So
this is not too bad.

But there is still the question why not use a policy for /sbin/shutdown?
Why should we allow a few daemons to write utmp, pids etc.? I attached a
policy and all AVC messages created during the dozens of reboots I
did ;-) The policy was tested on Fedora 11 with targeted policy and on
CentOS 5.3 strict policy.

CC'ed Daniel, maybe he has a comment too?

--=-1jsFdhyDgd/wuozNK/jH
Content-Disposition: attachment; filename="avc"
Content-Type: text/plain; name="avc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

type=1400 audit(1252442161.883:195): avc:  denied  { setuid } for  pid=9071 comm="shutdown" capability=7 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442161.885:196): avc:  denied  { read } for  pid=9072 comm="shutdown" name="utmp" dev=dm-0 ino=90231 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:initrc_var_run_t:s0 tclass=file
type=1400 audit(1252442161.885:197): avc:  denied  { read } for  pid=9072 comm="shutdown" name="utmp" dev=dm-0 ino=90231 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:initrc_var_run_t:s0 tclass=file
type=1400 audit(1252442161.886:198): avc:  denied  { read } for  pid=9072 comm="shutdown" name="nsswitch.conf" dev=dm-0 ino=196713 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:etc_t:s0 tclass=file
type=1400 audit(1252442161.888:199): avc:  denied  { read } for  pid=9072 comm="shutdown" name="nsswitch.conf" dev=dm-0 ino=196713 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:etc_t:s0 tclass=file
type=1400 audit(1252442161.883:195): avc:  denied  { setuid } for  pid=9071 comm="shutdown" capability=7 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442161.885:196): avc:  denied  { read } for  pid=9072 comm="shutdown" name="utmp" dev=dm-0 ino=90231 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:initrc_var_run_t:s0 tclass=file
type=1400 audit(1252442161.885:197): avc:  denied  { read } for  pid=9072 comm="shutdown" name="utmp" dev=dm-0 ino=90231 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:initrc_var_run_t:s0 tclass=file
type=1400 audit(1252442161.886:198): avc:  denied  { read } for  pid=9072 comm="shutdown" name="nsswitch.conf" dev=dm-0 ino=196713 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:etc_t:s0 tclass=file
type=1400 audit(1252442161.888:199): avc:  denied  { read } for  pid=9072 comm="shutdown" name="nsswitch.conf" dev=dm-0 ino=196713 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:etc_t:s0 tclass=file
type=1400 audit(1252442348.186:207): avc:  denied  { read } for  pid=9122 comm="shutdown" name="localtime" dev=dm-0 ino=196712 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:locale_t:s0 tclass=file
type=1400 audit(1252442348.187:208): avc:  denied  { write } for  pid=9122 comm="shutdown" name="tty1" dev=tmpfs ino=412 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
type=1400 audit(1252442348.187:209): avc:  denied  { dac_override } for  pid=9122 comm="shutdown" capability=1 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442348.188:210): avc:  denied  { dac_override } for  pid=9122 comm="shutdown" capability=1 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442348.189:211): avc:  denied  { dac_override } for  pid=9122 comm="shutdown" capability=1 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442356.532:213): avc:  denied  { write } for  pid=9121 comm="shutdown" path="pipe:[97636]" dev=pipefs ino=97636 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252442356.532:214): avc:  denied  { read } for  pid=9121 comm="shutdown" path="pipe:[97636]" dev=pipefs ino=97636 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252442633.509:216): avc:  denied  { read } for  pid=9180 comm="shutdown" path="/dev/tty1" dev=tmpfs ino=412 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:tty_device_t:s0 tclass=chr_file
type=1400 audit(1252442633.529:217): avc:  denied  { write } for  pid=9179 comm="shutdown" name="run" dev=dm-0 ino=90125 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:var_run_t:s0 tclass=dir
type=1400 audit(1252442643.117:218): avc:  denied  { write } for  pid=9179 comm="shutdown" path="pipe:[99182]" dev=pipefs ino=99182 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252442643.118:219): avc:  denied  { read } for  pid=9179 comm="shutdown" path="pipe:[99182]" dev=pipefs ino=99182 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252442952.001:221): avc:  denied  { sys_tty_config } for  pid=9236 comm="shutdown" capability=26 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442952.001:222): avc:  denied  { sys_tty_config } for  pid=9236 comm="shutdown" capability=26 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=1400 audit(1252442952.012:223): avc:  denied  { add_name } for  pid=9235 comm="shutdown" name=".shutdown.pid.tmp" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:var_run_t:s0 tclass=dir
type=1400 audit(1252442956.024:224): avc:  denied  { write } for  pid=9235 comm="shutdown" path="pipe:[100696]" dev=pipefs ino=100696 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252442956.024:225): avc:  denied  { read } for  pid=9235 comm="shutdown" path="pipe:[100696]" dev=pipefs ino=100696 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=fifo_file
type=1400 audit(1252443079.726:227): avc:  denied  { create } for  pid=9267 comm="shutdown" name=".shutdown.pid.tmp" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:var_run_t:s0 tclass=file
type=1400 audit(1252443271.569:229): avc:  denied  { write open } for  pid=9304 comm="shutdown" name=".shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:var_run_t:s0 tclass=file
type=1400 audit(1252443364.592:231): avc:  denied  { getattr } for  pid=9333 comm="shutdown" path="/var/run/.shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:var_run_t:s0 tclass=file
type=1400 audit(1252443364.618:232): avc:  denied  { remove_name } for  pid=9333 comm="shutdown" name=".shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:var_run_t:s0 tclass=dir
type=1400 audit(1252443364.618:233): avc:  denied  { remove_name } for  pid=9333 comm="shutdown" name=".shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:var_run_t:s0 tclass=dir
type=1400 audit(1252443463.386:235): avc:  denied  { rename } for  pid=9360 comm="shutdown" name=".shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:var_run_t:s0 tclass=file
type=1400 audit(1252443463.386:236): avc:  denied  { unlink } for  pid=9360 comm="shutdown" name=".shutdown.pid.tmp" dev=dm-0 ino=90775 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:var_run_t:s0 tclass=file
type=1400 audit(1252443720.240:256): avc:  denied  { bind } for  pid=9551 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=unix_dgram_socket
type=AVC msg=audit(1252443606.741:243): avc:  denied  { create } for  pid=9425 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=unix_dgram_socket
type=1400 audit(1252443869.138:262): avc:  denied  { setopt } for  pid=9631 comm="shutdown" path=002F636F6D2F7562756E74752F757073746172742F39363331 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=unix_dgram_socket
type=1400 audit(1252443967.040:264): avc:  denied  { create } for  pid=9681 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=netlink_audit_socket
type=1400 audit(1252443967.040:265): avc:  denied  { write } for  pid=9681 comm="shutdown" path=002F636F6D2F7562756E74752F757073746172742F39363831 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=unix_dgram_socket
type=1400 audit(1252444070.703:267): avc:  denied  { write } for  pid=9711 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=netlink_audit_socket
type=1400 audit(1252444070.703:268): avc:  denied  { sendto } for  pid=9711 comm="shutdown" path=002F636F6D2F7562756E74752F75707374617274 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:system_r:init_t:s0 tclass=unix_dgram_socket
type=AVC msg=audit(1252444402.789:12): avc:  denied  { nlmsg_relay } for  pid=2030 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=netlink_audit_socket
type=AVC msg=audit(1252444654.899:39): avc:  denied  { audit_write } for  pid=2660 comm="shutdown" capability=29 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=AVC msg=audit(1252444654.954:40): avc:  denied  { read } for  pid=2660 comm="shutdown" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=netlink_audit_socket
type=AVC msg=audit(1252448078.081:26): avc:  denied  { getattr } for  pid=3013 comm="ck-system-stop" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448093.446:31): avc:  denied  { getattr } for  pid=3145 comm="ck-system-stop" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448104.441:32): avc:  denied  { getattr } for  pid=3148 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448105.251:33): avc:  denied  { getattr } for  pid=3153 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448105.394:34): avc:  denied  { getattr } for  pid=3156 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448105.627:35): avc:  denied  { getattr } for  pid=3159 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448105.786:36): avc:  denied  { getattr } for  pid=3162 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448106.114:37): avc:  denied  { getattr } for  pid=3165 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252448106.410:38): avc:  denied  { getattr } for  pid=3168 comm="ck-system-resta" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=system_u:system_r:consolekit_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=AVC msg=audit(1252476531.634:41): avc:  denied  { sys_boot } for  pid=2681 comm="poweroff" capability=22 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=AVC msg=audit(1252476531.634:42): avc:  denied  { signal } for  pid=2681 comm="poweroff" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:system_r:init_t:s0 tclass=process
type=AVC msg=audit(1252476533.968:44): avc:  denied  { sys_boot } for  pid=2681 comm="poweroff" capability=22 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=AVC msg=audit(1252476533.968:45): avc:  denied  { signal } for  pid=2681 comm="poweroff" scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:system_r:init_t:s0 tclass=process
type=AVC msg=audit(1252476533.968:46): avc:  denied  { sys_boot } for  pid=2681 comm="poweroff" capability=22 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=capability
type=AVC msg=audit(1252477049.253:32): avc:  denied  { execute_no_trans } for  pid=2666 comm="poweroff" path="/sbin/shutdown" dev=dm-0 ino=98426 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shutdown_exec_t:s0 tclass=file
type=1400 audit(1252492365.245:153): avc:  denied  { read write } for  pid=5805 comm="shutdown" name="2" dev=devpts ino=5 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_devpts_t:s0 tclass=chr_file
type=1400 audit(1252492365.245:153): avc:  denied  { read write } for  pid=5805 comm="shutdown" path="/dev/pts/2" dev=devpts ino=5 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_devpts_t:s0 tclass=chr_file
type=1400 audit(1252492365.245:153): avc:  denied  { read write } for  pid=5805 comm="shutdown" path="/dev/pts/2" dev=devpts ino=5 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_devpts_t:s0 tclass=chr_file
type=1400 audit(1252492365.245:153): avc:  denied  { read write } for  pid=5805 comm="shutdown" path="/dev/pts/2" dev=devpts ino=5 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_devpts_t:s0 tclass=chr_file
type=1400 audit(1252492520.041:161): avc:  denied  { read write } for  pid=6106 comm="shutdown" name="tty2" dev=tmpfs ino=413 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_tty_device_t:s0 tclass=chr_file
type=1400 audit(1252492520.041:161): avc:  denied  { read write } for  pid=6106 comm="shutdown" path="/dev/tty2" dev=tmpfs ino=413 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_tty_device_t:s0 tclass=chr_file
type=1400 audit(1252492520.041:161): avc:  denied  { read write } for  pid=6106 comm="shutdown" path="/dev/tty2" dev=tmpfs ino=413 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_tty_device_t:s0 tclass=chr_file
type=1400 audit(1252492520.041:161): avc:  denied  { read write } for  pid=6106 comm="shutdown" path="/dev/tty2" dev=tmpfs ino=413 scontext=staff_u:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=staff_u:object_r:user_tty_device_t:s0 tclass=chr_file


# additional CentOS 5.3 strict AVCs
type=AVC msg=audit(1252481956.143:2852): avc:  denied  { read } for  pid=23354 comm="shutdown" name="ld.so.cache" dev=hda2 ino=64412 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:ld_so_cache_t:s0 tclass=file
type=AVC msg=audit(1252481956.153:2853): avc:  denied  { read } for  pid=23354 comm="shutdown" name="libc-2.5.so" dev=hda2 ino=159541 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shlib_t:s0 tclass=file
type=AVC msg=audit(1252482059.037:2856): avc:  denied  { use } for  pid=23403 comm="shutdown" path="/lib/ld-2.5.so" dev=hda2 ino=159548 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=root:staff_r:staff_t:s0-s0:c0.c1023 tclass=fd
type=1400 audit(1252482260.263:2863): avc:  denied  { read } for  pid=23522 comm="shutdown" name="libc-2.5.so" dev=hda2 ino=159541 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shlib_t:s0 tclass=file
type=1400 audit(1252482260.264:2864): avc:  denied  { read } for  pid=23522 comm="shutdown" name="libc-2.5.so" dev=hda2 ino=159541 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:shlib_t:s0 tclass=file
type=AVC msg=audit(1252482769.605:41): avc:  denied  { write } for  pid=2390 comm="shutdown" name="utmp" dev=hda5 ino=1437574 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:initrc_var_run_t:s0 tclass=file
type=AVC msg=audit(1252482769.606:42): avc:  denied  { connect } for  pid=2389 comm="shutdown" scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tclass=unix_dgram_socket
type=AVC msg=audit(1252483158.046:42): avc:  denied  { write } for  pid=2442 comm="shutdown" name="log" dev=tmpfs ino=6634 scontext=root:staff_r:shutdown_t:s0-s0:c0.c1023 tcontext=system_u:object_r:devlog_t:s0 tclass=sock_file

--=-1jsFdhyDgd/wuozNK/jH
Content-Disposition: attachment; filename="shutdown.fc"
Content-Type: text/plain; name="shutdown.fc"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/sbin/reboot	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
/sbin/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)

--=-1jsFdhyDgd/wuozNK/jH
Content-Disposition: attachment; filename="shutdown.if"
Content-Type: text/plain; name="shutdown.if"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

interface(`shutdown_role',`
	gen_require(`
		type shutdown_t, shutdown_exec_t;
	')

	role $1 types shutdown_t;

	domtrans_pattern($2, shutdown_exec_t, shutdown_t)
')

interface(`shutdown_domtrans',`
	gen_require(`
		type shutdown_t, shutdown_exec_t;
	')

	domtrans_pattern($1, shutdown_exec_t, shutdown_t)
')

interface(`files_manage_generic_pids',`
	gen_require(`
		type var_t, var_run_t;
	')

	list_dirs_pattern($1, var_t, var_run_t)
	manage_files_pattern($1, var_run_t, var_run_t)
')

interface(`init_signal',`
	gen_require(`
		type init_t;
	')

	allow $1 init_t:process signal;
')

--=-1jsFdhyDgd/wuozNK/jH
Content-Disposition: attachment; filename="shutdown.te"
Content-Type: text/plain; name="shutdown.te"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


policy_module(shutdown, 1.0.0)

########################################
#
# Declarations
#

type shutdown_t;
type shutdown_exec_t;
application_domain(shutdown_t, shutdown_exec_t)
ubac_constrained(shutdown_t)
role system_r types shutdown_t;

########################################
#
# shutdown local policy
#

allow shutdown_t self:capability { dac_override setuid sys_boot sys_tty_config audit_write };
allow shutdown_t self:fifo_file { read write };
allow shutdown_t self:unix_dgram_socket create_socket_perms;
allow shutdown_t self:netlink_audit_socket { create write nlmsg_relay read };

# "/sbin/{poweroff,reboot} -p" executes /sbin/shutdown
allow shutdown_t shutdown_exec_t:file execute_no_trans;

files_read_etc_files(shutdown_t)
files_manage_generic_pids(shutdown_t)

miscfiles_read_localization(shutdown_t)

init_rw_utmp(shutdown_t)
init_telinit(shutdown_t)
init_signal(shutdown_t)

term_use_unallocated_ttys(shutdown_t)

userdom_use_user_terminals(shutdown_t)

libs_use_ld_so(shutdown_t)
libs_use_shared_libs(shutdown_t)

logging_send_syslog_msg(shutdown_t)

--=-1jsFdhyDgd/wuozNK/jH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
