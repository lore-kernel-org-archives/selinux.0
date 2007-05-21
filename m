Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LDnBqV025699
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 09:49:11 -0400
Received: from web36614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4LDn9Fr016898
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 13:49:09 GMT
Date: Mon, 21 May 2007 06:48:52 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Question on networking accesses
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <93504.42890.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have what I hope is a fairly straitforward question on the SELinux
networking model. Let's pretend that I have a process A that sends a
UDP packet P to a second process B. From the viewpoint of access control
is this:

    - process A writing to process B
    - process B reading from process A
    - process A creating packet P, and process B reading packet P

some combination of the above, or something else entirely?

Yes, I have read the code, and fine code it is, too.
Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
