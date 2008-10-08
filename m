Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m98Fkj4l032195
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 11:46:45 -0400
Received: from sca-es-mail-1.sun.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m98Fkhrv015743
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 15:46:43 GMT
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m98Fkg9W009582
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2008 08:46:42 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K8F00K01FGO9O00@fe-sfbay-09.sun.com>
 (original mail from Glenn.Faden@Sun.COM) for selinux@tycho.nsa.gov; Wed,
 08 Oct 2008 08:46:42 -0700 (PDT)
Date: Wed, 08 Oct 2008 08:46:28 -0700
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: user guide drafts: Maintaining SELinux Labels
In-reply-to: <48ECC9A3.5060407@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <48ECD5D4.3010302@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <48EC1ED7.8040308@redhat.com> <48ECC9A3.5060407@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Murray McAllister wrote:
>   
>> Hi,
>>
>> The following are the first few drafts of the "Maintaining SELinux
>> Labels" sections. Any comments and corrections are appreciated.
>>
>> Cheers.
>>
>> Copying Files and Directories
>>
>> When files and directories are copied, they inherit the SELinux context
>> of the parent directory they are copied to. This helps ensure files and
>> directories are labeled with the correct SELinux context after being
>> moved. The following example demonstrates copying a file from a user's
>> home directory to /var/www/html/, which is used by the Apache HTTP
>> Server. Since the file is copied, it inherits the correct SELinux context:
>>     
Is this true when using MLS policy? Assuming the policy allows a subject 
to create a file in a directory, shouldn't the newly created file's 
SELinux context have the same sensitivity as the subject who wrote it? 
Or is the new file's type copied from the directory and the sensitivity 
copied from the subject?

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
