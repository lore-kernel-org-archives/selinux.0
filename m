Message-ID: <45DB36BE.5080905@hp.com>
Date: Tue, 20 Feb 2007 12:58:22 -0500
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole O_NONBLOCK change (Was:  Re: policycoreutils patch)
References: <45DB0AB8.3070803@redhat.com> <1171988261.14363.106.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1171988261.14363.106.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-02-20 at 09:50 -0500, Daniel J Walsh wrote:
> 
>>newrole hangs on a attached terminal device.  Nonblocking allows it to 
>>proceed.
> 
> 
> Won't this have side effects on programs run from the newrole'd shell?
> Should newrole open them with O_NONBLOCK and then clear it via fcntl
> before exec'ing the child shell?

Yep, it causes 'more' to not work, for example, so this is no good.
I'd like to understand why the open is hanging in the first place.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
