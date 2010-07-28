Subject: Re: [RFC PATCH] selinux: convert the policy type_attr_map to
 flex_array
From: Eric Paris <eparis@redhat.com>
To: Joe Nall <joe@nall.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
In-Reply-To: <FFD31467-1A8E-4771-9AE7-CEB659C150EE@nall.com>
References: <20100728204842.16765.83524.stgit@paris.rdu.redhat.com>
	 <FFD31467-1A8E-4771-9AE7-CEB659C150EE@nall.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 17:13:17 -0400
Message-ID: <1280351597.2734.112.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-07-28 at 15:58 -0500, Joe Nall wrote:
> On Jul 28, 2010, at 3:48 PM, Eric Paris wrote:
> 
> > Current selinux policy can have over 3000 types.  The type_attr_map in
> > policy is an array sized by the number of types times sizeof(struct ebitmap)
> > (12 on x86_64).  Basic math tells us the array is going to be of length
> > 3000 x 12 = 36,000 bytes.  The largest 'safe' allocation on a long running
> > system is 16k.
> 
> Can you explain the 'safe' comment? Why is 16k magical?

16k is magical because I've been told it is magical by vm guys and
history has proven it so.  A big issue with long running systems is
memory fragmentation.  There was an LWN article just last week
discussing the problem and potential solution of drivers needing large
allocations for buffers well after a system has started.  At or near
system startup you are going to have lots and lots of contiguous free
memory space, but that isn't the case after a system has been doing
work.
> 
> >  Most of the time a 32k allocation will work.  But on long
> > running systems a 64k allocation (what we need) can fail quite regularly.
> 
> What defines 'long running?'

In this case it is the time and workload it took a RHEL6 box without
much ram to install every possible package.  Long running really means
'not recently rebooted and has done some real work.'  It's not well
defined and is obviously going to be workload dependent.

> I'm concerned because we are fielding systems with 5k types next month.

It's possible then that if memory gets fragmented you won't be able to
update policy without a reboot.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
