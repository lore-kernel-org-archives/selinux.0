Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB3KChIi010707
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 15:12:43 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB3KCk68015945
	for <selinux@tycho.nsa.gov>; Fri, 3 Dec 2004 20:12:46 GMT
Message-Id: <200412032012.iB3KCjaT030175@turing-police.cc.vt.edu>
To: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Subject: Yee-HAH! 'smartd' issues 70 avc's when it tries to send mail...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1738060480P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 03 Dec 2004 15:12:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1738060480P
Content-Type: text/plain; charset=us-ascii

Running Fedora Core Rawhide as of the other night, so fairly recent.
Using 'strict/permissive' at the moment...

So I set up 'smartd' to monitor the hard drive in my laptop - I *know* there's
one bad spot of about 10 blocks long on it, and want to be told if it decides
to start getting bigger.  And sure enough, at boot it tries to e-mail me and
tell me there's bad blocks.  Unfortunately, it seems to invoke 'sh -c mail' or
something like that, so even the ugly hack of adding an
exec_auto_trans(sendmail_t) doesn't look like it will help.  Any good ideas on
how to deal with this one?

(And I have *NO* idea why it pops the first 5-6 while trying to find resolv.conf)

Is it trying to open port 25 to send the mail, and if there's no sendmail running,
it invokes 'sh -c mail'?  If so, the solution (or part of it) would simply be to
have smartd start after sendmail does.....

Oddly curious - the failed read for pipe:[9756] - both ends appear to be fsdaemon_t ;)

