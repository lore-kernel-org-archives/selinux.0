Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MEDk3h012979
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 10:13:46 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4MEDjRP006666
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 14:13:45 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: Question on networking accesses
Date: Tue, 22 May 2007 10:13:40 -0400
Cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov
References: <827038.22839.qm@web51509.mail.re2.yahoo.com>
In-Reply-To: <827038.22839.qm@web51509.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705221013.40793.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, May 22 2007 8:39:56 am Steve G wrote:
> The access
> control is mostly at the entry points to the transaction and not on a
> packet by packet basis (except perhaps udp where every packet is an entry
> point to the transaction).

Access control checks are performed on a packet by packet basis as it is 
received by the socket, see selinux_socket_sock_rcv_skb().

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
