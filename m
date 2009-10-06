Message-ID: <4ACB5247.4000304@manicmethod.com>
Date: Tue, 06 Oct 2009 10:20:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] libsepol: Add support for multiple target OSes
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>	 <4AB0EF22.8070003@manicmethod.com> <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil>
In-Reply-To: <1254233003.2466.59.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Paul Nuzzi wrote:
> On Wed, 2009-09-16 at 09:58 -0400, Joshua Brindle wrote:
<snip>
> Thanks for your input.  Below is the updated patch for libsepol.
>

A quick look through looks good. I'd like to test it out a bit, do you 
have a Xen policy somewhere I can use for testing?

Also, I notice that this only lets you write out a "kernel" policy for 
Xen, but it might be beneficial to write out a base policy for testing, 
development, analysis, etc.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
