Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6RHiJjf030324
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 13:44:19 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6RHiHVF016299
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2007 17:44:18 GMT
Subject: Re: Novice problem with apol/ policy.conf
From: Eric Paris <eparis@redhat.com>
To: Markelov Andrey <amarkelov@pluscom.ru>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov,
        method@manicmethod.com
In-Reply-To: <F08777953B2EF943ACCD5C9C4C0DDA1EA578CA@mailserver.pluscom.ru>
References: <F08777953B2EF943ACCD5C9C4C0DDA1EA578CA@mailserver.pluscom.ru>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 13:44:12 -0400
Message-Id: <1185558252.3669.2.camel@dhcp231-215.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-27 at 17:58 +0400, Markelov Andrey wrote:
> Hello,
> I am novice in SELinux. For policy analysis I compiled policy.conf from selinux-policy-2.4.6-30.el5.src.rpm on RHEL5. 
> When I tried to open policy.21 with apol (GUI version 3.0
>  libapol version 3.0.0) it was ok. But when i opened  policy.conf  i received the following error: The selected file does not appear to be a valid SELinux Policy. Error opening policy: Input/output error. And in console 
> tmp/rolemap.conf:624:ERROR 'syntax error' at token 'ntfs-3g' on line 1563798:
> genfscon ntfs-3g / system_u:object_r:dosfs_t
> 
> genfscon msdos / system_u:object_r:dosfs_t
> 
> What is the possible reason?

I'd bet on an apol bug, but I don't know.  The addition of a '-' in
ntfs-3g caused a number of headaches.  I'm adding the upstream list to
the cc and hopefully one of the people who work on apol will know right
offhand.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
