From: Jim Meyering <jim@meyering.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: =?utf-8?B?T25kxZllaiBWYcWhw61r?= <ovasik@redhat.com>, yaneti@declera.com,
        CoreutilsBugs <bug-coreutils@gnu.org>,
        SE Linux
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH]: chcon: no longer abort on SELinux disabled kernel
In-Reply-To: <1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 05 Oct 2009 15:17:05 -0400")
References: <1254727932.3849.8.camel@dhcp-lab-219.englab.brq.redhat.com>
	<87zl85bs0e.fsf@meyering.net>
	<1254770225.2251.152.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 05 Oct 2009 22:02:05 +0200
Message-ID: <87d451boea.fsf@meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
...
> Must have previously booted an ancient kernel with SELinux permissive
> and no policy loaded.  Kernel was fixed by the commit below in 2006.
> I'd recommend that he run the following to clean up the droppings in his
> filesystem:
> find / \( -fstype ext2 -o -fstype ext3 -o -fstype ext4 \) -exec setfattr -x security.selinux {} \;
>
> commit 8aad38752e81d1d4de67e3d8e2524618ce7c9276
> Author: Stephen Smalley <sds@tycho.nsa.gov>
> Date:   Wed Mar 22 00:09:13 2006 -0800
>
>     [PATCH] selinux: Disable automatic labeling of new inodes when no policy is loaded

Thanks for the quick explanation!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
