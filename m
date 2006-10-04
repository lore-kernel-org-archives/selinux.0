Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94EQHHU015830
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 10:26:17 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94EPfCa009540
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 14:25:42 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CF850@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: RE: [redhat-lspp] Labeled networking at the end of the day Oct 2,
	 2006
Date: Wed, 4 Oct 2006 10:25:42 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> 1) fix for packets intended for ipsec tunnels to not be clear text.
> Venkat indicated he had his own way he wanted to solve this problem on
> Monday but I did not see any updates today.  This is a major problem
> which must get fixed somehow, soon.

The patch I posted last night should take of this to a large extent (99%).
At least for policy sake (the patch affects policy), we could start with
that patch. James' patch is about propagating errors other than EACCES
(very very rare), and this could IMO go between beta2 and GA, since it
doesn't affect policy.

> 2) ipsec configuration auditing.  if we can do this in policy all the
> better.  if not, I need a patch.

I see Joy is working on this.

> 3) fix for netlabel caching race which can cause an opps.  
> Can be worked
> around by using a sysctl (see the e-mail from paul moore)
> 4) fix for netlabel correctness in the same e-mail from paul he
> mentioned correctness issues in -v3 inside selinux-ip-postroute-last
> 
> Testing with compat-net is not going to help us.  At this time I don't
> believe that RHEL5 is going to ship with compat-net set (at least I
> don't plan to right now)

Thanks for pointing out. Everyone should test with compat_net off (0)
meaning they would be using secmark/flow-control.

> 
> Non-kernel code issues which must be resolved/explained
> 1) I also haven't heard any response to method's inquiry about the
> meaning of some unlabeled_t denials namely
> 
> audit(1159877238.937:35): avc:  denied  { polmatch } for  
> scontext=system_u:object_r:unlabeled_t:s0 
> tcontext=root:system_r:unconfined_t:s0-s0:c0.c255 tclass=association

The patch I posted last night should take care of this as well.

> 
> 2) policy must be updated to include flow_in and flow_out for
> unlabeled_t packets.  dwalsh made a policy to at least define these
> which I may put on my people page in a bit.  Doesn't fix the denials,
> but at least you can fix them yourself in modules.  Venkat 
> has promised
> a policy patch to fix these issues.  I certainly hope that 
> will be soon.

The sample policy I posted last night might be of some help here.

> 3) policy must be updated to understand that by default traffic on the
> loopback interface is going to be labeled and not unlabeled_t any more
> (avahi_t I'm seeing hitting this)
> 
> Also we have at least 2 cleanups that need to be done to the labeled
> networking code.
> 
> 1) Patch 7/9 from the reconciliation thread should be cleaned up to
> better use BUG_ON()
> 2) Patch 2/9 should drop polsec from the hook interface in 
> security_ops

These minor things as well as any optimizations can again go in between
beta2 and GA.

> 
> I think this is a pretty good outline of where we are, what is broken,
> what is backported in my RHEL5 based kernel, and what needs to be
> answered/cleaned up for the future.  If I missed something, if you see
> something else wrong, if there is anything you can do to 
> address any of
> these point please don't hesitate to send an e-mail.
> 
> -Eric
> 
> --
> redhat-lspp mailing list
> redhat-lspp@redhat.com
> https://www.redhat.com/mailman/listinfo/redhat-lspp
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
