Date: Wed, 6 Feb 2002 12:36:12 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Hacko <toltec@karai.net>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: test selinux account
In-Reply-To: <Pine.LNX.4.44.0202061849040.31648-100000@karai.karai.net>
Message-ID: <Pine.GSO.4.33.0202061233020.27827-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 6 Feb 2002, Hacko wrote:

> if you wish please test selinux,2.4.14-lsm on slackware-curent, PC,
> enforcing, test is in user_r:user_t, as some of the other user accounts,
> many restrictions are not present, test is normal shell account.

You might want to consider upgrading to a newer version of SELinux, since
there have been various bug fixes since the 2.4.14-based kernel.  When you
say "many restrictions are not present", what exactly do you mean?  Did
you significantly alter the example policy configuration?  You probably
had to make a number of changes just to adapt to Slackware.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
