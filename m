Date: Fri, 5 Dec 2003 09:21:26 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Karl MacMillan <kmacmillan@tresys.com>
cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: RFC Kernel interface to conditional policy
In-Reply-To: <Xine.LNX.4.44.0312041549140.1571-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0312050918490.4181-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Dec 2003, James Morris wrote:

> On Thu, 4 Dec 2003, Karl MacMillan wrote:
> 
> > Netlink messaging won't give us the fine-grained labeling, correct?
> 
> Not as-is.

To clarify, increasing the granularity of Netlink access is something that
would be done within SELinux (i.e. the Netlink code would not need to be 
modified).  It may be generally useful in any case as a fine grained 
user-kernel communication channel.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
