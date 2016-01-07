Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u07Mc39u017705
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 17:38:03 -0500
Received: by mail-io0-f174.google.com with SMTP id q21so268592563iod.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jan 2016 14:38:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <568EE4E6.6090907@redhat.com>
References: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
 <568EE4E6.6090907@redhat.com>
Date: Thu, 7 Jan 2016 15:38:00 -0700
Message-ID: <CAPubmWXD0Oro89LEZ+UAqA=DkdJ7myzSuA_vspeCrd7cdwg+4g@mail.gmail.com>
Subject: Re: Diskless system running SELinux
From: Andrew Ruch <adruch2002@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 7, 2016 at 3:21 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>
>
> On 01/07/2016 04:48 PM, Andrew Ruch wrote:
>> Hello,
>>
>> I'm researching deploying a diskless system that would use PXEBoot and
>> NFS for it's storage. I believe this capability has been proven and
>> have no issues here. The tricky part is this system must also have
>> Mandatory Access Control. I thought RHEL 7.2 was the answer due to
>> it's support of labeled NFS. However, Red Hat just told me that having
>> an SELinux-labeled, remote root partition is unsupported. What wasn't
>> clear was if the problem was in RHEL or something upstream.
>>
>> Does the kernel support a labeled, remote root partition? If so, which
>> distributions support this?
>>
>>
>> Thanks,
>> Andrew Ruch
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
>>
> I just think no one has ever tried this.  If the remote system is setup
> with nfs labeling, theoretically this
> should work.
>
> Not only rhel7 supports labeled networking on the server and client, to
> the best of my knowleged.
>
> Not sure if NetApp or EMC support it yet.

Hmmm...  Red Hat Support referred me to an installation guide [1] at
the very bottom of section 2.2. It says that SELinux must be disabled
for diskless clients that use NFS as the root file system. I'm not
trying to use RHEL for Real Time so I'll do some experimenting to see
what I can figure out.

Thanks,
Andrew


[1] https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_for_Real_Time/7/html/Installation_Guide/Installing_Real_Time_Using_Diskless_Boot.html
