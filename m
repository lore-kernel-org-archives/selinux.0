Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FF2vXA028305
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:02:57 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FF2h5D012352
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:02:44 GMT
Received: from taynzmail03.nz-tay.cpqcorp.net (compaqtay.compaq.com [16.47.4.103])
	by atlrel6.hp.com (Postfix) with ESMTP id 05C163401A
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:02:51 -0400 (EDT)
Received: from kitche.zk3.dec.com (kitche3.zk3.dec.com [16.140.160.165])
	by taynzmail03.nz-tay.cpqcorp.net (Postfix) with ESMTP id AD96F2B50
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:02:52 -0400 (EDT)
Message-ID: <44E1E215.30602@hp.com>
Date: Tue, 15 Aug 2006 11:02:45 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: trouble with a transition to verify access to a printer
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having some trouble verifying a user has access to a given printer.
 In the CUPS architecture a user submits their job over a socket
connection to the server which queues it and eventually prints it.  The
server can get the client's context via getpeercon() and that
information is stored as metadata with the job.  Often the context is
user_u:user_r:user_lpr_t:SystemLow  and the context of the running cupsd
is system_u:system_r:cupsd_t:SystemLow-SystemHigh.

In order to keep the security decisions out of cupsd it was suggested
that a helper program be used.  The cupsd server could setexeccon() this
program with the job's stored context and the helper would use access()
to determine if it could write to the printer device (typically
/dev/parport0 with context system_u:object_r:printer_device_t:SystemLow)

When run in enforcing mode however I get the following AVC deny message:

type=AVC msg=audit(1155470231.462:11179): avc:  denied  { transition }
for  pid=3046 comm="cupsd" name="lspp-access" dev=sda4 ino=420583
scontext=system_u:system_r:cupsd_t:s0-s15:c0.c255
tcontext=user_u:user_r:user_lpr_t:s0 tclass=process

I've included the audit2allow output below based on running in
permissive mode.  Even after loading the module it generates I still get
the same AVC deny on the transition.

pebenito suggested on #selinux that since cupsd was switching identities
and roles that was causing the deny.  If thats the case, is there anyway
around that?  Is there a better way to solve this problem?

thanks
-matt

require {
      class chr_file { read write };
      class fd use;
      class file { entrypoint read };
      class process { noatsecure rlimitinh sigchld siginh transition };
      class unix_stream_socket write;
      type cupsd_exec_t;
      type cupsd_t;
      type printer_device_t;
      type setrans_t;
      type user_lpr_t;
      role system_r;
      role user_r;
};

allow cupsd_t user_lpr_t:process { noatsecure rlimitinh };
allow cupsd_t user_lpr_t:process { siginh transition };
allow setrans_t self:unix_stream_socket write;
allow user_lpr_t cupsd_exec_t:file { entrypoint read };
allow user_lpr_t cupsd_t:fd use;
allow user_lpr_t cupsd_t:process sigchld;
allow user_lpr_t printer_device_t:chr_file { read write };

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
