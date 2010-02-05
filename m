From: Paul Moore <paul.moore@hp.com>
To: Jason Shaw <js44352@gmail.com>
Subject: Re: Assigning a Type to Network Interfaces
Date: Fri, 5 Feb 2010 17:07:12 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@lists.fedoraproject.org,
        selinux@tycho.nsa.gov
References: <c63e41181001140608u37e57495s15bd7c7d2f50a0e3@mail.gmail.com> <c63e41181002010944v23df202ft127bcc4e3eeaa172@mail.gmail.com> <201002011453.57654.paul.moore@hp.com>
In-Reply-To: <201002011453.57654.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002051707.13090.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 01 February 2010 02:53:57 pm Paul Moore wrote:
> On Monday 01 February 2010 12:44:56 pm Jason Shaw wrote:
> > However, I found that my test app (with the allow rule below), could
> > still read and display packet data coming in on any interface even with
> > all interfaces assigned a unique peer_t using netlabelctl unlbl add. 
This
> > was true when no explicit allow rules were added for the test app
> > (running in myAPP_t). So while netlabelctl did require explicit allow
> > rules for SSH to send/receive data (I beleive for sshd_t), an allow rule
> > was not required to read raw data off of the interface for myAPP_t.
> >
> > allow myApp_t self:packet_socket { create read bind ioctl };
> >
> > My understanding is that a packet socket is read at the device driver
> >  level. As such, is it possible that the packet socket is being read
> > before netlabelctl enforcements are taking place?
> 
> Hmm, yes, I think you've stumbled across a bug in the kernel where the LSM
> sock_rcv_skb() hook is not called for AF_PACKET.  I need to take a look 
and
> verify the rest of the packet families and work up a fix.

A quick follow up on this: after some thought and discussion, I don't think 
there is anything practical solution to the lack of per-packet receive 
controls for sockets with address families other than AF_INET and AF_INET6.  
The problem lies in the fact that we need to parse the IP headers, and 
sometimes even perform the necessary IPsec processing, to determine the 
packet's peer label; if the packet is arriving on a AF_INET[6] socket this 
work is done for us by the kernel's normal network stack processing prior to 
SELinux enforcing the receive side per-packet access controls, for all other 
address families this work is not done which means SELinux would have to 
implement its own packet processing.  Needless to say this is not a very 
practical solution and would almost certainly be rejected from the mainline 
kernel.

However, if we step back and think about this for a minute, I don't believe 
this is a major shortcoming.  Packet sockets, by their very nature, are 
fairly dangerous from a network security point of view since you are 
essentially providing applications direct access to the network.  Sure, 
there are cases where this is useful, but mostly from an administrative or 
diagnostic point of view, I struggle to find a reason where a "normal" user 
would need access to a packet socket.  My recommendation is to restrict 
which domains can create and use a packet socket to only those domains which 
are carefully restricted and not worry about the per-packet access controls.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
