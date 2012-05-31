Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4VKgXYg010131
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 16:42:33 -0400
Received: by ggnv5 with SMTP id v5so1288745ggn.12
        for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 13:42:31 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jason Axelson <jaxelson@referentia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Show SELinux packet type of packets
Date: Thu, 31 May 2012 16:42:25 -0400
Message-ID: <1389562.sH0KvzMidg@sifl>
In-Reply-To: <CAC9ii1qOMdKu7s30QZnb7hSQ6ERaFXqbCOHG2-bC4ZELeWjNuA@mail.gmail.com>
References: <CAC9ii1oKMKNq5PA1oGLQYSx==s6R4wQ+HEVPu4wb5k9BNAsJaw@mail.gmail.com> <2272243.EJSO74OdnR@sifl> <CAC9ii1qOMdKu7s30QZnb7hSQ6ERaFXqbCOHG2-bC4ZELeWjNuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, May 31, 2012 10:30:24 AM Jason Axelson wrote:
> Hi Paul,
> 
> Thanks for the information. Since I'm not using labeled IPsec or CIPSO
> I've resorted to just removing access to the packet type in the policy
> to check that those packets have the label I expect based on the
> generated AVC log. So is it theoretically possible to add secmark
> support to tcpdump? It sounds like it might require a change in the
> kernel.

Unfortunately, because secmark labels do not exist in the packet itself, it is 
impossible to add secmark support to tcpdump or any other packet sniffer for 
that matter.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
