Message-ID: <44A152A6.3060809@trustedcs.com>
Date: Tue, 27 Jun 2006 10:45:42 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: paul.moore@hp.com
CC: jmorris@namei.org, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        davem@davemloft.net, sds@tycho.nsa.gov, eparis@redhat.com
Subject: Re: Labeled Networking Requirements and Design (formerly RE: [PATCH
 01/06] MLSXFRM: Granular IPSec associations for use in  MLS environments)
References: <44A0684D.9080904@trustedcs.com>
In-Reply-To: <44A0684D.9080904@trustedcs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Keeping in mind (R1a), I wonder if it makes more sense for (OTBND1a) to take 
> the label of the process/domain which sends the data to the socket? After 
> all, the process/domain is the "origin" of the data.

Right. This is what "ends up" happening in the non-privileged case. In the
privileged multi-level process case, the label of the data has in fact been
established at the socket creation time itself, and here we are trusting the
privileged multi-level process with sending data out on the right socket with
the knowledge that the data would be labeled with the label of the socket.

>  This seems to be 
> particularly important in the case of fork()-then-exec() where you could have 
> a socket created at a different context from the domain currently writing to 
> it.

It would also help to remember that there are additional process-to-socket
controls (sendmsg, recvmsg) already in place in SELinux.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
