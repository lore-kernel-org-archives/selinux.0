Date: Fri, 16 Sep 2005 14:48:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050916134859.GC9092@lkcl.net>
References: <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil> <432823F0.3030803@tresys.com> <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil> <43283772.7070603@tresys.com> <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil> <432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil> <43284A6B.8080507@tresys.com> <1126715064.12299.126.camel@moss-spartans.epoch.ncsc.mil> <43285B07.2070402@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43285B07.2070402@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2005 at 01:16:55PM -0400, Ivan Gyurdiev wrote:
> 
> >BTW, I just noticed - aren't the calls to sepol_debug() by
> >sepol_enable/disable_debug() broken?  If you just set the function
> >pointer, you don't want to clobber it using the old interface.
> >
> > 
> >
> The old interface is supposed to go away, but until it does, the new 
> interface must provide the same functionality, which is why it maintains 
> printing to stdout using the old system. 

 define old interface in terms of new one - including providing a debug
 function that writes to stdout.

 not only will this maintain a legacy api but also it will give
 people some example code to cut/paste into their updated app
 that uses the new api.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
