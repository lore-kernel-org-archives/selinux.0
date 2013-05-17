From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: connection between different labels
Date: Fri, 17 May 2013 10:07:14 -0400
Message-ID: <1542214.p1uj7fpFHc@sifl>
In-Reply-To: <CAHw9pMX-Ji6hds9_oP97NEMzsG5MM_=jwD-mA=eGVWG-Z5jVEA@mail.gmail.com>
References: <CAHw9pMX-Ji6hds9_oP97NEMzsG5MM_=jwD-mA=eGVWG-Z5jVEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, May 17, 2013 12:58:27 AM vlad halilov wrote:
> Hi again.

Hello again.

> Is selinux contain something functional like 'multilevel port'
> from solaris trusted extension? Concept of mlp is declaring number of
> programm to be 'label aware'. Program of this type, allowed to handling
> network request for specified service from all labels and handling/generate
> trafic for any labels in clearance. So, OS just delegate information
> control to this programm.

Yes, SELinux is capable of doing similar things.  However, I will caution you 
that SELinux does not support network port polyinstantiation in the same way 
as TSOL or Solaris TX; we have some workarounds that sorta do similar things 
but it isn't the same.

> As my mind, something like this is possible for selinux contexts (we can
> allow traffic between different domains by policy, and selinux context
> transfered by 'secret' local processing ;) but may be something like this
> implemented for information labels s0,s1 etc?
> 
> For example:
> 
> type=AVC msg=audit(1368735963.286:1998): avc:  denied  { recv } for 
> pid=4773 comm="python-thinlinc" saddr=127.0.0.1 src=46092 daddr=127.0.0.1
> dest=9000 netif=lo scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:netlabel_peer_t:s4 tclass=peer
> 
> My userspace program need to send status message to master process that
> executed with clearance s0-s15:c0.c1023  but denied with request. Hmmm..
> But clearance of master process is enough to work with this information?
> From some tests, i got result that 'real' leabel for master process is s0.
> And all processes executed with label range handling connection only with
> lowest label from range.

There are basically two parts to communicating over a network with a security 
label above your effective security label and below your cleared security 
label: initiating a new connection and sending data (e.g. creating a socket 
with the appropriate label) and accepting a new connection and receiving data 
(e.g. allowing a socket to receive data above it's effective security label 
but still below it's cleared label).

The first part, creating a socket with a different security label, can be done 
with the setsockcreatecon() function which is part of the libselinux API.  If 
successful, this function tells the kernel to label all future sockets with 
the label provided by the function.  This allows you to create sockets with a 
"s1" security label when the process is running as "s0-s15", and traffic sent 
from these "s1" labeled sockets will be labeled as "s1" and NOT as "s0".  See 
the manpage for more information.

The second part, accepting data between the effective and cleared security 
label, is done via the MLS attributes in the SELinux policy.  The 
mlsnetreadtoclr, mlsnetwritetoclr, and mlsnetwriteranged are the attributes 
you are likely the most relevant; the related SELinux policy interfaces can be 
found in the kernel/mls.if interface file and are all named 'mls_socket_*'.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
