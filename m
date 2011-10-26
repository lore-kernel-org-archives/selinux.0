Subject: Re: Where does linux kernel call initial policy load
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAOdLEarjJg4Gs9ZJbWfE68XkFTYh6veOcdr=ToSVZe-97F0b1Q@mail.gmail.com>
References: 
	 <CAOdLEarjJg4Gs9ZJbWfE68XkFTYh6veOcdr=ToSVZe-97F0b1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Oct 2011 13:18:42 -0400
Message-ID: <1319649522.11381.6.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-10-26 at 10:11 -0700, Sam Gandhi wrote:
> Hi,
> 
> I am not an expert in kernel source navigation. Anybody want to give
> me clues as to where  does linux kernel load initial policy at
> startup, even before the rcS scripts get started?
> 
> It looks like if  I have /etc/selinux/config file that says config is
> as shown below
> 
> SELINUX=permissive
> SELINUXTYPE=mypolicy
> 
> 
> It looks like linux kernel is loading file
> /etc/selinux/mypolicy/policy.24 I want to find out how that is getting
> invoked. I see that it looks like it is triggered by write to selinux
> sysfs entry /selinux/load but I want to find out where in the kernel
> code is that write to /sexlinux/load generated?

Policy load is initiated by early userspace, not by the kernel.
Typically by /sbin/init or from the initramfs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
