Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2H7BRkd000680
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 02:11:28 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2H7BP1O014370
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 07:11:26 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 17 Mar 2006 08:11:15 +0100
Date: Fri, 17 Mar 2006 08:11:14 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Bug in the semanage user management code or genhomedircon?
Message-Id: <20060317071114.GA7357@thorium.jmh.mhn.de>
References: <20060316204512.GB30979@hydrogenium.cip.ifi.lmu.de> <4419E07F.4090508@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4419E07F.4090508@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Ivan Gyurdiev <ivg2@cornell.edu> [2006-03-16 23:53]:
> 
> >What am I doing wrong?
> >  
> Can you let me know what you see with the following policycoreutils 
> patch, when you try the same thing (do semanage user -l, should show the 
> labeling prefix for each user).

OK, this seems to show the problem:
# semanage user -l

                Labeling   MLS/       MLS/
SELinux User    Prefix     MCS Level  MCS Range                      SELinux Roles

root            user       s0         s0-s0:c0.c255                  system_r sysadm_r staff_r
staff_u         user       s0         s0-s0:c0.c255                  sysadm_r staff_r
sysadm_u        user       s0         s0-s0:c0.c255                  sysadm_r
system_u        user       s0         s0-s0:c0.c255                  system_r
user_u          user       s0         s0                             user_r

Where is the labeling prefix set? Or better, where can I change it?

Thanks,
Thomas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
