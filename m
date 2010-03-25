Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Paul Moore <paul.moore@hp.com>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1269541078.1031.45.camel@moss-pluto.epoch.ncsc.mil>
References: <4BA7E4BF.1040002@redhat.com>
	 <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com>
	 <1269525768.1031.9.camel@moss-pluto.epoch.ncsc.mil>
	 <201003251249.48641.paul.moore@hp.com>  <4BABA4C7.2020409@redhat.com>
	 <1269541078.1031.45.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Mar 2010 15:02:10 -0400
Message-ID: <1269543730.2980.17.camel@dhcp231-113.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-25 at 14:17 -0400, Stephen Smalley wrote:

> It seems to me that it really should only get the low/current level of
> the peer, not the full range, e.g. mls_context_cpy_low(), so that we
> don't turn a connection from a ranged subject into a fully ranged
> socket?

Is that even the best, by itself?  We would still be in the same
situation except now we would have a random virtual machine

svirt_t:s3:c156

trying to read/write to a socket with the label:

svirt_t:s0:c0

since libvirtd_t is going to pretty much always be running:

libvirtd_t:s0-s15:c0-1023

If we have to go that way, do we have some sort of crazy,
copy_mls_level_subset() or other such foolishness?   *smile*

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
