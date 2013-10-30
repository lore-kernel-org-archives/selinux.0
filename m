Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle
 <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <52715E75.5000005@redhat.com>
References: <52715E75.5000005@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Oct 2013 19:54:30 -0400
Message-ID: <1383177270.23834.37.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-10-30 at 15:31 -0400, Daniel J Walsh wrote:

> Here is a patch I have been fooling around with which would read a policy.29
> file if it was compressed with xz.

Hm, it's kind of ugly to attempt to open the policy with LZMA and only
if that returns (any kind of error) fails fall back to the old code.
Wouldn't it be better to say check whether or not it starts with a new
magic number, like the kernel policydb_read() function does?

In other words have:

[New 32 bit magic number] [Compressed policy]



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
