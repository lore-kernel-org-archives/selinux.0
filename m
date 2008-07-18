Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IJ8YnT016823
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 15:08:34 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IJ8X29029833
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 19:08:34 GMT
Message-ID: <4880EA15.8010705@redhat.com>
Date: Fri, 18 Jul 2008 15:08:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Mike Edenfield <kutulu@kutulu.org>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: refpolicy patch: samba enhancements
References: <487BB78D.6080500@kutulu.org> <1216393143.21191.155.camel@gorn>	 <4880D35C.8060302@kutulu.org> <1216405172.21191.179.camel@gorn>
In-Reply-To: <1216405172.21191.179.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Fri, 2008-07-18 at 13:31 -0400, Mike Edenfield wrote:
>> Christopher J. PeBenito wrote:
>>> On Mon, 2008-07-14 at 16:31 -0400, Mike Edenfield wrote:
>>>> +tunable_policy(`samba_create_home_dirs',`
>>>> +    unprivuser_home_filetrans_home_dir(smbd_t)
>>>> +    unprivuser_manage_home_dirs(smbd_t)
>>> I think we want this to be unprivuser_create_home_dirs(), which would
>>> need to be added.
>> That was my first instinct but I didn't see one already present, so I 
>> just copied what I found for oddjob_mkhomedir.
>>
>> I'll define a new interface for this -- I assume that's probably a 
>> separate patch?
> 
> No, its fine to include it in this one.
> 
>>   And I should convert the sysadm role and oddjob type to 
>> use the interface?
> 
> Sysadm is fine as is, since it already has broad powers for managing
> users.  I'm not sure about the oddjob usage; you'd have to check the
> programs features to see if it does other things in addition to just
> creating the dirs.
> 
Oddjob creates the directory and copies /etc/skel


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
