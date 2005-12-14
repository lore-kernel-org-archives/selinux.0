Subject: SELinux performance
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Wed, 14 Dec 2005 14:08:54 -0600
Message-Id: <1134590934.2630.207.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A while back I took up some SELinux performance work that a colleague of
mine, Kylie Hall had done. The patch added ipv4 address, ipv6 address
and port caches to SELinux. I believe I sent the patch a while back
also, but can do so again if anyone is interested. The caches are
exercised in such SELinux hooks as socket_bind(), socket_connect() and
socket_sock_rcv_skb(). Bandwidth has allowed me some time to work on
this. Can anyone recommend a benchmark that will exercise this code?  I
figured something that utilized many ip addresses or ports. 

I will be on vacation starting tomorrow, but will be reading email from
time to time as I would like to complete this work.

Regards,
Joy Latten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
