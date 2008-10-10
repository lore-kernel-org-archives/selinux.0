Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9A7jZOH004677
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 03:45:35 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9A7iMLS014363
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 07:44:23 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9A7jZHZ007617
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 03:45:35 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9A7jYrD019509
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 03:45:35 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m9A7jX4K006429
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 03:45:34 -0400
Message-ID: <48EF081C.2030100@redhat.com>
Date: Fri, 10 Oct 2008 17:45:32 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com> <48EF050D.3090308@redhat.com>
In-Reply-To: <48EF050D.3090308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Murray McAllister wrote:
>> Hi,
>>
>> The following is a rough draft for the "Mounting File Systems" 
>> sections. Any comments and corrections are appreciated.
>>
>> Thanks!
>>
>> Mounting File Systems
>>
>> By default, when a third extended file system (ext3) is mounted, the 
>> files and directories on the file system are labeled with the file_t 
>> type. The mount command can override SELinux contexts when mounting 
>> file systems. SELinux context changes with the mount command can be 
>> per-session only (until the file system is unmounted), or persistent 
>> (context changes are written to disk).

Sorry for all the spam. Should I add a note that this only applies if 
mounted to a newly-created directory under / ?

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
