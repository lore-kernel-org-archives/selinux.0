Date: Wed, 12 Dec 2001 13:33:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Undefined refs in compile attempt
In-Reply-To: <20011212174500.GB26201@vnl.com>
Message-ID: <Pine.GSO.4.33.0112121305540.6865-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 12 Dec 2001, Dale Amon wrote:

> Also, have you included the Andrew Morton patches in your
> newer release? If you are having odd compile failures
> on Debian systems particularly with USB enabled, it's
> either that or downgrade binutils to an older less
> strict one (or enable HOTPLUG for no other reason than
> that it stops the bad bit of code from being left
> hanging).

No, our kernel tree is simply the mainstream kernel tree plus the LSM
kernel patch and the SELinux security module.  Assuming that the patches
to which you refer will show up in 2.4.17, we'll just pick them up when we
update to 2.4.17.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
