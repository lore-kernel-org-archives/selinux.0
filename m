Subject: Re: RFC Kernel interface to conditional policy
From: Karl MacMillan <kmacmillan@tresys.com>
To: James Morris <jmorris@redhat.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0312050918490.4181-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0312050918490.4181-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1070651668.31745.6.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 05 Dec 2003 14:14:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-05 at 09:21, James Morris wrote:
> On Thu, 4 Dec 2003, James Morris wrote:
> 
> > On Thu, 4 Dec 2003, Karl MacMillan wrote:
> > 
> > > Netlink messaging won't give us the fine-grained labeling, correct?
> > 
> > Not as-is.
> 
> To clarify, increasing the granularity of Netlink access is something that
> would be done within SELinux (i.e. the Netlink code would not need to be 
> modified).  It may be generally useful in any case as a fine grained 
> user-kernel communication channel.
> 

I'll keep this as an option, but I think that it would be better for us
to keep going with selinuxfs. It is nice to have an interface that
doesn't require extra tools and I think that there is a better chance of
completing the project in the limited time we have left.

Karl

> 
> - James
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
