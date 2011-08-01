Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71Fjsua021760
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 11:45:54 -0400
Received: from a.mx.secunet.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p71Fjro7005207
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 15:45:53 GMT
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8D6EA1A0078
	for <selinux@tycho.nsa.gov>; Mon,  1 Aug 2011 17:45:51 +0200 (CEST)
Received: from mail-srv1.secumail.de (unknown [10.53.40.200])
	by a.mx.secunet.com (Postfix) with ESMTP id F2DCA1A0076
	for <selinux@tycho.nsa.gov>; Mon,  1 Aug 2011 17:45:50 +0200 (CEST)
Message-ID: <4E36CA2C.8080300@secunet.com>
Date: Mon, 01 Aug 2011 17:45:48 +0200
From: Martin Christian <martin.christian@secunet.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Howto transition socket
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

excuse this very basic question: How can I define a transition for a socket?

Let's assume I've got a process p with label u_t, denoted as p:u_t. The
process opens a listening tcp socket s on port 80 (e. g. nc -l -p 80).
As far as I understood, s would get the label from the process: s:u_t.
However, I would like the socket to have label o_t. Hence, I define a
transition:

(u, u) -> o

or in policy syntax;

type_transition u_t u_t:tcp_socket o_t;

But this doesn't seem to work. Any ideas?

Regards,

Martin.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
