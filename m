Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBN9koRb026152
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 04:46:50 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBN9jujx025583
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 09:45:56 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBN9jtSR025567
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 09:45:56 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <himainu_ynakam@yahoo.co.jp>
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
Date: Tue, 23 Dec 2003 20:45:22 +1100
Cc: himainu_ynakam@ybb.ne.jp, selinux@tycho.nsa.gov
References: <3FE6EA56.7010708@redhat.com> <200312231438.59305.russell@coker.com.au> <20031223184503.721a10f5.himainu_ynakam@yahoo.co.jp>
In-Reply-To: <20031223184503.721a10f5.himainu_ynakam@yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312232045.22942.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Dec 2003 20:45, Yuichi Nakamura <himainu_ynakam@yahoo.co.jp> wrote:
> Russell Coker <russell@coker.com.au> wrote:
> > allow httpd_t httpd_t:netlink_socket { bind create getattr read write };
> > What is the reason for the above?
>
> It is added by using audit2allow.
> Apache seems to work without it,
> but in some case these permissions may be required.
> I don't know whether Apache really requires these permissions.

Until we know why Apache does that I will leave it out of my tree.  I suspect 
that you have some Apache module loaded which does it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
