Subject: Re: Q on nonuniform "recvfrom" avc message
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200307081224.41939.wlsel@verizon.net>
References: <200307081224.41939.wlsel@verizon.net>
Content-Type: text/plain
Message-Id: <1057687509.12912.100.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Jul 2003 14:05:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-08 at 12:24, Bill Laut wrote:
> Sporadically, I'm seeing an AVC message which suggests that kjournald is 
> trying to receive the packet.  Below is a snippet from my syslog:

> Jul  8 01:57:26 vortex kernel: avc:  denied  { recvfrom } for  pid=11
>    comm=kjournald saddr=209.244.127.6 source=17664 daddr=4.46.245.145 dest=339
>    netif=eth1 scontext=system_u:system_r:initrc_t
>    tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket
> 
> Why is SELinux reporting that kjournald is trying to receive this packet?  Is 
> it because the violation occured in the kernel while kjournald happened to be 
> the currently executing process?  Or is SELinux telling me that there's a 
> possible Trojan/BO/whatever buried inside of kjournald?

The former.   The avc_audit code simply tests current and current->pid
and includes the corresponding process information in the audit message
if they are non-zero.  Not useful in the case of 'recvfrom' or other
checks performed on network input processing.

> So far, this has occured in only two processes:  kjournald and klogd.  That's 
> what sent my antennae up.
> 
> Finally, what is the "source=" and "dest=" reporting?  Are they supposed to be 
> the source/destination port numbers?  It appears that there might be an error 
> as the dest= number appears to be the packet length.

Yes, they are supposed to be the port numbers.  In this case, they would
be extracted by avc_audit from skb->h.uh->source and skb->h.uh->dest. 
Not sure about the discrepancy that you are seeing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
