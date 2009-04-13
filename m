Subject: Re: Policies for Devices?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Robert Mykland <robert@ascenium.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <49E0134D.3040903@ascenium.com>
References: <49E0134D.3040903@ascenium.com>
Content-Type: text/plain
Date: Mon, 13 Apr 2009 09:53:35 -0400
Message-Id: <1239630815.6129.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-10 at 20:49 -0700, Robert Mykland wrote:
> Folks,
> 
> Is there a way I can use policies to prevent a specific device, say a 
> USB key, from being written to except by one specific application?  If 
> so, how would I go about writing that?

SELinux can control:
- what processes can access device files (read/write to the device file
types),
- what processes can mount filesystems (mount to the filesystem type,
mounton to the mountpoint directory),
- what processes can read/write a mounted filesystem (read/write to the
file types in the filesystem).

So SELinux can certainly limit the ability of applications to access
particular devices.  Exactly how one maps that down to a given system
depends on your particular environment and usage model, and may involve
more than just policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
