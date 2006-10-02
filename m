Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92MiSaG026855
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 18:44:28 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k92MhoDw008548
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 22:43:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: gpm & mls
Date: Tue, 3 Oct 2006 08:44:21 +1000
Cc: Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
References: <20061002144738.61005.qmail@web51515.mail.yahoo.com>
In-Reply-To: <20061002144738.61005.qmail@web51515.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610030844.25270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 03 October 2006 00:47, Steve G <linux_4ever@yahoo.com> wrote:
> >For the certification, I would suggest that gpm is disabled or removed to
> > avoid the problem.
>
> True, but its a royal PITA to admin a machine without it.

It shouldn't be difficult to have a configuration option for GPM to not allow 
cut/paste to different VCs.  That plus an option to flush the buffer on 
logout will prevent the use of gpm for relabelling while allowing most of the 
functionality you desire and not requiring as much work.  I'm sure that some 
non-SE Linux users would appreciate such a patch too.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
