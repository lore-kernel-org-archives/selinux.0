Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBAMLpcL019976
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2012 17:22:00 -0500
From: Paul Moore <pmoore@redhat.com>
To: Eric Paris <eparis@parisplace.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>, jasowang@redhat.com
Subject: Re: [RFC PATCH v2 3/3] tun: fix LSM/SELinux labeling of tun/tap devices
Date: Mon, 10 Dec 2012 17:21:44 -0500
Message-ID: <2030873.8I84M3f4cr@sifl>
In-Reply-To: <CACLa4pu6UCpzKfscVoEPzLySHitta1yTqPa7cA0d=xUj5ws6HA@mail.gmail.com>
References: <20121205202144.18626.61966.stgit@localhost> <20121210175035.GA31856@redhat.com> <CACLa4pu6UCpzKfscVoEPzLySHitta1yTqPa7cA0d=xUj5ws6HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, December 10, 2012 01:42:12 PM Eric Paris wrote:
> Let me abstract a little here Paul.  Lets say user A starts an
> unclassified process and a top secret process.  SELinux policy darn
> well better be able to enforce that they can not attach to the same
> tun.
> 
> Am I missing something here?

Relax, all the SELinux enforced separation still exists, and works.  We're 
just fixing the LSM/SELinux stuff that was broken with the multiqueue addition 
and adding a new SELinux permission to control access to the new queue 
command.

What we are currently discussing is DAC only.  While Michael have different 
opinions on how to solve the DAC issues, we agree that SELinux works 
correctly.

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
