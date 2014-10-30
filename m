Message-ID: <5452702C.2000704@tycho.nsa.gov>
Date: Thu, 30 Oct 2014 13:06:52 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: peter enderborg <peter.enderborg@sonymobile.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Missing security labels for socket objects?
References: <54526941.3090208@sonymobile.com>
In-Reply-To: <54526941.3090208@sonymobile.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/30/2014 12:37 PM, peter enderborg wrote:
> Hi! Im trying to see where the access control for some socket objects
> occurs.
> And it seems not to be very detailed resolution for sockets. For some
> protocols there is NOTHING. I did a test. I created a own protocol.
> AF_PEG_IPC.
> This can be accessed without specific type definition or contexts. It
> need socket access. In my system there is about 20 different protocols.
> They are "all or nothing".
> 
> The question is how do I select which root task that can access
> AF_PEG_IPC and who can not.  In selinux root is supposed to be
> in locked container.

SELinux applies a set of general socket permission checks (e.g. create,
bind, connect, ...) for all sockets, but it can only distinguish among
types of sockets for which security classes have been defined.  All
other socket address families are lumped together into the generic
socket security class.  If you want to be able to control this
AF_PEG_IPC separately, you need to introduce a security class for it.
See this similar answer on the seandroid-list,
http://marc.info/?l=seandroid-list&m=139056956927985&w=2
