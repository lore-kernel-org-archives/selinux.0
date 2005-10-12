Date: Wed, 12 Oct 2005 09:55:11 +0700
From: Dave Patterson <sdpatt2@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
Message-ID: <20051012025511.GC28317@localhost.localdomain>
References: <20051009083426.GA10995@localhost.localdomain> <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil> <20051011132002.GA6249@localhost.localdomain> <20051011170544.GE8829@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051011170544.GE8829@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2005-10-11 18:05:44 +0100]:

 
>  gdm is fairly sorted (because it's the default on FC) but kdm?  naah.
> 
>  the last time i mentioned this, i believe it was russell who mentioned
>  that there needs to be some work done in creating a modified policy to
>  deal with kdm.
> 
>  specifically, there is a part of kdm which communicates via a socket to
>  the user desktop bit, which allows kde to shut down the system.
> 
Thanks for that - good thing to know as I'm shaking the system down.

-- 
Regards, Dave
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
