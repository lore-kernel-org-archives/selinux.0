Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n76IcKP4005041
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 14:38:20 -0400
Received: from e38.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n76IdKkH010581
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 18:39:21 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n76IYkAZ010936
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 12:34:46 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n76Ic5Tl182576
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 12:38:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n76Ic4aF025947
	for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2009 12:38:04 -0600
Date: Thu, 6 Aug 2009 13:38:05 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: eparis@redhat.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 1/2] lsm: Add hooks to the TUN driver
Message-ID: <20090806183805.GB4280@us.ibm.com>
References: <20090804211304.10798.65601.stgit@flek.lan> <200908061024.54786.paul.moore@hp.com> <20090806155257.GA32427@us.ibm.com> <200908061225.47404.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200908061225.47404.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Paul Moore (paul.moore@hp.com):
> On Thursday 06 August 2009 11:52:58 am Serge E. Hallyn wrote:
> > Quoting Paul Moore (paul.moore@hp.com):
> > > BTW, the main reason for posting the patches in such an early state was
> > > to solicit feedback on the location and types of hooks added; I've read
> > > lots of good feedback but nothing regarding the fundamental aspects of
> > > the hooks ... any comments before I push out v2?
> >
> > Oh now that you mention it, yes - I think the security_tun_dev_attach()
> > should be called again separately after the post_create() hook.
> 
> Why?  Granted the TUN driver calls tun_attach() in both cases but that doesn't 
> necessarily mean the operation from a security point of view is the same.  
> Using the SELinux hooks as an example, attaching to an existing TUN device is 
> currently treated as a relabel operation; the calling task relabels the 
> persistent TUN device to match its own label so that traffic sent over the TUN 
> device is labeled using the newly attached calling task's label.  Creating a 
> new TUN device is like creating any other object (yes, there are exceptions to 
> this but I'm speaking generally here), it inherits the label of the task which 
> creates it, performing access control for a relabel operation here just 
> doesn't make sense.
> 
> Or are you expecting some other form of access control for the attach hook 
> which would change this argument?

You're right, since there is no way to create without attaching that doesn't
make sense, regardless of the LSM or policy :)  Nm.

> > As for more general comments on whether or which tuntap-specific hooks
> > need to exist, two things.  First, if you have specific requirements
> > in mind please do share those, otherwise I'm working based on what I
> > see in Documentation/networking/tuntap.txt and drivers/net/tun.c.
> 
> Not that haven't already been mentioned.  If something doesn't make sense, let 
> me know.
> 
> > Second, based on my understanding i think the hooks you have make sense,
> > but is there any way to relabel a tun socket?  Since they are always labeled
> > with current_sid(), that seems restrictive... 
> 
> Not at present, the TUN driver only supports changing the user/group IDs.  I 
> am debating adding support to change/view the label of the device/socket 
> (TUN{SET,GET}SECCTX perhaps?) but that can happen later and is in no way 
> prevented by these patches.  My thinking is that these patches are a 
> requirement for us to apply the existing LSM network access controls to 
> traffic originating from the TUN driver; depending on how use cases evolve 
> with the TUN driver we may want to add additional functionality but this 
> should serve as a good base.
> 
> > I see that you don't want to use sockcreate_sid, but (to use a made-up
> > example not reflecting reality) a kvm_setup_t task couldn't create a tun
> > sock for a kvm_run_t task to use, right?
> 
> Well, the only time this will really be an issue is when you have one task 
> create a new, persistent TUN device and a second task that attaches to the 
> existing TUN device and uses it to send traffic.  Sticking with your example, 
> if the first task is labeled kvm_setup_t and the second task is labeled 
> kvm_run_t then the policy would look something like this:
> 
> 	# allow kvm_setup_t to create a new TUN device
> 	allow kvm_setup_t self:tun_socket { create };
> 
> 	# allow kvm_run_t to use TUN devices created by kvm_setup_t
> 	allow kvm_run_t kvm_setup_t:tun_socket { relabelfrom };
> 	allow kvm_run_t self:tun_socket { relabelto };
> 
> The policy above has the nice effect of only allowing kvm_run_t to attach to 
> existing TUN devices created by kvm_setup_t; it can not create a new TUN 
> device or use persistent TUN devices created by other domains.  This should 
> also help explain why I think calling the attach() hook after the 
> post_create() hook makes little sense given the access controls currently 
> proposed.

And really allowing flexibility in the default label can always be done
without affecting the tun code so never mind.

So I think your hooks make sense as is, given the TUN usage model described
in the docs.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
