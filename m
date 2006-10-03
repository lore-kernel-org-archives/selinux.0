Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93GeAjD017491
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:40:11 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93GdZO7005594
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:39:36 GMT
Message-ID: <45229267.9070400@hp.com>
Date: Tue, 03 Oct 2006 12:40:07 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, redhat-lssp@redhat.com, vyekkirala@TrustedCS.com,
        jmorris@namei.org
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>
In-Reply-To: <1159834998.28144.115.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> DO NOT USE THESE KERNELS ON A PRODUCTION SYSTEM!
> 
> If you go to http://people.redhat.com/eparis/RHEL5_labeled_networking/
> you should find a set of kernels based off of the Red Hat RHEL5 source
> tree.  These should include patches for 
> 
> network labeling support from Venkat
> netlabel auditing
> ipsec/secmark secid reconciliation
> netlabel secid reconciliation
> 
> I need a very fast response from everyone involved if these kernels
> 
> A) boot
> B) run without labeled networking (very very important)
> C) run with labeled networking
> 
> If you run across a problem feel free to let me or the list know.  You
> may also feel free to open a bug in bugzilla.redhat.com for the product
> choose Red Hat Enterprise Linux Public Beta and RHEL5.  If you open a
> bug for this labeled networking you can go ahead and assign it to
> eparis@redhat.com so I'm sure to see it and bug the correct people.

So far in my testing I've noticed two things related to "C" using
NetLabel and neither seem to be specific to the RHEL5 backport.  I'm
just getting a handle on both of these issues so no patches yet but I
will keep everybody up to date as things progress.

The first is a race condition with the NetLabel cache caused when
NetLabel returns a cached security attribute to the LSM layer at the
same time that the cache is being invalidated (NOTE: case "B" should not
be affected).  The result is an Oops with
selinux_netlbl_secattr_to_sid() in the stack.  I think I have settled on
a reasonable fix for this, but I want to dwell on it a bit more.  In the
meantime the workaround is to disable the cache:

 # sysctl -w net.ipv4.cipso_cache_enable=0

The second issue is more of a correctness problem in
selinux_ip_postroute_last() and selinux_skb_flow_out() related to what
NetLabel uses as it's "base SID"; the changes made in the "v3" draft of
the patch messed this up a bit.  It's important to note this shouldn't
cause any sort of panic/oops/etc. it just results in a incorrect
NetLabel context when NetLabel is configured (i.e. case "B" should not
be affected).

I'll have more information, patches, bugzillas, etc. as things progress.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
