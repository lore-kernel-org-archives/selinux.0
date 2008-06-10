Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5AEIns5004821
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 10:18:49 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5AEIj3e027515
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 14:18:45 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1465231ywa.84
        for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 07:18:41 -0700 (PDT)
Message-ID: <484E8D3D.9010809@gmail.com>
Date: Tue, 10 Jun 2008 09:18:37 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: avc_* functions not in libselinux-python
References: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>	 <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>	 <cadfc0e40804091330t6ff1aadbned7d5fbc1479fdf5@mail.gmail.com> <1213105787.30576.103.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213105787.30576.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2008-04-09 at 15:30 -0500, Xavier Toth wrote:
>   
>> For now I don't think that's a problem as I was looking at using
>> avc_has_perm and the context to sid conversion function.
>>     
>
> What's the status on this?  I see patches in the Fedora libselinux
> package to add the AVC interfaces to the swig bindings, but they aren't
> upstream.  Do they work as expected? 
The interfaces I'm using (avc_open, avc_reset, avc_context_to_sid, 
avc_has_perm_noaudit) are working as expected.

>  Should they be upstreamed?
>
>   
I think so.
>> On Wed, Apr 9, 2008 at 12:30 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>     
>>>  On Tue, 2008-04-08 at 17:02 -0500, Xavier Toth wrote:
>>>  > Can these functions get swig'd and their wrappers built into _selinux.so?
>>>
>>>  Patches accepted.
>>>
>>>  One possible issue here is function pointer callbacks, which is a more
>>>  general problem than just the avc interfaces in libselinux.  But if you
>>>  are ok with the default callbacks, I suppose there is no problem there.
>>>
>>>  --
>>>  Stephen Smalley
>>>  National Security Agency
>>>
>>>
>>>       
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>     


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
