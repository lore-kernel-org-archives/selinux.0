Date: Wed, 6 Jun 2001 14:04:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "C. Slater" <cslater@wcnet.org>
cc: SELinux <SeLinux@tycho.nsa.gov>
Subject: Re: SeLinux and Loopback Encryption?
In-Reply-To: <001d01c0ed3b$61722da0$73cdae3f@cslater>
Message-ID: <Pine.SOL.3.95.1010606135750.3546Z-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 4 Jun 2001, C. Slater wrote:

> Would there be any problem with installing loopback encryption on a system
> running SeLinux? Would there be any interference between versions of
> programs?

I haven't tried using loopback encryption on SELinux.  I would
guess that you will need to patch the loopback encryption file system
implementation to support persistent labeling.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
