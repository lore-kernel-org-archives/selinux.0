Subject: Re: 2.6.25-rc5
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30803140816n68edaf2fg82f3b551f728b28@mail.gmail.com>
References: <dd18b0c30803140816n68edaf2fg82f3b551f728b28@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 14:00:37 -0400
Message-Id: <1205776837.22912.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-14 at 15:16 +0000, Justin Mattock wrote:
> Hi; 
> 
> Thanks for the response.  I think the policy and the kernel is running
> smoothly, of course there's quirks here and there, in the meantime,
> I've been side tracked from power consumption, to capability.h. In
> doing so Its been interesting reading that file. I've been  trying to
> compile a driver(fglrx) thats been complaining about
> KCLPosixSecurityCap, cap_t. With reading capability.h cap_t is being
> moved to libcap, so having cap_t put in libcap, and having fglrx read
> libcap, for cap_t
>  seems to be interesting. with capability2 will it reside in the same
> file as capability.h, or somewhere else.
> Overall I think capability's are a very good idea.

I'm not sure what you are talking about, but it doesn't sound selinux
related.

Possibly you are referring to the fact that capabilities in Linux have
recently expanded from 32 bits to 64 bits and you need an updated
driver.

capability2 is just a way for SELinux to map capabilities >= 32 to an
access vector.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
