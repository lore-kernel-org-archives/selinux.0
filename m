Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7ODbuX3009044
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 09:37:56 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7ODd6sa029882
	for <selinux@tycho.nsa.gov>; Mon, 24 Aug 2009 13:39:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policycoreutils: audit2allow -l doesn't work with dmesg pipe
Date: Mon, 24 Aug 2009 23:37:41 +1000
Cc: selinux@tycho.nsa.gov, 503252-forwarded@bugs.debian.org
References: <87d46mvb33.fsf@anzu.internal.golden-gryphon.com> <200908240611.58935.russell@coker.com.au> <4A928943.3040609@redhat.com>
In-Reply-To: <4A928943.3040609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200908242337.51448.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Aug 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=503252
> >>
> >> audit2allow -l is looking for the load_policy message which does not go
> >> to the dmesg, /var/log/messages.  Therefore the tool has no idea when
> >> policy was last loaded.
> >
> > That would be a kernel bug then.
>
> Well I believe the messages that are intercepted by the audit.log do not go
> into dmesg, by design. Although Steve, James or Eric could probably say for
> sure.

When auditd is not running on a Debian system with CentOS kernel 
2.6.18-92.1.13.el5xen or Debian/Lenny kernel 2.6.26-2-xen-686 then nothing 
goes to the kernel message log which is interpreted by audit2allow as a 
candidate for the "-l" functionality.

It's OK if all the AVC messages go to the audit log and "dmesg|audit2allow -l" 
gives no output.  But if all AVC messages other than the load_policy message 
go to the kernel message log then it's a bug.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
