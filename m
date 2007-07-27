Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6RJ2n5Z002887
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 15:02:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6RJ2lbT004324
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 19:02:47 GMT
Subject: Re: Novice problem with apol/ policy.conf
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eric Paris <eparis@redhat.com>
Cc: Markelov Andrey <amarkelov@pluscom.ru>, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com, method@manicmethod.com
In-Reply-To: <1185558252.3669.2.camel@dhcp231-215.rdu.redhat.com>
References: <F08777953B2EF943ACCD5C9C4C0DDA1EA578CA@mailserver.pluscom.ru>
	 <1185558252.3669.2.camel@dhcp231-215.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 19:02:35 +0000
Message-Id: <1185562955.24951.52.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-27 at 13:44 -0400, Eric Paris wrote:
> On Fri, 2007-07-27 at 17:58 +0400, Markelov Andrey wrote:
> > Hello,
> > I am novice in SELinux. For policy analysis I compiled policy.conf from selinux-policy-2.4.6-30.el5.src.rpm on RHEL5. 
> > When I tried to open policy.21 with apol (GUI version 3.0
> >  libapol version 3.0.0) it was ok. But when i opened  policy.conf  i received the following error: The selected file does not appear to be a valid SELinux Policy. Error opening policy: Input/output error. And in console 
> > tmp/rolemap.conf:624:ERROR 'syntax error' at token 'ntfs-3g' on line 1563798:
> > genfscon ntfs-3g / system_u:object_r:dosfs_t
> > 
> > genfscon msdos / system_u:object_r:dosfs_t
> > 
> > What is the possible reason?
> 
> I'd bet on an apol bug, but I don't know.  The addition of a '-' in
> ntfs-3g caused a number of headaches.  I'm adding the upstream list to
> the cc and hopefully one of the people who work on apol will know right
> offhand.

Just like the checkpolicy/checkmodule parser, the setools parser had to
be updated, and this happened in setools 3.0.1.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
