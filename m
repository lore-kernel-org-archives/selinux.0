Date: Wed, 14 Sep 2005 08:01:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050914070159.GE1257@lkcl.net>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu> <43264DAD.5090903@cornell.edu> <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil> <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com> <432799F0.7060706@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432799F0.7060706@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 13, 2005 at 11:33:04PM -0400, Ivan Gyurdiev wrote:
> The core of the problem is library-wide debugging without 
> caller-supplied state object.
 
 why would you not wish to do that?

 is there a specific reason which _prevents_ caller-supplied state?
 (which is how the best libraries are designed)

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
