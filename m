Date: Wed, 27 May 2009 23:36:41 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Paul Moore <paul.moore@hp.com>, Nigel Rumens <wooky@btconnect.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: selinux and sctp
In-Reply-To: <1243426325.19066.30.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0905272336140.24757@tundra.namei.org>
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com>  <200905261832.44705.paul.moore@hp.com> <1243426325.19066.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 May 2009, Stephen Smalley wrote:

> - Need to define a sctp_socket class in the policy and kernel (presently
> they get mapped to rawip_socket).
> - Need to extend the node_bind/name_bind checking to handle multiple
> address binding for SCTP.
> - Need to extend the name_connect checking to support SCTP.
> - Need to add getpeersec support (also missing for DCCP).
> - Need to extend selinux_parse_skb* to handle it.
> - Need to update libsepol/libsemanage, checkpolicy, and semanage to
> support it.

Added to the todo list 
http://selinuxproject.org/page/Kernel_Development#To_Do_List

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
