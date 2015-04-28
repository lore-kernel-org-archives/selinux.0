Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3SHD17b021573
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 13:13:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id C33E6C1EED
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 17:12:58 +0000 (UTC)
Message-ID: <553FBF96.8030309@redhat.com>
Date: Tue, 28 Apr 2015 19:12:54 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: Florian Weimer <fweimer@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
 SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com> <552FFA39.3030909@redhat.com>
 <553507A0.1050902@redhat.com>
In-Reply-To: <553507A0.1050902@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/20/2015 04:05 PM, Florian Weimer wrote:
> On 04/16/2015 08:06 PM, Daniel J Walsh wrote:
>>
>> On 04/16/2015 05:28 AM, Florian Weimer wrote:
>>> The ABRT coredump handler has code to emulate default core file creation
>>> (as if no such pipe-based handler was installed).  The handler runs in a
>>> separate process, initially as root.  Currently, the handler just
>>> switches effective IDs and creates the file.  This does not replicate
>>> the SELinux context of the zombie process.
>>>
>>> Is there a way to do that?   Is there some recommended way to inherit
>>> all the security-related process attributes?
>>>
>> You have two choices.  1 would be to setcon() call to change the label
>> to the user process.
>>
>> The other choice would be to ask the kernel what label this user would
>> create if he created a file
>> in the specified directory.  This is what systemd does.
> 
> Dan, could you please double-check if this change (implementing the
> second option) looks reasonable?
> 
> <https://github.com/abrt/abrt/commit/3e4155bfcd9f6f5a20964080fa05724503b20761>

I would go with _raw interfaces how Stephen suggested above. Also we
should take care about ABRT SELinux policy.

> Thanks,
> Florian
> 


-- 
Miroslav Grepl
Software Engineering, SELinux Solutions
Red Hat, Inc.
