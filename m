Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7JE4Yta012149
	for <selinux@tycho.nsa.gov>; Sat, 19 Aug 2006 10:04:34 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7JE46j1002854
	for <selinux@tycho.nsa.gov>; Sat, 19 Aug 2006 14:04:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux770@tortenboxer.de
Subject: Re:
Date: Sun, 20 Aug 2006 00:04:26 +1000
Cc: selinux@tycho.nsa.gov
References: <20060817195729.112220@gmx.net>
In-Reply-To: <20060817195729.112220@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200608200004.28925.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 18 August 2006 05:57, selinux770@tortenboxer.de wrote:
> Within the device (when opening a console or whatever) the "Current
> context" is system_u:system_r:kernel_t. (uid=0(root) gid=0(root)
> groups=0(root) context=system_u:system_r:kernel_t) Just as many other
> (nearly all) processes, too.

Your main problem is that you don't have a SE Linux modified login program.  
There are patches floating around for kdm, xdm, and gdm, you will have to 
select whichever is appropriate for your use and build a new gdm.

Eventually we want the standard xdm programs to support SE Linux.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
