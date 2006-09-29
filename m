Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TI4Iqf030122
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 14:04:18 -0400
Received: from web51515.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8TI3iu8027228
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 18:03:44 GMT
Message-ID: <20060929180413.64238.qmail@web51515.mail.yahoo.com>
Date: Fri, 29 Sep 2006 11:04:13 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Where is the AVC?
To: Salvo Giuffrida <giuffsalvo@hotmail.it>, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F38B57DECF2A6270738CF26AF180@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>If you look at figure 3-2 (if you want, I can send to you), the AVC is 
>designed in kernel-space, whereas the object manager is in userspace. So, if 
>the AVC is managed by the object manager, shouldn't it be in userspace?

User space Object Managers enforce data flow decisions made by the kernel. For
example, dbus is a user space object manager. If a process wants to send data
though dbus, the OM asks the kernel for avc decision and then carries it out by
allowing/disallowing the connection. The audit message, if one results, goes back
into the kernel to be serialized with all other system events before going to the
audit daemon. 

The other user space object manager that you will find is nscd. There will
probably be a few more of these in the future. For example, one might want one in
apache, samba, or ldap. Anywhere you want to enforce through policy a data flow
decision.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
