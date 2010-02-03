Message-ID: <4B691583.5060608@ak.jp.nec.com>
Date: Wed, 03 Feb 2010 15:19:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: avc_open() and netlink_loop()
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When we initialize userspace avc using avc_open(3), it internally calls
avc_init(3) without any callback functions. The avc_init() is introduced
as a deprecated interface from application code, so it is recommended to
use avc_open() instead for new applications.

The avc_init() internally calls avc_netlink_open(). If no thread callback
is not given, the 'blocking' argument shall be 0, then avc_netlink_open()
set O_NONBLOCK flag on the socket file descriptor.

Next, application will create a thread to receive messages via netlink
socket to invalidate userspace avc, using avc_netlink_loop().
However, if userspace avc of libselinux is already initialized,
the avc_netlink_loop() immediately returns with EWOULDBLOCK, because the
netlink socket is not blocked and avc_netlink_receive() does not expect
recvfrom() returns error.

It seems to me O_NONBLOCK is a wrong strategy in this case, and select(2)
should be checked in avc_netlink_check_nb() instead.

Eamon, what is your opinion?
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
