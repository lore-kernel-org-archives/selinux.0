Date: Fri, 16 Sep 2005 14:45:32 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050916134532.GA9092@lkcl.net>
References: <432799F0.7060706@cornell.edu> <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil> <432823F0.3030803@tresys.com> <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil> <43283772.7070603@tresys.com> <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil> <432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil> <43284A6B.8080507@tresys.com> <43287BDC.1090004@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43287BDC.1090004@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2005 at 03:37:00PM -0400, Ivan Gyurdiev wrote:
> 
> >So, do you mean taking write_error, optionally passing in a string and 
> >size, having it write to the string if it's present and then calling 
> >the debug function pointer if it is present? That way we'll get the 
> >error in the handle so that the caller can deal with it and the debug 
> >function would also be called. Then the caller could choose to use 
> >debug by setting the pointer and other apps that need an error in the 
> >handle could use that?
> >
> >This seems reasonable to me.. Ivan?

 can i make a suggestion, namely that an old-looking api be written
 in terms of the "new" api?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
