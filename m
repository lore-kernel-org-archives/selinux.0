Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IHSIJ1030125
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:28:18 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IHSIoF010550
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 17:28:18 GMT
Message-ID: <4880D35C.8060302@kutulu.org>
Date: Fri, 18 Jul 2008 13:31:08 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org> <1216393143.21191.155.camel@gorn>
In-Reply-To: <1216393143.21191.155.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-07-14 at 16:31 -0400, Mike Edenfield wrote:

>> +tunable_policy(`samba_create_home_dirs',`
>> +    unprivuser_home_filetrans_home_dir(smbd_t)
>> +    unprivuser_manage_home_dirs(smbd_t)
> 
> I think we want this to be unprivuser_create_home_dirs(), which would
> need to be added.

That was my first instinct but I didn't see one already present, so I 
just copied what I found for oddjob_mkhomedir.

I'll define a new interface for this -- I assume that's probably a 
separate patch?  And I should convert the sysadm role and oddjob type to 
use the interface?

>> @@ -404,7 +419,7 @@
>>   read_files_pattern(nmbd_t,samba_etc_t,samba_etc_t)
>>
>>   manage_dirs_pattern(nmbd_t,samba_log_t,samba_log_t)
>> -append_files_pattern(nmbd_t,samba_log_t,samba_log_t)
>> +manage_files_pattern(nmbd_t,samba_log_t,samba_log_t)
>>   allow nmbd_t samba_log_t:file unlink;
>>
>>   read_files_pattern(nmbd_t,samba_log_t,samba_log_t)
> 
> If the goal is just to add a rename permission onto nmbd, then that
> permission should be added explicitly.  Manage will allow it to delete
> the log, which we don't want, if we don't have to.

Actually, I missed a line when I was reapplying my patches to do svn 
diffs; the nmbd_t type already has unlink permissions for the type, just 
not rename, so it seemed that manage_files was the correct thing -- it 
should let me get rid of the next line as well.

New patch coming in a bit.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
