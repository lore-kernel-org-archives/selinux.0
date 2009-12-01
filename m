Subject: Re: [PATCH] Dynamic port labeling V2
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200912020450.28965.russell@coker.com.au>
References: <1259616460.2444.9.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4B14A111.2000703@schaufler-ca.com>
	 <1259679974.2365.29.camel@moss-terrapins.epoch.ncsc.mil>
	 <200912020450.28965.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 01 Dec 2009 18:03:53 -0500
Message-Id: <1259708633.8497.18.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-12-02 at 04:50 +1100, Russell Coker wrote:
> On Wed, 2 Dec 2009, "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> > 1) Where is it located?
> > 2) Is your proposal to implement it as a new fs with a name something
> > like portfs?
> 
> If it's going to be generic to all LSM modules then we can't 
> use /selinux/ports.  So I guess another filesystem is required.

Well we could, but you'd just have an /selinux/ports directory that's
empty and mount portfs over /selinux/ports. There are examples of this
but you may want a /ports mount point if its going to handle the DAC
part of port permissions as well.

> 
> > 3) How does it get populated initially? Do you have a file for each port
> > right off the bat? Do you only have files for ports with policy or whose
> > permissions differ from the default?
> 
> It seems to me that the majority of ports will not have discrete labels.  So 
> out of the 65535 ports it would probably be uncommon to have more than 200 
> labels.
> 
> Some aspects of the programming will be easier if we have one file per port.  
> But then changing the default label would require writing to more than 60,000 
> files in the common cases.

I can't say that I find this behavior desirable. What I find even less
desirable is the race conditions created by this. We would want a stack
or port labels which as each got removed you would fall back to the one
applied before that. Now if you want to programatically find out what
labels are on the file and insert a label into this list you would need
to read the contents of lets say /port/80 modify it and then write back
to /port/80. If this has changed in the mean time you're potentially
putting back a label that should have been removed. Since you're using a
filesystem interface you can't really do a push/pop/insert interface
using filesystem syscalls alone.

Additionally another huge problem is port ranges. If I want to label
30000-35000 as mytype_t I now need to iterate over 5k files opening each
writing the label and closing them. 

> 
> One possibility would be to have a default label for any port that doesn't 
> have a specific label.  We could have a file per port that has a specific 
> label (probably not much more than 1024 entries on typical systems) and then 
> have a default label for the rest.
> 

This would be similar to what I did for the sysfs labeling where the
incore dentry only has a security label when it is different from the
default. The issue I see is that there is no equivalent to a genfscon
statement for ports. This causes a problem with setting a default label
because I don't believe there is currently a construct to do this. There
are portcon statements in policy but there isn't a way to indicate a
default for everything in a way that would allow you to differentiate a
default from just something that came first.

> Setting the port to the default label would be a matter of either unlinking 
> the file which has the specific label or writing "".
> 
> > 4) How do I assign a label to the port? You have an issue here that
> > these files are objects themselves. You can't just label the file with
> > what you want the port labeled because now you can't mediate access to
> > these file objects outside of the label on the port itself.
> 
> The files would have to have the labels as their contents.  The advantage of 
> this is that the permissions needed to set the labels would be independent of 
> what the labels are.
> 

Like I mentioned above the race conditions introduced by this make this
less than ideal.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
