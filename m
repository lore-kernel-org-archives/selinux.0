Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IIK0xt007378
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:20:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IIJxoF024197
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 18:19:59 GMT
Subject: Re: refpolicy patch: samba enhancements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <4880D35C.8060302@kutulu.org>
References: <487BB78D.6080500@kutulu.org> <1216393143.21191.155.camel@gorn>
	 <4880D35C.8060302@kutulu.org>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 14:19:32 -0400
Message-Id: <1216405172.21191.179.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-18 at 13:31 -0400, Mike Edenfield wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2008-07-14 at 16:31 -0400, Mike Edenfield wrote:
> 
> >> +tunable_policy(`samba_create_home_dirs',`
> >> +    unprivuser_home_filetrans_home_dir(smbd_t)
> >> +    unprivuser_manage_home_dirs(smbd_t)
> > 
> > I think we want this to be unprivuser_create_home_dirs(), which would
> > need to be added.
> 
> That was my first instinct but I didn't see one already present, so I 
> just copied what I found for oddjob_mkhomedir.
> 
> I'll define a new interface for this -- I assume that's probably a 
> separate patch?

No, its fine to include it in this one.

>   And I should convert the sysadm role and oddjob type to 
> use the interface?

Sysadm is fine as is, since it already has broad powers for managing
users.  I'm not sure about the oddjob usage; you'd have to check the
programs features to see if it does other things in addition to just
creating the dirs.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
