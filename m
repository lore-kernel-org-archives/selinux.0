Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBN9gIRb026134
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 04:42:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBN9fOjx025428
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 09:41:24 GMT
Received: from dns10.mail.yahoo.co.jp (dns10.mail.yahoo.co.jp [210.81.151.143])
	by jazzswing.ncsc.mil  with SMTP id hBN9fMSR025425
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 09:41:23 GMT
Date: Tue, 23 Dec 2003 18:45:03 +0900
From: Yuichi Nakamura <himainu_ynakam@yahoo.co.jp>
To: russell@coker.com.au
Cc: himainu_ynakam@ybb.ne.jp, selinux@tycho.nsa.gov
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
Message-Id: <20031223184503.721a10f5.himainu_ynakam@yahoo.co.jp>
In-Reply-To: <200312231438.59305.russell@coker.com.au>
References: <3FE6EA56.7010708@redhat.com>
	<200312230005.hBN05Mab000127@jazzband.ncsc.mil>
	<200312231438.59305.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Dec 2003 14:38:59 +1100
Russell Coker <russell@coker.com.au> wrote:
> allow httpd_t httpd_t:netlink_socket { bind create getattr read write };
> What is the reason for the above?
It is added by using audit2allow.
Apache seems to work without it, 
but in some case these permissions may be required.
I don't know whether Apache really requires these permissions.

------
Yuichi Nakamura


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
