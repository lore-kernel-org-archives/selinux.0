Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05DLxIi001792
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 08:21:59 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05DK7FH022389
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 13:20:07 GMT
Message-ID: <41DBE9F1.50303@redhat.com>
Date: Wed, 05 Jan 2005 08:21:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Greg Norris <haphazard@kc.rr.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [patch] screen_macros.te
References: <20050104230149.GA10317@yggdrasil.localdomain> <20050104233401.GA11885@yggdrasil.localdomain>
In-Reply-To: <20050104233401.GA11885@yggdrasil.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to add a new file type cert_t for ssl cert files, since 
these are defaulted to usr_t right now.
Shouldn't these be protected at a higher level?

#
# cert_t is the type of files in the system certs directories.
#
type cert_t, file_type, sysadmfile;

...

/usr/share/ssl/certs(/.*)?              system_u:object_r:cert_t


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
