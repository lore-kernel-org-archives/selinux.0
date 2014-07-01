Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61I0gxv017769
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 14:00:42 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so10458716pde.24
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 11:00:28 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.86.48])
 by mx.google.com with ESMTPSA id u13sm327247pdi.34.2014.07.01.11.00.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 01 Jul 2014 11:00:27 -0700 (PDT)
Message-ID: <53B2F680.7060603@gmail.com>
Date: Tue, 01 Jul 2014 23:27:20 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Where's the class defined in file_contexts*
References: <53B2759A.2030209@gmail.com> <53B2908B.3060407@redhat.com>
In-Reply-To: <53B2908B.3060407@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/14 16:12, Daniel J Walsh wrote:
> On 07/01/2014 04:47 AM, dE wrote:
>> The default security context of a object also depends on it's class.
>>
>> I was looking at
>> etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts*, but I
>> couldn't see any definition of a class.
>>
>> Also semanage fcontext doesn't have an option define a class. Entries
>> are based only on files and directories.
>>
>> If you get red text in this email please notify.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
> I believe the answer to your question is:
>
> man semanage-fcontext
> ...
>         -f [{a,f,d,c,b,s,l,p}], --ftype [{a,f,d,c,b,s,l,p}]
>                File Type. This is used with fcontext. Requires a file
> type as shown in the mode field by ls, e.g. use 'd' to match only
> directories
>                or  'f'  to  match  only  regular  files. The following
> file type options can be passed: f (regular file),d (directory),c (character
>                device), b (block device),s (socket),l (symbolic link),p
> (named pipe).  If you do not specify  a  file  type,  the  file  type  will
>                default to "all files".

Thanks everyone for clarifying this.

I didnt know there existed man pages for semanage-*. It's not there in 
Fedora 19.
