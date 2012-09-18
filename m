Message-ID: <1347990196.31966.70.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid and policy version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, William Roberts <bill.c.roberts@gmail.com>,
        Joman
	Chu <jcchu@tycho.ncsc.mil>
Date: Tue, 18 Sep 2012 13:43:16 -0400
In-Reply-To: <5058B22B.2020301@tresys.com>
References: <4FFCC3C7.8080602@tresys.com>
	 <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFDD7C7.4020703@tresys.com>
	 <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>
	 <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
	 <5058B22B.2020301@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 13:40 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley wrote:
> <snip>
> > So this issue has come up again in the context of implementing device
> > admin APIs and a sample device admin app.  The device admin API
> > implementation in the system_server needs to know how to name the file
> > it creates under /data/system for the kernel policy, but it has no way
> > to determine the actual policy version of the supplied policy.  So it
> > doesn't know what suffix to use.  Options:
> > - Get rid of the version suffix altogether, or at least for the sepolicy
> > file under /data/system.
> > - Have the system_server parse the header of the policy image to
> > determine the policy version, and use that as the suffix.
> >
> > Thoughts?
> >
> 
> Can the MDM server not provide the device admin API with the correct 
> filename to use? How are you feeding the policy to the API?

At the moment it is being passed directly as a byte array (similar to
security_load_policy).  Passing by pathname would require that the
system_server have read/search access to a private file created by the
device admin app, and passing by open fd would require that the device
admin app first write the policy image to local storage before passing
it to the system_server.  So passing it directly seems preferable.

> I'm a fan of dropping the extension altogether but I'm just trying to 
> understand the issue. I'd hope that the system_server wouldn't directly 
> try to parse the image, hopefully at least a library would be used.

I expect we'd add a function to the Android libselinux for this purpose,
since libsepol isn't available on the device.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
