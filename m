Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05FI8Ii002612
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 10:18:08 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05FIABa006258
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 15:18:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j05FIBIL013458
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 10:18:11 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j05FIBr28112
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 10:18:11 -0500
Received: from [172.16.83.126] (vpn83-126.boston.redhat.com [172.16.83.126])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j05FI8ne016079
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 10:18:08 -0500
Message-ID: <41DC052F.8030400@redhat.com>
Date: Wed, 05 Jan 2005 10:18:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: New type cert_t?
References: <20050104230149.GA10317@yggdrasil.localdomain> <20050104233401.GA11885@yggdrasil.localdomain> <41DBE9F1.50303@redhat.com>
In-Reply-To: <41DBE9F1.50303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry hit reply instead of new.

> I would like to add a new file type cert_t for ssl cert files, since 
> these are defaulted to usr_t right now.
> Shouldn't these be protected at a higher level?
>
> #
> # cert_t is the type of files in the system certs directories.
> #
> type cert_t, file_type, sysadmfile;
>
> ...
>
> /usr/share/ssl/certs(/.*)?              system_u:object_r:cert_t
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
