From: Paul Moore <paul.moore@hp.com>
To: Jason Shaw <js44352@gmail.com>
Subject: Re: Assigning a Type to Network Interfaces
Date: Mon, 1 Feb 2010 14:53:57 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@lists.fedoraproject.org,
        selinux@tycho.nsa.gov
References: <c63e41181001140608u37e57495s15bd7c7d2f50a0e3@mail.gmail.com> <201001191754.52088.paul.moore@hp.com> <c63e41181002010944v23df202ft127bcc4e3eeaa172@mail.gmail.com>
In-Reply-To: <c63e41181002010944v23df202ft127bcc4e3eeaa172@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201002011453.57654.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 01 February 2010 12:44:56 pm Jason Shaw wrote:
> Here is what I found. Using netlabelctl, I could successfully restrict all
> inbound/outbound network access to the system on a specific interface. I
> could then permit only SSH into the system via allow rules associated with
> the peer label assigned using netlabelctl unlbl.That worked great. In fact,
> I'm really excited to explore other possibilities using netlabelctl as it
> has many valuable possible uses.

Great, glad to hear you got everything (well, almost) working; I apologize it 
took so long :)

> However, I found that my test app (with the allow rule below), could still
> read and display packet data coming in on any interface even with all
> interfaces assigned a unique peer_t using netlabelctl unlbl add. This was
> true when no explicit allow rules were added for the test app (running in
> myAPP_t). So while netlabelctl did require explicit allow rules for SSH to
> send/receive data (I beleive for sshd_t), an allow rule was not required to
> read raw data off of the interface for myAPP_t.
> 
> allow myApp_t self:packet_socket { create read bind ioctl };
> 
> My understanding is that a packet socket is read at the device driver
>  level. As such, is it possible that the packet socket is being read before
>  netlabelctl enforcements are taking place?

Hmm, yes, I think you've stumbled across a bug in the kernel where the LSM 
sock_rcv_skb() hook is not called for AF_PACKET.  I need to take a look and 
verify the rest of the packet families and work up a fix.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
