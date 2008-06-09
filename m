Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59HEfH0017471
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:14:41 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59HEe1u009016
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 17:14:40 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m59HD2Yx000384
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:13:02 -0400
Received: from blums0042.bluelnk.net ([134.120.81.54])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m59HCxXF018547
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:13:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: To domain transition or not?
Date: Mon, 9 Jun 2008 10:14:35 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9E986@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a general question, followed by a couple more specific questions.
When creating domains for programs that use linux cmds like ping or
hostname, which have their own domains, I'm faced with the choice having
those programs run in my domain or in the domain of the linux cmd. What
is the better approach?

Take "ping" for example. We have a program (MonitorSvcUtil) that uses
ping and runs in a domain I've created called monitorsvcutil_t.
Depending on whether I use the netutils_exec_ping or
netutils_domtrans_ping interface, I can have our program execute ping in
the monitorsvcutil_t domain, or do a domain transition into the ping_t.
I would think the latter approach would be better, since ping is then
running in a domain specifically designed for it and I can avoid having
to give the monitorsvcutil_t domain the privileges needed to run ping.

When I try the latter approach I'm wondering why I run into the
following denials:

type=AVC msg=audit(1213025579.772:9476): avc:  denied  { read write }
for  pid=2238 comm="ping" path="socket:[6024549]" dev=sockfs ino=6024549
scontext=root:staff_r:ping_t:s0-s4:c0.c255
tcontext=root:staff_r:monitorsvcutil_t:s0-s4:c0.c255 tclass=tcp_socket

type=AVC msg=audit(1213025579.030:9446): avc:  denied  { append } for
pid=2233 comm="ping"
path="/opt/nl/nltmp/clarkson/NLdata/.mbdev2_2008Jun09_1527_1415.txt"
dev=sda8 ino=684396 scontext=root:staff_r:ping_t:s0-s4:c0.c255
tcontext=root:object_r:nl_tmp_data_t:s0 tclass=file

The first denial surprises me because I would have thought that the ping
program would be creating its own TCP socket and thus I would not expect
the socket to be labeled with the monitorsvcutil_t type.

The second denial surprises me because the ping program does not have
anything to do with the ".mbdev2_2008Jun09_1527_1415.txt" file. This
seems to indicate that once the ping process completes and returns to
the MonitorSvcUtil process, the domain remains ping_t rather than
returning to monitorsvcutil_t.

Thanks




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
