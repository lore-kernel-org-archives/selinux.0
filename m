Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAT0FRNK002282
	for <selinux@tycho.nsa.gov>; Sun, 28 Nov 2010 19:15:28 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oAT0FPUX021071
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2010 00:15:26 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B2673180F2
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2010 11:15:06 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: analysing optional policy
Date: Fri, 26 Nov 2010 20:55:01 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011262055.01924.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having a problem with optional policy not being used when I think it 
should.

Is it possible to use apol to get information on optional policy for .pp files 
so I can try to work out why it doesn't get enabled?

                unconfined_run_to(depmod_t, depmod_exec_t)

In the Debian policy I have the above in an optional section of base.pp but 
for reasons that I don't understand it's not being loaded (both tests and 
running apol on policy.24 show this).

I've inspected the contents of base.conf and they appear to be OK.

Any suggestions of other tools to analyse this will be appreciated.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
