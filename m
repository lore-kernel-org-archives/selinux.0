Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12319
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 09:42:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA10204
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 13:40:46 GMT
Received: from tag.witbe.net (tag.witbe.net [62.161.213.166])
	by jazzswing.ncsc.mil  with ESMTP id NAA10200
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2001 13:40:44 GMT
From: "Paul Rolland" <rol@as2917.net>
To: "Stephen Smalley" <sds@tislabs.com>, "Paul Rolland" <rol@as2917.net>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Question regarding security policy configuration
Date: Tue, 4 Sep 2001 15:42:02 +0200
Message-ID: <NEBBIPOEBBGDFEJAJJBCIEHEFCAA.rol@as2917.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.SOL.3.95.1010904084649.319D-100000@clipper.gw.tislabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

This I did, but I think there is something wrong in the setfiles/*,
the problem is that from the error messages, I don't know how to
translate this to :
 - a file to check
 - an item to check in the file(s) in setfiles/*

Paul


Paul Rolland, rol@witbe.net
Witbe.net SA
Directeur Associe

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dreams of success... while others wake up and work hard at it"



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tislabs.com]
> Sent: Tuesday, September 04, 2001 2:52 PM
> To: Paul Rolland
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Question regarding security policy configuration
>
>
>
> On Sun, 2 Sep 2001, Paul Rolland wrote:
>
> > For example, looking at the first one :
> > Aug 29 17:58:46 www-dev kernel: avc:  denied  { read write }
> for  pid=58
> > exe=/bin/mount path=/etc/mtab dev=08:02 ino=166389
> > Aug 29 17:58:46 www-dev kernel:    scontext=system_u:system_r:mount_t
> > Aug 29 17:58:46 www-dev kernel:    tcontext=system_u:object_r:file_t
> > Aug 29 17:58:46 www-dev kernel:    tclass=file
> > Aug 29 17:58:46 www-dev kernel:
> >
> > I've found in the source tree :
> > /bin/mount: system_u:object_t:mount_exec_t
> > /etc/mtab: system_u:object_r:etc_runtime_t
> >
> > This is different from scontext (Security (?) context) and tcontext
> > (Task (?) context)....
> >
> > It seems I deeply missed some configs, but I can't find them.
> Could someone
> > help me ?
>
> Do the following:
> 	cd setfiles
> 	rm -f relabel
> 	make relabel
>
> This was step #14 of the README.
>
> The scontext is the source security context, which is typically
> the security context of a process (but not always).  The tcontext
> is the target security context, which can be the security
> context of a target process (e.g. for controlling kill) or
> the security context of an object (e.g. for file accesses).
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
