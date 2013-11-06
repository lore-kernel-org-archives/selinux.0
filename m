Message-ID: <527A4208.6050605@tycho.nsa.gov>
Date: Wed, 06 Nov 2013 08:20:08 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: mthode@mthode.org
CC: selinux@tycho.nsa.gov
Subject: Re: kernel function to verify rootcontext
References: <5279C0A6.2090703@mthode.org>
In-Reply-To: <5279C0A6.2090703@mthode.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/05/2013 11:08 PM, Matthew Thode wrote:
> Is there a kernel function used to verify that a rootcontext is valid
> (exists and/or is formatted correctly).
> 

Not sure what you mean.  SELinux directly handles and consumes the
rootcontext= and other related mount options before they are passed
along to the filesystem code, so your filesystem doesn't need to do
anything with it.

security_context_to_sid() is the SELinux kernel function for validating
security contexts and mapping them to a security identifier (SID), but
you shouldn't call that from your filesystem code.

>From userspace, you can check a context by writing the context string to
/sys/fs/selinux/context or by calling the libselinux
security_check_context() function (which internally does the same thing)
and checking the result.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
