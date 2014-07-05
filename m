Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s65AkS89023980
 for <selinux@tycho.nsa.gov>; Sat, 5 Jul 2014 06:46:28 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so2984537pac.25
 for <selinux@tycho.nsa.gov>; Sat, 05 Jul 2014 03:46:31 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.84.243])
 by mx.google.com with ESMTPSA id fy11sm12334469pdb.80.2014.07.05.03.46.29
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 05 Jul 2014 03:46:30 -0700 (PDT)
Message-ID: <53B7D6C9.50304@gmail.com>
Date: Sat, 05 Jul 2014 16:13:21 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Enforcing default_user, default_role, default_type, default_range
References: <53B4E97D.20401@gmail.com> <53B52610.30401@redhat.com>
 <1404386386.31757.YahooMailNeo@web87906.mail.ir2.yahoo.com>
In-Reply-To: <1404386386.31757.YahooMailNeo@web87906.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/03/14 16:49, Richard Haines wrote:
>
> ----- Original Message -----
>> From: Daniel J Walsh <dwalsh@redhat.com>
>> To: dE <de.techno@gmail.com>; selinux@tycho.nsa.gov
>> Cc:
>> Sent: Thursday, 3 July 2014, 10:44
>> Subject: Re: Enforcing default_user, default_role, default_type, default_range
>>
>>
>> On 07/03/2014 01:26 AM, dE wrote:
>>>   These rules are not enforced by the object manager, but does
>>>   restorecon read these?
>> No.  restorecon and other labeling tools just read the fcontext files.
>>>   Also what's the effect of these statements on SELinux aware
>> applications?
>> Most likely nothing.
>>>   Are there tools to list these statements? I didn't find anything in
>>>   sesearch man page, and seinfo is silent on this.
>>>   ________________
>> Probably not.  seinfo/sesearch have not been updated to handle them
> There is an updated version of APOL that will show these plus all other rules to
> policy version 29.
> You can either built it from:
> https://github.com/TresysTechnology/setools3.git
> or:
> https://github.com/QuarkSecurity/setools
>
> Or download the rpms from:
> https://quarksecurity.com/files/RPMS/
>
>>>   _______________________________
>>>   Selinux mailing list
>>>   Selinux@tycho.nsa.gov
>>>   To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>   To get help, send an email containing "help" to
>>>   Selinux-request@tycho.nsa.gov.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>

Graphical tools only?
