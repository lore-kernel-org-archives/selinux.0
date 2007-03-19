Subject: Re: [PATCH] libselinux lazy init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <134076.39235.qm@web51511.mail.re2.yahoo.com>
References: <134076.39235.qm@web51511.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 13:57:18 -0400
Message-Id: <1174327038.22565.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-19 at 10:41 -0700, Steve G wrote:
> >Looking back at Roland's advice, I notice that his sample code
> >introduced an explicit bool flag rather than overloading the
> >pthread_once_t variable.
> 
> It doesn't look like overloading to me. The man page says:
> 
> pthread_once_t once_control = PTHREAD_ONCE_INIT;

...which could be a struct.
> 
> The Single Unix Specification says its a constant:
> 
> The constant PTHREAD_ONCE_INIT is defined by the header <pthread.h>.

Constant-valued struct would meet that spec.

> The header file says:
> 
> #define PTHREAD_ONCE_INIT 0
> 
> So, it is a constant integer. I would imagine there is breakage for commercial
> binary apps if that ever changed.

Looking around with google, I found:
http://publib.boulder.ibm.com/infocenter/pseries/v5r3/index.jsp?topic=/com.ibm.aix.genprogc/doc/genprogc/1time_initializations.htm
which says that it is a structure in many systems.

So possibly it is always an integer in Linux, but the spec and the API
don't guarantee that, and I did notice that Roland avoided that
assumption in his code snippet.  I can't see why we would make that
assumption.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
