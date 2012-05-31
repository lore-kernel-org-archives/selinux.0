Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4VKUvue009512
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 16:30:57 -0400
Received: by pbbro8 with SMTP id ro8so1923414pbb.25
        for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 13:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2272243.EJSO74OdnR@sifl>
References: <CAC9ii1oKMKNq5PA1oGLQYSx==s6R4wQ+HEVPu4wb5k9BNAsJaw@mail.gmail.com>
 <2272243.EJSO74OdnR@sifl>
From: Jason Axelson <jaxelson@referentia.com>
Date: Thu, 31 May 2012 10:30:24 -1000
Message-ID: <CAC9ii1qOMdKu7s30QZnb7hSQ6ERaFXqbCOHG2-bC4ZELeWjNuA@mail.gmail.com>
Subject: Re: Show SELinux packet type of packets
To: Paul Moore <paul@paul-moore.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

Thanks for the information. Since I'm not using labeled IPsec or CIPSO
I've resorted to just removing access to the packet type in the policy
to check that those packets have the label I expect based on the
generated AVC log. So is it theoretically possible to add secmark
support to tcpdump? It sounds like it might require a change in the
kernel.

Jason

On Tue, May 29, 2012 at 10:11 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Thursday, May 24, 2012 04:24:25 PM Jason Axelson wrote:
>> Hi,
>>
>> Is there a way to show the SELinux packet types of all packets?
>> Ideally tcpdump would have an SELinux specific option that would print
>> out the SELinux context of each packet but that seems to be missing.
>> Are there any workarounds?
>>
>> Note: this is with SECMARK labeling (such as
>> http://james-morris.livejournal.com/11010.html)
>
> Since secmark labels do not exist in the packets themselves, they are not
> visible via tcpdump or any other packet sniffer.  To the best of my knowledge
> there isn't a tool which will allow you to view local secmark labels.
>
> If you are using labeled IPsec you could use tcpdump to determine the ESP
> and/or AH SPI and then use that to lookup the SA's SELinux label.
>
> If you are using NetLabel/CIPSO then the label is part of the IP header and is
> visible using tcpdump.  Modern versions of wireshark understands how to parse
> the CIPSO label and displays it a more human readable format.
>
> --
> paul moore
> www.paul-moore.com
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
