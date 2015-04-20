Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3KE5OtK009660
 for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2015 10:07:59 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3KE5MWK020773
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2015 10:05:22 -0400
Message-ID: <553507A0.1050902@redhat.com>
Date: Mon, 20 Apr 2015 16:05:20 +0200
From: Florian Weimer <fweimer@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com> <552FFA39.3030909@redhat.com>
In-Reply-To: <552FFA39.3030909@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/16/2015 08:06 PM, Daniel J Walsh wrote:
> 
> On 04/16/2015 05:28 AM, Florian Weimer wrote:
>> The ABRT coredump handler has code to emulate default core file creation
>> (as if no such pipe-based handler was installed).  The handler runs in a
>> separate process, initially as root.  Currently, the handler just
>> switches effective IDs and creates the file.  This does not replicate
>> the SELinux context of the zombie process.
>>
>> Is there a way to do that?   Is there some recommended way to inherit
>> all the security-related process attributes?
>>
> You have two choices.  1 would be to setcon() call to change the label
> to the user process.
> 
> The other choice would be to ask the kernel what label this user would
> create if he created a file
> in the specified directory.  This is what systemd does.

Dan, could you please double-check if this change (implementing the
second option) looks reasonable?

<https://github.com/abrt/abrt/commit/3e4155bfcd9f6f5a20964080fa05724503b20761>

Thanks,
Florian
-- 
Florian Weimer / Red Hat Product Security
