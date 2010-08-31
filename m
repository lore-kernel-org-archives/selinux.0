Subject: Re: selinux vs devtmpfs (vs udev)
From: Eric Paris <eparis@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Harald Hoyer <harald@redhat.com>, Kay Sievers <kay.sievers@vrfy.org>,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, greg@kroah.com,
        sds@tycho.nsa.gov
In-Reply-To: <4C7D1E1B.4020700@redhat.com>
References: <1282950052.3284.110.camel@dhcp231-106.rdu.redhat.com>
	 <AANLkTi=aEdKM_hunJmPzXxPqkrbok+_C6QUKf8v=Q+18@mail.gmail.com>
	 <1283210070.3284.139.camel@dhcp231-106.rdu.redhat.com>
	 <4C7CC107.1050304@redhat.com> <4C7D0DAD.9030505@redhat.com>
	 <4C7D141A.9060102@redhat.com>  <4C7D1868.3090701@redhat.com>
	 <1283267765.3284.150.camel@dhcp231-106.rdu.redhat.com>
	 <4C7D1E1B.4020700@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 11:26:07 -0400
Message-ID: <1283268367.3284.154.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-31 at 11:22 -0400, Daniel J Walsh wrote:
> On 08/31/2010 11:16 AM, Eric Paris wrote:

> > I suggest a third options: Calculate the default at startup and on every
> > policy load and fix object labels if they are the default.  I'm sure Dan
> > knows a code example of how to do the calculation.  The pseudocode looks
> > something like:
> 
> 
> > 
> > lookup the label on /dev
> > lookup the label on the initial task
> > ask the kernel what the resulting label on a file transition with those
> > two pieces of information will be.
> 
> 
> NOOOOO
> 
> libvirt is going in and changing fixed_disk_device_t:s0 to svirt_t:c0,c124
> 
> We do not want udev to see this and ask what label a device should have
> if libvirtd_t created a chr_file in device_t.

initial task == /sbin/init

actually I should look if the kernel init_cred (what devtmpfs uses to
make security decisions) is initrc_t or kernel_t.  I'm guessing it is
kernel_t but I'm not certain how that gets set.....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
