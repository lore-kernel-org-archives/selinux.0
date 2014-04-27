Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3R8a2CP011976
 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2014 04:36:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id ma3so860955pbc.19
 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2014 01:36:02 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.67.7])
 by mx.google.com with ESMTPSA id xo9sm70071233pab.18.2014.04.27.01.36.00
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 27 Apr 2014 01:36:01 -0700 (PDT)
Message-ID: <535CC0D4.40502@gmail.com>
Date: Sun, 27 Apr 2014 14:03:24 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Cannot enable selinux.
References: <5356053E.9080302@gmail.com>	<535661FC.5090007@tycho.nsa.gov>
 <CACLa4ps1QLAwYeApDfoEkxgfJhwkGjJ+E=2u0q7SZhd7V1m9zg@mail.gmail.com>
In-Reply-To: <CACLa4ps1QLAwYeApDfoEkxgfJhwkGjJ+E=2u0q7SZhd7V1m9zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/14 21:44, Eric Paris wrote:
> you might need security=selinux on your kernel command line
>
> or
>
> CONFIG_DEFAULT_SECURITY_SELINUX=y
> CONFIG_DEFAULT_SECURITY="selinux"
>
> to make it the default...
>
> On Tue, Apr 22, 2014 at 8:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 04/22/2014 01:59 AM, dE wrote:
>>> I've SECURITY_SELINUX enabled on my custom kernel, however on mounting
>>> with selinuxfs --
>>>
>>> mount: unknown filesystem type 'selinuxfs'
>>>
>>> As a result, I cant get sestatus enabled.
>> dmesg output?
>>
>> cat /proc/filesystems?
>>
>> Kernel command line arguments?
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

Yes, now the FS is working.
