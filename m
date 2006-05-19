From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
Date: Sat, 20 May 2006 00:40:45 +1000
Cc: Joshua Brindle <method@gentoo.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <446AFED3.9010800@redhat.com> <446DCD4C.6000303@gentoo.org> <1148047642.25168.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148047642.25168.107.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605200040.51013.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 20 May 2006 00:07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >  And you are still ignoring the case where
> > the translation actually changes. My worry isn't ls (which is one-shot,
> > and executes quickly most of the time), _anything_ that uses this
> > library code now caches the answer and if its a long running process
> > then it has no way of knowing when translations have changed or access
> > has been revoked.
>
> Notifications of changes to the translations make sense for correctness.
> Not so much of an access control issue.

Agreed in concept (although I doubt that you can do anything that is really 
correct in the face of translation changes during runtime).  Maybe the timing 
solution is the one to go for?

I think that it would be expected that when a translation is changed some 
programs will not display the new data instantly (note that there may be a 
delay of arbitrary length from the time the application gets the translation 
to the time it displays it, sorting output and many other things may occur).

For ls I don't think that we even need to have a time check, it usually 
doesn't run for a long period of time and does not support more than one 
operation per execution.  If a translation is changed while ls is executing 
then returning the initial version of the result is OK (no operation other 
than restarting execution of the program will give entirely consistent 
results in the face of such a change).

For ps unless there is something wrong it won't run for long enough to have 
any issues.

Another option might be to enable the cache on request.  So ls and ps can 
request the cache while other programs might not do so.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
