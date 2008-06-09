From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: releasibility in mcstransd
Date: Mon, 9 Jun 2008 16:50:59 -0400
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
References: <484D91BB.3080904@manicmethod.com>
In-Reply-To: <484D91BB.3080904@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091650.59271.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 09 June 2008 4:25:31 pm Joshua Brindle wrote:
> I am adding releasibility support to mcstransd and just wanted to see
> if there were any comments or complaints to what I'm planning here.
>
> Rather than adding a generic prefix mechanism like the CMW encodings
> I did something specific for releasibility, in setrans.conf:
>
> releasibility c100.c128
>
> then encodings look like:
>
> s0:~c100 = rel_US
> s0:~c101 = rel_Texas
>
> so a file with s0:c102.c128 would translate to s0:rel_US,rel_Texas.
>
> any comments? Does anyone think this is absolutely the wrong
> approach?

Unless there is a reason to do away with the existing CMW convention I 
think we should probably stick with it for no other reason than it is 
familiar to users migrating from CMW boxes to SELinux.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
