Subject: Re: How SELinux label packet by default?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050118061124.94277.qmail@web51506.mail.yahoo.com>
References: <20050118061124.94277.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1106061955.18274.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Jan 2005 10:25:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-18 at 01:11, Park Lee wrote:
> Hi,
>   In initial_sid_contexts, there seems no default
> packet SID. Then, 
>   (here, let's don't take IPsec protection into
> account)
>   1) When a packet is sending or receiving, Does
> SELinux label the packet and then control the
> sending/receiving packet according to the label? or
> just ignore it?
>   2) When an unlabeled packet is received from a node,
> What default packet SID will SELinux set to the packet
> ? 
>   Is it still be as "When a message is sent on a
> socket, it inherits the SID of the sending socket by
> default. When the network component receives a message
> from the network, the SID of the message is initially
> set to a default message SID associated with the
> receiving network interface." as is described in
> subsection 8.1.1 of "Integrating Flexible Support for
> Security Policies into the Linux Operating System"

As I've explained previously, the security fields and hooks needed to
label and control sk_buff's (i.e. messages) were not accepted into
mainline Linux 2.6, so that code was dropped out of SELinux.  SELinux
network access control checks were redesigned by James Morris in 2.6.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
