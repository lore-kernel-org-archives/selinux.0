Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NKC68g028662
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 16:12:06 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NKDFl6020771
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 20:13:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policycoreutils: audit2allow -l doesn't work with dmesg pipe
Date: Mon, 24 Aug 2009 06:11:52 +1000
Cc: selinux@tycho.nsa.gov, 503252-forwarded@bugs.debian.org
References: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com> <4A91803C.8030909@redhat.com>
In-Reply-To: <4A91803C.8030909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200908240611.58935.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Aug 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=503252
>
> audit2allow -l is looking for the load_policy message which does not go to
> the dmesg, /var/log/messages.  Therefore the tool has no idea when policy
> was last loaded.

That would be a kernel bug then.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
