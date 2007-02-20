Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KKhN3D012574
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:43:23 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KKielw004319
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 20:44:41 GMT
Subject: Re: Is the usercanread attribute still needed?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
References: <e739902b0702181633md9e8fa9y55e74a5520cf7a60@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 20:44:54 +0000
Message-Id: <1172004294.20576.236.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-02-18 at 16:33 -0800, Ryan Bradetich wrote:
> Hello all,
> 
> I noticed the apache.te file used the file_types() macro instead of
> the file_config_file() macro for the configuration files, so I looked
> into the differences between the macros.
> 
> The files_config_file macro is listed below:
> 
> interface(`files_config_file',`
>         gen_require(`
>                 attribute usercanread;
>         ')
> 
>         files_type($1)
> 
>         # this is a hack and should be removed.
>         typeattribute $1 usercanread;
> ')
> 
> 
> After reading the comment above the typeattribute, I was curious to
> figure out what the usercanread attribute was used for. Looking
> through the SVN tree I found the following uses.
> 
> $ find . -type f | xargs grep  usercanread | grep -v '.svn'
> ./modules/kernel/files.if:              attribute usercanread;
> ./modules/kernel/files.if:      typeattribute $1 usercanread;
> ./modules/kernel/files.te:attribute usercanread;
> 
> 
> I used the attached patched to remove the attribute from the files.te
> and files.if file and the policy still compiled.  Is it safe to assume
> we can remove the attribute now?  Or is the hack still needed for
> something I am not seeing?

Since modules are statically compiled, we can't completely remove the
attribute yet, otherwise it might cause some policies to fail to link if
it is still required.  However, the typeattribute could be removed from
files_config_file().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
