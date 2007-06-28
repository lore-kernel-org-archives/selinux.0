Subject: Re: selinux and FC6
From: James Athey <jathey@tresys.com>
To: shazyboy khan <shazyboy.linux@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <7e531af80706280400w7f42600ai8cb01680d2236843@mail.gmail.com>
References: <7e531af80706280400w7f42600ai8cb01680d2236843@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 28 Jun 2007 11:34:42 -0400
Message-Id: <1183044882.20574.12.camel@exodus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fedora Core 6, you do not need a different kernel; the official one
will do.

The policy source code (text) can be found here:
http://oss.tresys.com/projects/refpolicy

A good GUI tool for editing SELinux policy is SLIDE:
http://oss.tresys.com/projects/slide

And finally, some shameless commercial promotion: if you want to learn
more about editing the Reference policy, take a look at this book:
http://www.selinuxbyexample.com/

~James

On Thu, 2007-06-28 at 16:00 +0500, shazyboy khan wrote:
> Hi selinux
> 
> I a new user and cannot do with any tutorials because things always
> changing in selinux.
> 
> I want to work with selinux want to understand.
> 
> Where policy in text is?
> How should I work ipsec netlabels?
> Do really need lspp kernel? I have fedora core 6.
> How do I learn edit selinux policy? I cannot use apol. Any better gui tool?
> 
> tankoo
> shazyboy.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
