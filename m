Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2B4BWCe020551
	for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2011 23:11:32 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p2B4BUYx029268
	for <selinux@tycho.nsa.gov>; Fri, 11 Mar 2011 04:11:31 GMT
References: <1299044768-22058-1-git-send-email-qingtao.cao@windriver.com> <SNT139-w538F8D8118C077D8E94F34ABC00@phx.gbl>,<18621088-2ec8-4092-ab48-427393598479@email.android.com> <SNT139-W22B6E0E79E71EE3A16A471ABCB0@phx.gbl>
In-Reply-To: <SNT139-W22B6E0E79E71EE3A16A471ABCB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [v2 PATCH 0/3] SELinux: separate socket type than its creator
From: Russell Coker <russell@coker.com.au>
Reply-to: russell@coker.com.au
Date: Fri, 11 Mar 2011 15:10:32 +1100
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Message-ID: <a0516b20-8dcd-4dd5-9f19-7207888e0575@email.android.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The constraints for MLS can have rules excluding specified types or attributes.  We could have an attribute for domins whos unix sockets should be excluded from MLS.  It seems to me that the only real benefit to allowing a Unix socket to have a different type to the domain that created it is for a domain that creates multiple sockets with different types.

Maybe this would be good for systemd.
-- 
My blog    http://etbe.coker.com.au

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
