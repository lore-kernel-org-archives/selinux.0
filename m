From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197408847.28006.184.camel@moss-spartans.epoch.ncsc.mil>
References: <1197408847.28006.184.camel@moss-spartans.epoch.ncsc.mil> <1197401823.28006.74.camel@moss-spartans.epoch.ncsc.mil> <1197322068.18120.176.camel@moss-spartans.epoch.ncsc.mil> <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil> <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk> <25037.1197306473@redhat.com> <25572.1197320887@redhat.com> <25965.1197329769@redhat.com> <9789.1197405725@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Karl MacMillan <kmacmill@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Tue, 11 Dec 2007 22:43:00 +0000
Message-ID: <12117.1197412980@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> All your code has to do is invoke a function provided by libselinux.

Calling libselinux means it's a special case for a specific LSM.

I think the best way to do this, then, has to be to dlopen the appropriate LSM
library.  That way I don't need to do any conditional compilation or linking,
but can build all the bits in to cachefilesd and have the appropriate one
selected by the /etc/cachefilesd.conf.

So, what do I invoke in libselinux, how do I configure it, and how do I
integrate the config into my RPM and install it?

And then what does it give me that I can hand to the kernel (a context string
for SELinux, I presume), how do I get the kernel to make a check on it, how do
I configure the check and how do I install that config from my RPM (I presume
I just need to modify the .fc, .if and .te files that I have already)?

> That mostly works, but it means that an update to policy may require an
> update to /etc/cachefilesd.conf, or that switching from one policy to
> another might likewise require changing that file.  Versus using a
> separate policy-provided config file for the label.

Whilst that's a fair point, if it's in a config file somewhere, then someone
may want to change it or someone may want to provide a second file for a
second cache with a different security label.

> BTW, as should be obvious, some LSMs aren't label-based at all, so it
> would need to be optional.

Aargh.  In which case it might not be possible to make the SELinux context
passing from userspace -> kernel generic for all LSMs:-(

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
