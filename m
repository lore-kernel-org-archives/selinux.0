Message-ID: <51B5E4A0.8080408@tycho.nsa.gov>
Date: Mon, 10 Jun 2013 10:37:20 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Franck <franck.quinard@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: use case
References: <CAHhDTVmA_3SgoLw-ntFaKGC9m9KxrTCbNFyVQ9dy-CtkpjyvjQ@mail.gmail.com>
In-Reply-To: <CAHhDTVmA_3SgoLw-ntFaKGC9m9KxrTCbNFyVQ9dy-CtkpjyvjQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/10/2013 10:15 AM, Franck wrote:
> Hello,
>
> I'm trying to see if the following scenario is something that can be deal
> with selinux.
>
> I have a daemon that start multiple identical processes ( let's call them
> "agent", and let's say we have 2 of them, but we could as well have 256).
> Those processes are there so remote client can start other processes. I
> want those processes to be able to read from one location (the binaries of
> what they are running) but also to read/write in some specific directories.
> Of course, agent A and agent B should not be able to interact between each
> other directly (they could using some tcp/http protocol) or read/write
> files that are not theirs.
>
> I was thinking of transiting from the agent domain to the client
> application domain using a transient domain that would be automatically
> generated and unique, but did not see anything like that.

You could assign a unique category set to each client application rather 
than changing domains; that would allow you to separate them from each 
other without having to define a unique domain for each of them.  A 
similar approach has been used in various systems, e.g. the SELinux 
sandbox, SVirt (libvirt), SE for Android, OpenShift.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
