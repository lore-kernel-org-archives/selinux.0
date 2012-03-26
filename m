Subject: Re: Debian patches to userspace components
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20120326141242.59afdd34@eldamar.bigon.be>
References: <20120326141242.59afdd34@eldamar.bigon.be>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Mar 2012 09:26:49 -0400
Message-ID: <1332768409.6473.17.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-03-26 at 14:12 +0200, Laurent Bigonville wrote:
> Hi,
> 
> I'm currently helping Russel with the SELinux packages in Debian.
> 
> The Debian packages are carrying some (a lot?) of patches that I would
> like to see merged upstream. The rational of some of them has
> unfortunately been lost and not all of these patches are suitable for
> being merged upstream.
> 
> The patches that are currently applied to the debian packages can be
> found at:
> 
> http://patch-tracker.debian.org/package/libselinux/
> http://patch-tracker.debian.org/package/libsepol/
> http://patch-tracker.debian.org/package/libsemanage/
> http://patch-tracker.debian.org/package/sepolgen/
> http://patch-tracker.debian.org/package/policycoreutils/
> http://patch-tracker.debian.org/package/checkpolicy/
> http://patch-tracker.debian.org/package/setools/
> 
> Are you interested in them? If so, I'll forward the ones that I think
> are not Debian specific to the mailing-list.

Yes, please post the ones that seem generally applicable.  Preferably
relative to the current git trees,
http://userspace.selinuxproject.org/trac/wiki/Contributing

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
