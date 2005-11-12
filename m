From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: unreasonably long SE Linux context display
Date: Sat, 12 Nov 2005 21:29:21 +1100
Cc: James Morris <jmorris@namei.org>, Daniel J Walsh <dwalsh@redhat.com>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <200510311812.02462.russell@coker.com.au> <1130776438.22731.142.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1130776438.22731.142.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511122129.30879.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 01 November 2005 03:33, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > For ls it would be good to be able to display part of the context.  For
> > the vast majority of invocations of "ls -Z" on a SE Linux system the
> > identity and role are not desired in the output.
>
> James previously suggested introducing environment variables to control
> the display of contexts, so that you could alter ls and ps -Z output
> simply by adjusting such variables.

I don't think that's such a good idea.  As the output of such programs will be 
used by shell scripts it will have some interesting possibilities for 
breaking such scripts.

> In any event, patches speak louder than words here...

OK, as no-one seems to have a great objection I'll write some patches when I 
find time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
