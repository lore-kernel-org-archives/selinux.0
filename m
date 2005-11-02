Message-ID: <e12e59640511020830q18817c3dsb01d3051970baf9f@mail.gmail.com>
Date: Thu, 3 Nov 2005 00:30:18 +0800
From: Wei Shen <cquark@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: A question on integrating IPSec to Selinux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greedings,

I read "Leveraging IPSec for Mandatory Access Control of Linux Network
Communication" by Mr. Trent Jaeger. I learned that when a security
association is built, the initiator is responsible for adding its MAC
label as an attribute of the SA, and the responder then use the label
received to decide the label of the SA in the responder endpoint.

To my understandings, in this implementation a remote client can only
act passively - it provide its authorization information, and can only
accept the label the server give it in the server side. Is it possible
for a remote process (assuming that it knows the policy configuration
in the peer side) to specify a label (e.g. a security level in MLS) it
expects to have in the peer side, and wait for a approval?

I think such a function is useful. For instance, if a user is allowed
to access remote service under different security levels, he can
specify a wanted level in one request, but not change authorization
information to meet the corresponding requirement every time. And we
then need not to change each application  level servers (such as
telnet, ftp) to realize similar features.

I also think by adding a optional wanted remote label together with a
local label to a proposal payload when negotiating a SA, it is not
hard to implement.

Is my comprehension any wrong?

Thanks!
Wei


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
