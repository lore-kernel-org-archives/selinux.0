Date: Mon, 6 May 2002 07:56:11 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "McFadden, Ken" <ken.mcfadden@lmco.com>
cc: "SE Linux Distro (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Would like to load SELinux.....
In-Reply-To: <31A81CDD9175D411815100508BE32AA60142F362@emss02m13.ems.lmco.com>
Message-ID: <Pine.GSO.4.33.0205060753080.28613-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 3 May 2002, McFadden, Ken wrote:

> RH7.2 kernel version out of the box is 2.4.9-xx....And the current version
> from RH is 2.4.9-31.....
> Would I load RH7.2 and then load the latest patch from RH and then load
> SELinux????  How
> about updates or using RH up2date to get the latest patches and updates from
> RH?????
> Any ideas on the procedures to update RH after loading SELinux???

SELinux tracks the latest mainstream kernel, not the RedHat-patched
kernel.  The current 2.4-based SELinux release is based on kernel 2.4.18.
We have successfully run this kernel with both RH7.1 and RH7.2.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
