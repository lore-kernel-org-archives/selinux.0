Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3QN6KmI031772
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2013 19:06:24 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so4063943iad.23
        for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2013 16:06:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367005602.41891.YahooMailNeo@web163403.mail.gq1.yahoo.com>
References: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com>
	<517A6B7D.7020202@tresys.com>
	<1366988065.21943.YahooMailNeo@web163406.mail.gq1.yahoo.com>
	<CAOFCXedCFke1xLykKCaV6gwULVzprWbAza_57s8NL5egVHAevg@mail.gmail.com>
	<1367005602.41891.YahooMailNeo@web163403.mail.gq1.yahoo.com>
Date: Fri, 26 Apr 2013 19:06:16 -0400
Message-ID: <CAOFCXedznMwP=3YO1yJ1tMjOaLfuyKF_QKwx45fBpJgWnc9+PA@mail.gmail.com>
Subject: Re: SELinux errors with pam_faillock
From: Chad Hanson <dahchanson@gmail.com>
To: Andy Ruch <adruch2002@yahoo.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would expect this to be case from reading the pam_faillock man page.
On successful attempts you clear file of any errors. I would assume
this would make the file if it doesn't exist. That seems to be the
case in my testing. This would be the only reason why some policy
modules have auth_manage_faillog vs auth_rw_faillog.  That interface
doesn't look to be run refpolicy yet, but is in policy-F13.patch in
RHEL 6. You are definitely correct that there needs to be policy for
the files to get created by someone.

On Fri, Apr 26, 2013 at 3:46 PM, Andy Ruch <adruch2002@yahoo.com> wrote:
>
>
>
>
> ----- Original Message -----
>> From: Chad Hanson <dahchanson@gmail.com>
>> To: Andy Ruch <adruch2002@yahoo.com>
>> Cc: Christopher J. PeBenito <cpebenito@tresys.com>; SELinux ML <selinux@tycho.nsa.gov>
>> Sent: Friday, April 26, 2013 9:16 AM
>> Subject: Re: SELinux errors with pam_faillock
>>
>> I think the bigger issue with your question on sudo and newrole is
>> what have you done to get into the system without already creating
>> faillog files for the current user. Both sudo and newrole are only
>> authenticating the existing user. There is a problem in su.if that it
>> needs manage instead of rw since you are changing to a different user
>> which may not yet have a faillog entry as I would understand this
>> process. Also, there is also a missing block to read the cracklib
>> dictionaries in the sudo.if file.
>>
>
> To my knowledge, the files in /var/run/faillock are created when an error (wrong password) occurs during user authentication, not when the user logs in. Are you saying the files should always be created, even on logon?
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
