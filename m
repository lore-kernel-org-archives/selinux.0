Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14CUG53006692
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:30:16 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107478728.4065.3.camel@cobra.ivg2.net>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com>  <1107478728.4065.3.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107519821.8078.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:23:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-03 at 19:58, Ivan Gyurdiev wrote:
> On Wed, 2005-02-02 at 08:32 -0500, Daniel J Walsh wrote:
> > -if (allow_execmod) {
> > -allow $1 texrel_shlib_t:file execmod;
> > -}
> 
> ... X needs execmod, and this change breaks it:
> 
> audit(1107469036.956:0): avc:  denied  { execmod } for  pid=3383 comm=X
> path=/usr/lib/nvidia/tls/libnvidia-tls.so.1.0.6629 dev=dm-0 ino=519237
> scontext=system_u:system_r:xdm_xserver_t
> tcontext=system_u:object_r:texrel_shlib_t tclass=file

To be precise, X needs execmod when using nvidia, right?  Not everyone
using X needs it (I don't).  In any event, we want the execmod rules to
be added to the individual domain .te files, not put in a global macro
used by everything, and only allowed as needed.  Further, I'd ultimately
like to have separate booleans for different sets of execmem/execmod
permissions so that we can allow certain programs to have them while
preventing others.

> Also, mozilla needs execmem. What's going on with this - I've
> seen it sent twice and rejected twice... 
> 
> audit(1107476807.924:0): avc:  denied  { execmem } for  pid=3828
> comm=firefox-bin scontext=user_u:user_r:user_mozilla_t
> tcontext=user_u:user_r:user_mozilla_t tclass=process

Think hard about whether you want to expose your browser in this
manner.  Not sure why you are getting execmem in firefox itself; I would
have expected it only in plugins like java (which should be moved into
their own domain).  Even if this is _truly_ needed, it should definitely
be under a separate boolean of its own, as this is clearly a
network-exposed app that is highly at risk to malicious input.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
