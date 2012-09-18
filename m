Message-ID: <5058B22B.2020301@tresys.com>
Date: Tue, 18 Sep 2012 13:40:59 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, William Roberts <bill.c.roberts@gmail.com>,
        Joman
 Chu <jcchu@tycho.ncsc.mil>
Subject: Re: seandroid and policy version
References: <4FFCC3C7.8080602@tresys.com>  <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>  <4FFDD7C7.4020703@tresys.com>  <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil> <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley wrote:
<snip>
> So this issue has come up again in the context of implementing device
> admin APIs and a sample device admin app.  The device admin API
> implementation in the system_server needs to know how to name the file
> it creates under /data/system for the kernel policy, but it has no way
> to determine the actual policy version of the supplied policy.  So it
> doesn't know what suffix to use.  Options:
> - Get rid of the version suffix altogether, or at least for the sepolicy
> file under /data/system.
> - Have the system_server parse the header of the policy image to
> determine the policy version, and use that as the suffix.
>
> Thoughts?
>

Can the MDM server not provide the device admin API with the correct 
filename to use? How are you feeding the policy to the API?

I'm a fan of dropping the extension altogether but I'm just trying to 
understand the issue. I'd hope that the system_server wouldn't directly 
try to parse the image, hopefully at least a library would be used.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
