Message-ID: <1347626486.11029.8.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: system without libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 14 Sep 2012 08:41:26 -0400
In-Reply-To: <20120913164556.00d45eb3@redhat.com>
References: <20120913164556.00d45eb3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-13 at 16:45 -0400, Eric Paris wrote:
> Is it reasonable to expect a system without libsepol to be able to load
> policy?  I know the code can do it right now, but does anyone do it?
> I'd like to remove and try to rework some of that code so it is cleaner
> and more obvious.  Anyone see a problem with requiring libspol be
> installed if libselinux was build with shared library expectations?

SE Android doesn't have libsepol on the device at all (primarily because
of licensing).  We only build it for the build host and use it to
compile the policy for the device.  However, we also have our own custom
policy loading logic for SE Android due to other differences, so it
likely doesn't matter what you do to the upstream libselinux logic.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
