Subject: Re: xend and noatsecure
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200810210740.49713.russell@coker.com.au>
References: <200810210740.49713.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 20 Oct 2008 16:43:42 -0400
Message-Id: <1224535422.7428.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-21 at 07:40 +1100, Russell Coker wrote:
> allow xend_t xenstored_t:process { noatsecure };
> allow xend_t xenconsoled_t:process { noatsecure };
> 
> The Xen packages in Debian/Lenny will not support Xen starting correctly on 
> boot unless the above lines are added to the policy.
> 
> Starting XEN control daemon: xend/usr/lib/xen-3.2-1/bin/xenstored: error while 
> loading shared libraries: libxenctrl.so: cannot open shared object file: No 
> such file or directory
> /usr/lib/xen-3.2-1/bin/xenconsoled: error while loading shared libraries: 
> libxenctrl.so: cannot open shared object file: No such file or directory
> 
> Above are the errors.
> 
> It seems that LD_PRELOAD (or one of the similar environment variables) is 
> being set.

Likely just LD_LIBRARY_PATH is being set to tell it where to find the
shared libraries.

> What is the best way of solving this?

Install the shared libraries into standard locations or add them
to /etc/ld.so.conf.d.

> 
> For Lenny I think I will just have to allow noatsecure, the chance of getting 
> modified Xen packages in Lenny at this stage seem quite low.  But for Lenny+1 
> I want to get it solved in the best possible way.
> 
> Have the Red Hat guys done something in this regard?
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
