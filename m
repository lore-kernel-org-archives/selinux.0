Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MGEE6f012971
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 12:14:14 -0400
Received: by mail-lb0-f171.google.com with SMTP id w7so4509549lbi.16
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 09:14:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <535661FC.5090007@tycho.nsa.gov>
References: <5356053E.9080302@gmail.com>
	<535661FC.5090007@tycho.nsa.gov>
Date: Tue, 22 Apr 2014 12:14:11 -0400
Message-ID: <CACLa4ps1QLAwYeApDfoEkxgfJhwkGjJ+E=2u0q7SZhd7V1m9zg@mail.gmail.com>
Subject: Re: Cannot enable selinux.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

you might need security=selinux on your kernel command line

or

CONFIG_DEFAULT_SECURITY_SELINUX=y
CONFIG_DEFAULT_SECURITY="selinux"

to make it the default...

On Tue, Apr 22, 2014 at 8:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 04/22/2014 01:59 AM, dE wrote:
>> I've SECURITY_SELINUX enabled on my custom kernel, however on mounting
>> with selinuxfs --
>>
>> mount: unknown filesystem type 'selinuxfs'
>>
>> As a result, I cant get sestatus enabled.
>
> dmesg output?
>
> cat /proc/filesystems?
>
> Kernel command line arguments?
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