The messages (almost 70 of them):
Dec  3 11:07:42 turing-police kernel: audit(1102089972.656:0): avc:  denied  { search } for  pid=17328 exe=/usr/sbin/smartd name=/ dev=tmpfs ino=3131 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmpfs_t tclass=dir
Dec  3 11:07:42 turing-police kernel: audit(1102089972.697:0): avc:  denied  { write } for  pid=17328 exe=/usr/sbin/smartd name=log dev=tmpfs ino=9084 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmpfs_t tclass=sock_file
Dec  3 11:07:42 turing-police kernel: audit(1102089974.784:0): avc:  denied  { read } for  pid=17328 exe=/usr/sbin/smartd name=resolv.conf dev=dm-5 ino=24648 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:net_conf_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089974.784:0): avc:  denied  { getattr } for  pid=17328 exe=/usr/sbin/smartd path=/etc/resolv.conf dev=dm-5 ino=24648 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:net_conf_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089974.839:0): avc:  denied  { create } for  pid=17328 exe=/usr/sbin/smartd scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=unix_stream_socket
Dec  3 11:07:42 turing-police kernel: audit(1102089974.839:0): avc:  denied  { connect } for  pid=17328 exe=/usr/sbin/smartd scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=unix_stream_socket
Dec  3 11:07:42 turing-police kernel: audit(1102089974.947:0): avc:  denied  { search } for  pid=8202 exe=/usr/sbin/smartd name=bin dev=dm-5 ino=26670 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=dir
Dec  3 11:07:42 turing-police kernel: audit(1102089974.947:0): avc:  denied  { read } for  pid=8202 exe=/usr/sbin/smartd name=sh dev=dm-5 ino=57489 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=lnk_file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.002:0): avc:  denied  { execute } for  pid=8202 exe=/usr/sbin/smartd name=bash dev=dm-5 ino=26747 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:shell_exec_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.002:0): avc:  denied  { execute_no_trans } for  pid=8202 exe=/usr/sbin/smartd path=/bin/bash dev=dm-5 ino=26747 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:shell_exec_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.058:0): avc:  denied  { read } for  pid=8202 exe=/usr/sbin/smartd path=/bin/bash dev=dm-5 ino=26747 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:shell_exec_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.089:0): avc:  denied  { read } for  pid=8202 exe=/bin/bash name=meminfo dev=proc ino=-268435454 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:proc_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.089:0): avc:  denied  { getattr } for  pid=8202 exe=/bin/bash path=/proc/meminfo dev=proc ino=-268435454 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:proc_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.149:0): avc:  denied  { search } for  pid=8202 exe=/bin/bash name=sbin dev=dm-5 ino=47195 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:sbin_t tclass=dir
Dec  3 11:07:42 turing-police kernel: audit(1102089975.149:0): avc:  denied  { getattr } for  pid=8202 exe=/bin/bash path=/bin/bash dev=dm-5 ino=26747 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:shell_exec_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.213:0): avc:  denied  { getattr } for  pid=17328 exe=/usr/sbin/smartd path=pipe:[9756] dev=pipefs ino=9756 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=fifo_file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.213:0): avc:  denied  { read } for  pid=17328 exe=/usr/sbin/smartd path=pipe:[9756] dev=pipefs ino=9756 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=fifo_file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.280:0): avc:  denied  { getattr } for  pid=8202 exe=/bin/bash path=/bin/mail dev=dm-5 ino=26730 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.280:0): avc:  denied  { execute } for  pid=8202 exe=/bin/bash name=mail dev=dm-5 ino=26730 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=file
Dec  3 11:07:42 turing-police kernel: audit(1102089975.346:0): avc:  denied  { getattr } for  pid=7644 exe=/bin/bash path=/tmp dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:42 turing-police kernel: audit(1102089975.346:0): avc:  denied  { search } for  pid=7644 exe=/bin/bash name=/ dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:42 turing-police kernel: audit(1102089975.415:0): avc:  denied  { write } for  pid=7644 exe=/bin/bash name=/ dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089975.449:0): avc:  denied  { add_name } for  pid=7644 exe=/bin/bash name=sh-thd-1102109337 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089975.449:0): avc:  denied  { create } for  pid=7644 exe=/bin/bash name=sh-thd-1102109337 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.517:0): avc:  denied  { write } for  pid=7644 exe=/bin/bash path=/tmp/sh-thd-1102109337 dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.567:0): avc:  denied  { read } for  pid=7644 exe=/bin/bash name=sh-thd-1102109337 dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.610:0): avc:  denied  { remove_name } for  pid=7644 exe=/bin/bash name=sh-thd-1102109337 dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089975.610:0): avc:  denied  { unlink } for  pid=7644 exe=/bin/bash name=sh-thd-1102109337 dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.679:0): avc:  denied  { execute_no_trans } for  pid=7644 exe=/bin/bash path=/bin/mail dev=dm-5 ino=26730 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.679:0): avc:  denied  { read } for  pid=7644 exe=/bin/bash path=/bin/mail dev=dm-5 ino=26730 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:bin_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.783:0): avc:  denied  { setgid } for  pid=7644 exe=/bin/mail capability=6 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=capability
Dec  3 11:07:43 turing-police kernel: audit(1102089975.831:0): avc:  denied  { ioctl } for  pid=7644 exe=/bin/mail path=/tmp/sh-thd-1102109337 (deleted) dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.866:0): avc:  denied  { ioctl } for  pid=7644 exe=/bin/mail path=pipe:[9756] dev=pipefs ino=9756 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=fifo_file
Dec  3 11:07:43 turing-police kernel: audit(1102089975.901:0): avc:  denied  { getattr } for  pid=7644 exe=/bin/mail path=/tmp/Rsx6eaR5 dev=dm-10 ino=6151 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089976.007:0): avc:  denied  { execute } for  pid=13925 exe=/bin/mail name=sendmail dev=dm-1 ino=41557 scontext=system_u:system_r:fsdaemon_t tcontext=root:object_r:sbin_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089976.007:0): avc:  denied  { execute_no_trans } for  pid=13925 exe=/bin/mail path=/usr/sbin/sendmail dev=dm-1 ino=41557 scontext=system_u:system_r:fsdaemon_t tcontext=root:object_r:sbin_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089976.091:0): avc:  denied  { read } for  pid=13925 exe=/bin/mail path=/usr/sbin/sendmail dev=dm-1 ino=41557 scontext=system_u:system_r:fsdaemon_t tcontext=root:object_r:sbin_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089976.683:0): avc:  denied  { create } for  pid=13925 exe=/usr/sbin/sendmail scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=tcp_socket
Dec  3 11:07:43 turing-police kernel: audit(1102089976.813:0): avc:  denied  { search } for  pid=13925 exe=/usr/sbin/sendmail name=mail dev=dm-5 ino=43015 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:etc_mail_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089976.865:0): avc:  denied  { getattr } for  pid=13925 exe=/usr/sbin/sendmail path=/etc/mail/submit.cf dev=dm-5 ino=43033 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:etc_mail_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089976.865:0): avc:  denied  { getattr } for  pid=13925 exe=/usr/sbin/sendmail path=/etc/mail dev=dm-5 ino=43015 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:etc_mail_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089976.947:0): avc:  denied  { read } for  pid=13925 exe=/usr/sbin/sendmail name=submit.cf dev=dm-5 ino=43033 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:etc_mail_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.097:0): avc:  denied  { setuid } for  pid=13925 exe=/usr/sbin/sendmail capability=7 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=capability
Dec  3 11:07:43 turing-police kernel: audit(1102089977.174:0): avc:  denied  { search } for  pid=13925 exe=/usr/sbin/sendmail name=spool dev=dm-3 ino=34821 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:var_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.218:0): avc:  denied  { search } for  pid=13925 exe=/usr/sbin/sendmail name=clientmqueue dev=dm-3 ino=55307 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.218:0): avc:  denied  { getattr } for  pid=13925 exe=/usr/sbin/sendmail path=/var/spool/clientmqueue dev=dm-3 ino=55307 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.371:0): avc:  denied  { getattr } for  pid=13925 exe=/usr/sbin/sendmail path=/var/spool dev=dm-3 ino=34821 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:var_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.466:0): avc:  denied  { write } for  pid=13925 exe=/usr/sbin/sendmail name=clientmqueue dev=dm-3 ino=55307 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.509:0): avc:  denied  { add_name } for  pid=13925 exe=/usr/sbin/sendmail name=dfiB3G6HJS013925 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089977.509:0): avc:  denied  { create } for  pid=13925 exe=/usr/sbin/sendmail name=dfiB3G6HJS013925 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.580:0): avc:  denied  { getattr } for  pid=13925 exe=/usr/sbin/sendmail path=/var/spool/clientmqueue/dfiB3G6HJS013925 dev=dm-3 ino=55324 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.580:0): avc:  denied  { lock } for  pid=13925 exe=/usr/sbin/sendmail path=/var/spool/clientmqueue/dfiB3G6HJS013925 dev=dm-3 ino=55324 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.678:0): avc:  denied  { write } for  pid=13925 exe=/usr/sbin/sendmail path=/var/spool/clientmqueue/dfiB3G6HJS013925 dev=dm-3 ino=55324 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.771:0): avc:  denied  { read } for  pid=13925 exe=/usr/sbin/sendmail name=dfiB3G6HJS013925 dev=dm-3 ino=55324 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089977.809:0): avc:  denied  { connect } for  pid=13925 exe=/usr/sbin/sendmail scontext=system_u:system_r:fsdaemon_t tcontext=system_u:system_r:fsdaemon_t tclass=tcp_socket
Dec  3 11:07:43 turing-police kernel: audit(1102089977.809:0): avc:  denied  { tcp_send } for  pid=13925 exe=/usr/sbin/sendmail saddr=127.0.0.1 src=51192 daddr=127.0.0.1 dest=25 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:netif_lo_t tclass=netif
Dec  3 11:07:43 turing-police kernel: audit(1102089977.879:0): avc:  denied  { tcp_send } for  pid=13925 exe=/usr/sbin/sendmail saddr=127.0.0.1 src=51192 daddr=127.0.0.1 dest=25 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:node_lo_t tclass=node
Dec  3 11:07:43 turing-police kernel: audit(1102089977.879:0): avc:  denied  { send_msg } for  pid=13925 exe=/usr/sbin/sendmail saddr=127.0.0.1 src=51192 daddr=127.0.0.1 dest=25 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
Dec  3 11:07:43 turing-police kernel: audit(1102089977.948:0): avc:  denied  { tcp_recv } for  pid=3 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=51192 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:netif_lo_t tclass=netif
Dec  3 11:07:43 turing-police kernel: audit(1102089977.948:0): avc:  denied  { tcp_recv } for  pid=3 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=51192 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:node_lo_t tclass=node
Dec  3 11:07:43 turing-police kernel: audit(1102089977.948:0): avc:  denied  { recv_msg } for  pid=3 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=51192 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
Dec  3 11:07:43 turing-police kernel: audit(1102089978.263:0): avc:  denied  { remove_name } for  pid=13925 exe=/usr/sbin/sendmail name=tfiB3G6HJS013925 dev=dm-3 ino=55327 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089978.263:0): avc:  denied  { rename } for  pid=13925 exe=/usr/sbin/sendmail name=tfiB3G6HJS013925 dev=dm-3 ino=55327 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089978.263:0): avc:  denied  { unlink } for  pid=13925 exe=/usr/sbin/sendmail name=qfiB3G6HJS013925 dev=dm-3 ino=55326 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=file
Dec  3 11:07:43 turing-police kernel: audit(1102089978.366:0): avc:  denied  { read } for  pid=13925 exe=/usr/sbin/sendmail name=clientmqueue dev=dm-3 ino=55307 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:mqueue_spool_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089978.595:0): avc:  denied  { getattr } for  pid=10722 exe=/bin/bash path=/tmp dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089978.633:0): avc:  denied  { search } for  pid=10722 exe=/bin/bash name=/ dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:43 turing-police kernel: audit(1102089978.633:0): avc:  denied  { write } for  pid=10722 exe=/bin/bash name=/ dev=dm-10 ino=2 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:44 turing-police kernel: audit(1102089978.701:0): avc:  denied  { add_name } for  pid=10722 exe=/bin/bash name=sh-thd-1102111169 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:07:44 turing-police kernel: audit(1102089978.701:0): avc:  denied  { remove_name } for  pid=10722 exe=/bin/bash name=sh-thd-1102111169 dev=dm-10 ino=6150 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmp_t tclass=dir
Dec  3 11:36:19 turing-police kernel: audit(1102091779.951:0): avc:  denied  { search } for  pid=16629 exe=/usr/sbin/smartd name=/ dev=tmpfs ino=3131 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmpfs_t tclass=dir
Dec  3 11:36:20 turing-police kernel: audit(1102091780.816:0): avc:  denied  { write } for  pid=16629 exe=/usr/sbin/smartd name=log dev=tmpfs ino=9084 scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:tmpfs_t tclass=sock_file


--==_Exmh_-1738060480P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBsMi8cC3lWbTT17ARAu6WAKDoHiyBxIZAn8OCchhpBOgCzak3mgCfZPOp
OC4QFl/6X1wp7iPFEYBMxUo=
=DbyE
-----END PGP SIGNATURE-----

--==_Exmh_-1738060480P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
