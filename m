Date: Thu, 28 Mar 2002 09:09:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: John Doe <r2q2@rocketmail.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: LD problems
In-Reply-To: <20020328085204.23784.qmail@web14607.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0203280900420.22457-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 28 Mar 2002, John Doe wrote:

> I just compiled the 2.4 kernal and it keeps on giving me this error
> message.
> INIT: ld Respawning too fast : disabled for 5 minutes.
> Did I do something wrong in the kernel compile or something?

Did you follow the installation instructions in selinux/README?  Are you
using RH7.1 or RH7.2 as your base platform?  Did you remember to enable
the SELinux Development Module option, as recommended by the README?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
