Subject: Re: SELinux: avc_has_perm: unexpected error 22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: qingtao.cao@windriver.com
Cc: "Justin P. Mattock" <justinmattock@gmail.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4D8C09A3.5090304@windriver.com>
References: <4D878244.4060502@gmail.com> <4D8A36E9.3070601@gmail.com>
	 <4D8AACD9.60505@gmail.com> <1300975137.8157.38.camel@moss-pluto>
	 <4D8B70C8.3000800@gmail.com> <1300997637.8157.44.camel@moss-pluto>
	 <4D8BA7F0.5090307@gmail.com> <1300998293.8157.48.camel@moss-pluto>
	 <4D8BACFD.6090400@gmail.com>  <4D8C09A3.5090304@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 08:26:29 -0400
Message-ID: <1301055989.22099.4.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-25 at 11:18 +0800, Harry Ciao wrote:
> So far I have not got an environment as your to reproduce this problem.
> Could you please kindly print the orig_class and the sock boolean in
> your case? It's weird since so far only the process and socket classes
> could retain the creator's role, any other classes object should have
> "object_r" as usual.
> 
> Many thanks for your help!

You can exercise the code without using XACE/XSELinux by running the
compute_create program from libselinux/utils, e.g.
$ compute_create `id -Z` `id -Z` x_drawable

I think the bug lies in map_class() handling of the case where the
userspace object class has no corresponding kernel class, as would be
the case for the x_* classes.  map_class() should likely return 0
(SECCLASS_NULL) in that case rather than pol_value and thereby ensure
that we won't match any legitimate kernel class value.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
