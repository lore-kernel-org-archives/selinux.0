Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8C7IxrT027422
	for <selinux@tycho.nsa.gov>; Sun, 12 Sep 2004 03:19:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8C7IuBb016454
	for <selinux@tycho.nsa.gov>; Sun, 12 Sep 2004 07:18:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy patch: some misc additions
Date: Sun, 12 Sep 2004 17:18:46 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040911133324.GA2557@jmh.mhn.de>
In-Reply-To: <20040911133324.GA2557@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409121718.46194.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Sep 2004 23:33, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> The following patch against latest CVS adds some misc policy:
>
> logrotate.te: the suse version doesn't work without this

I think that this is a bug in logrotate.  Looking at the source to figure out 
what the problem is would be a good idea.

> modutil.te: I see no reason why user_r should ever touch insmod_t

I agree.  How does it happen?

> iptables.te: added tc (traffic control) to the iptables domain

domain_auto_trans(initrc_t, iptables_exec_t, iptables_t) is already included 
in daemon_base_domain().  Does SUSE have a change to daemon_base_domain()?

In either case this does not belong in the CVS policy.

Why do you have tc labelled as iptables_exec_t?  On Debian and Fedora tc is 
working well labelled as ifconfig_exec_t.

> rpm.te: gpg doesn't want to verify signatures otherwise

I think it's best to unconditionally allow that, I've put it in my tree.

> xdm.te: needed with XFree86 4.3, kdm 3.3 and nvidia

Why would xdm_xserver_t need it but user_xserver_t not need it?  I've added it 
to macros/program/xserver_macros.te in my tree.

> types.fc: added file contexts for some kde and gnome libraries
>           (filenames are like /opt/kde3/lib/kde3/kcalc.so)
>           the nVidia libs need some extra file context, too

I added /dev/usbscanner to my tree with the distro_suse ifdef.

/opt/.*/lib/.*\.so     --      system_u:object_r:shlib_t

I'm not sure if the above line needs to have ifdef distro_suse around it.  
Comments anyone?

> gpg_agent_macros.te: permission was needed because of wrongly labeled
>                      files (see above)

OK, in my tree.

> ssh_agent_macros.te: make sure user_home_t and nfs_t behave the same;
>                      also add my name (I'm the original author of this
>                      policy)

I made a minor change to that to make it more readable and removed my name 
from the credits.

> ssh-agent.te: ssh wants to create ~/.ssh if it doesn't exist

I've put that in my tree.

The things that I've put in my tree will be in the next patches against the 
CVS that I send to the list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
