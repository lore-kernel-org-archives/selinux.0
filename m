Subject: Re: [PATCH 1/4 -v2] Namespacing of security/selinux
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Thomas Liu <tliu@redhat.com>,
        selinux@tycho.nsa.gov, eparis@parisplace.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <alpine.LRH.2.00.0907072247380.15675@tundra.namei.org>
References: <1246906718.2460.12.camel@Ares>
	 <1246909386.28321.148.camel@moss-pluto.epoch.ncsc.mil>
	 <1246968394.28321.171.camel@moss-pluto.epoch.ncsc.mil>
	 <alpine.LRH.2.00.0907072247380.15675@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 13:47:21 -0400
Message-Id: <1246988841.2866.125.camel@dhcp235-23.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-07 at 22:48 +1000, James Morris wrote:
> On Tue, 7 Jul 2009, Stephen Smalley wrote:
> 
> > 1)  Create one patch that only renames security_ functions within
> > selinux to sel_ or selinux_ (I don't care which; Paul seemed to prefer
> > sel_ - James or Eric?).  That should be non-controversial and easy to
> > merge.
> 
> sel_ gets the point across :-)

Obviously I preferred selinux_ since I'm the one who ask him to do it.
Anyway, I guess James and Paul both like sel_ and I'm not going to argue
loud enough to matter...

I also don't care about the 80 character limit and told him not to worry
too much about it.  I know it's a coding style rule, and I know long
lines are problematic, but if any one of us who actually maintains this
code can't handle 81 characters I'll buy you a wonderful mid 90's
monitor and video card.  Don't program on an OLPC.  If it fits on my 12"
ultra portable, I'm happy with the code.  I do accept there need to be
reasonable limits, I jotted down that cond_read_av_list and read_f both
were too long to live....

Thomas, I'd suggest just doing the minimum that sds suggested.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
