Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s63BTe1V022918
 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2014 07:29:41 -0400
References: <53B4E97D.20401@gmail.com> <53B52610.30401@redhat.com>
Message-ID: <1404386386.31757.YahooMailNeo@web87906.mail.ir2.yahoo.com>
Date: Thu, 3 Jul 2014 12:19:46 +0100
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Enforcing default_user, default_role, default_type, default_range
To: Daniel J Walsh <dwalsh@redhat.com>, dE <de.techno@gmail.com>
In-Reply-To: <53B52610.30401@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



----- Original Message -----
> From: Daniel J Walsh <dwalsh@redhat.com>
> To: dE <de.techno@gmail.com>; selinux@tycho.nsa.gov
> Cc: 
> Sent: Thursday, 3 July 2014, 10:44
> Subject: Re: Enforcing default_user, default_role, default_type, default_range
> 
> 
> On 07/03/2014 01:26 AM, dE wrote:
>>  These rules are not enforced by the object manager, but does
>>  restorecon read these?
> No.  restorecon and other labeling tools just read the fcontext files.
>> 
>>  Also what's the effect of these statements on SELinux aware 
> applications?
>> 
> Most likely nothing.
>>  Are there tools to list these statements? I didn't find anything in
>>  sesearch man page, and seinfo is silent on this.
>>  ________________
> Probably not.  seinfo/sesearch have not been updated to handle them

There is an updated version of APOL that will show these plus all other rules to
policy version 29. 
You can either built it from:
https://github.com/TresysTechnology/setools3.git
or:
https://github.com/QuarkSecurity/setools

Or download the rpms from:
https://quarksecurity.com/files/RPMS/

>>  _______________________________
>>  Selinux mailing list
>>  Selinux@tycho.nsa.gov
>>  To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>  To get help, send an email containing "help" to
>>  Selinux-request@tycho.nsa.gov.
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
