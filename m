Date: Thu, 24 Jan 2002 10:53:43 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Shutdown issues
In-Reply-To: <1011880927.1377.9.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0201241049530.20944-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 24 Jan 2002, Justin Smith wrote:

> In some cases, software (postgres and ipchains, for instance) is not
> properly shut down due to these denials.

Try shutting them down manually via run_init on their init scripts with
the 'stop' command, and see what denials get logged.  There is no postgres
domain in the example policy, so I don't know what the issue might be
there.  The ipchains domain was contributed, and it doesn't look complete
to me - I would have granted the entire 'create_socket_perms' macro for
rawip_socket rather than just create and setopt.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
