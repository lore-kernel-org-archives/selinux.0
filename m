Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GLNsrT002209
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 17:23:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GLNSbx006708
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 21:23:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: SELinux Policy patches
Date: Sat, 17 Jul 2004 07:23:41 +1000
Cc: selinux@tycho.nsa.gov
References: <20040716002210.GA1081@wintermute.xmldesign.de> <20040716115729.GC25607@legolas.drinsama.de>
In-Reply-To: <20040716115729.GC25607@legolas.drinsama.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407170723.41949.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Jul 2004 21:57, Erich Schubert <erich@debian.org> wrote:
> > allow nsupdate_t self:netlink_socket create_socket_perms;
>
> Maybe due to changes from policy 17 to 18 this could be
> "netlink_route_socket" by now. Was this class split?

Yes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
