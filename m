Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4TKBngR000738
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2012 16:11:49 -0400
Received: by vcbf1 with SMTP id f1so2708837vcb.12
        for <selinux@tycho.nsa.gov>; Tue, 29 May 2012 13:11:47 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jason Axelson <jaxelson@referentia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Show SELinux packet type of packets
Date: Tue, 29 May 2012 16:11:40 -0400
Message-ID: <2272243.EJSO74OdnR@sifl>
In-Reply-To: <CAC9ii1oKMKNq5PA1oGLQYSx==s6R4wQ+HEVPu4wb5k9BNAsJaw@mail.gmail.com>
References: <CAC9ii1oKMKNq5PA1oGLQYSx==s6R4wQ+HEVPu4wb5k9BNAsJaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, May 24, 2012 04:24:25 PM Jason Axelson wrote:
> Hi,
> 
> Is there a way to show the SELinux packet types of all packets?
> Ideally tcpdump would have an SELinux specific option that would print
> out the SELinux context of each packet but that seems to be missing.
> Are there any workarounds?
> 
> Note: this is with SECMARK labeling (such as
> http://james-morris.livejournal.com/11010.html)

Since secmark labels do not exist in the packets themselves, they are not 
visible via tcpdump or any other packet sniffer.  To the best of my knowledge 
there isn't a tool which will allow you to view local secmark labels.

If you are using labeled IPsec you could use tcpdump to determine the ESP 
and/or AH SPI and then use that to lookup the SA's SELinux label.

If you are using NetLabel/CIPSO then the label is part of the IP header and is 
visible using tcpdump.  Modern versions of wireshark understands how to parse 
the CIPSO label and displays it a more human readable format.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
