Date: Mon, 6 May 2002 09:25:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "McFadden, Ken" <ken.mcfadden@lmco.com>
cc: "SE Linux Distro (E-mail)" <SELinux@tycho.nsa.gov>
Subject: Re: Would like to load SELinux.....
In-Reply-To: <31A81CDD9175D411815100508BE32AA60142F362@emss02m13.ems.lmco.com>
Message-ID: <Pine.GSO.4.33.0205060909330.28613-100000@raven>
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

Sorry, I didn't fully answer your question in my initial response.
Prior to first installing SELinux, it would certainly be reasonable (and
likely desirable) to install all available updates from RedHat for RH7.2.
After installing SELinux, you naturally cannot use updates from RedHat
for the SELinux-modified packages, particularly the kernel, openssh (sshd),
util-linux (login), vixie-cron (crond), and logrotate.  You would have to
wait until we had merged the SELinux modifications into the updated
packages or do the merge yourself.  At present, I think that we are
up-to-date with the latest RedHat 7.2 SRPMs for the modified daemons and
utilities.  However, this is not a high priority for us, and is only done
as time is available, as noted on the Remaining Work page.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
