Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA00092
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 08:32:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA14084
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 12:32:03 GMT
Received: from mx02.uni-tuebingen.de (mx02.uni-tuebingen.de [134.2.3.12])
	by jazzband.ncsc.mil  with ESMTP id MAA14080
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 12:31:57 GMT
Date: Tue, 3 Jul 2001 14:32:00 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: Stephen Smalley <sds@tislabs.com>
cc: Jan Petranek <jan.petranek@student.uni-tuebingen.de>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy fails
In-Reply-To: <Pine.SOL.3.95.1010702085931.13449D-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.30.0107031422570.18924-100000@linux45.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Mon, 2 Jul 2001, Stephen Smalley wrote:

> Date: Mon, 2 Jul 2001 09:01:14 -0400 (EDT)
> From: Stephen Smalley <sds@tislabs.com>
> To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
> Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
> Subject: Re: checkpolicy fails
>
>
> > error in the statement ending on line 2196 (token ';'): unknown class capability used in rule
>
> I posted a patch for this bug back on May 7th.  See
> http://marc.theaimsgroup.com/?l=selinux&m=98926011507312&w=2.

It seems, this patch has worked - at least, the checkpolicy runs now.

But if this problem is due to the compiler, as Ying proposed, I should try
experimenting with some compilers.

As I went on with the installation, the make relabel stopped with an error
message:
./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line number 66
./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line number 67
./setfiles:  invalid context system_u:object_r:user_netscape_rw_ti on line number 68
./setfiles:  invalid context system_u:object_r:removable_device_ti on line number 103
./setfiles:  invalid context system_u:object_r:removable_device_ti on line number 104
./setfiles:  invalid context system_u:object_r:apm_bios_ti on line number 117
./setfiles:  invalid context system_u:object_r:etc_auth_ti on line number 126
./setfiles:  invalid context system_u:object_r:etc_mail_ti on line number 129
./setfiles:  invalid context system_u:object_r:sshd_key_ti on line number 140
./setfiles:  invalid context system_u:object_r:sshd_key_ti on line number 141
./setfiles:  invalid context system_u:object_r:user_tmp_ti on line number 198
./setfiles:  invalid context system_u:object_r:user_tmp_ti on line number 199
./setfiles:  invalid context system_u:object_r:user_xserver_tmp_ti on line number 200
./setfiles:  invalid context system_u:object_r:user_xserver_tmp_ti on line number 201
./setfiles:  invalid context system_u:object_r:lpr_exec_ti on line number 218
./setfiles:  invalid context system_u:object_r:lpr_exec_ti on line number 219
./setfiles:  invalid context system_u:object_r:lpr_exec_ti on line number 220
./setfiles:  invalid context system_u:object_r:sshd_key_ti on line number 258
./setfiles:  invalid context system_u:object_r:sshd_key_ti on line number 259
./setfiles:  invalid context system_u:object_r:atd_exec_ti on line number 285
./setfiles:  invalid context system_u:object_r:lpd_exec_ti on line number 286
./setfiles:  invalid context system_u:object_r:inetd_child_exec_ti on line number 289
./setfiles:  invalid context system_u:object_r:inetd_child_exec_ti on line number 290
./setfiles:  invalid context system_u:object_r:ftpd_stage2_exec_ti on line number 295
./setfiles:  invalid context system_u:object_r:gpm_exec_ti on line number 298
./setfiles:  invalid context system_u:object_r:gph_exec_ti on line number 301
./setfiles:  invalid context system_u:object_r:xfs_exec_ti on line number 308
./setfiles:  invalid context system_u:object_r:var_lock_ti on line number 340
./setfiles:  invalid context system_u:object_r:at_spool_tI on line number 356
./setfiles:  invalid context system_u:object_r:sendmail_var_log_ti on line number 368
./setfiles:  invalid context system_u:object_r:cron_log_ti on line number 369
make: *** [relabel] Fehler 1

I went on with the installation procedure nevertheless, but when I reboot
now, the init-processes are unable to do their work (fortunately, I made
two kernels, one real FLASK-kernel and one that only gives the
debug-output. Probably a good way to learn about the FLASK.)

If the problem with the relabeling is due to the problem with the
compiler, changing the compiler would probably also remove this problem.

Thanks for your help,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
