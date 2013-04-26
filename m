Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3QJkd4B019638
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2013 15:46:46 -0400
References: <1366925707.22597.YahooMailNeo@web163405.mail.gq1.yahoo.com>
	<517A6B7D.7020202@tresys.com>
	<1366988065.21943.YahooMailNeo@web163406.mail.gq1.yahoo.com> <CAOFCXedCFke1xLykKCaV6gwULVzprWbAza_57s8NL5egVHAevg@mail.gmail.com>
Message-ID: <1367005602.41891.YahooMailNeo@web163403.mail.gq1.yahoo.com>
Date: Fri, 26 Apr 2013 12:46:42 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: SELinux errors with pam_faillock
To: Chad Hanson <dahchanson@gmail.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <CAOFCXedCFke1xLykKCaV6gwULVzprWbAza_57s8NL5egVHAevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov





----- Original Message -----
> From: Chad Hanson <dahchanson@gmail.com>
> To: Andy Ruch <adruch2002@yahoo.com>
> Cc: Christopher J. PeBenito <cpebenito@tresys.com>; SELinux ML <selinux@tycho.nsa.gov>
> Sent: Friday, April 26, 2013 9:16 AM
> Subject: Re: SELinux errors with pam_faillock
> 
> I think the bigger issue with your question on sudo and newrole is
> what have you done to get into the system without already creating
> faillog files for the current user. Both sudo and newrole are only
> authenticating the existing user. There is a problem in su.if that it
> needs manage instead of rw since you are changing to a different user
> which may not yet have a faillog entry as I would understand this
> process. Also, there is also a missing block to read the cracklib
> dictionaries in the sudo.if file.
> 

To my knowledge, the files in /var/run/faillock are created when an error (wrong password) occurs during user authentication, not when the user logs in. Are you saying the files should always be created, even on logon?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
