Message-ID: <45115834.30504@hp.com>
Date: Wed, 20 Sep 2006 11:03:16 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
        SELinux <SELinux@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: NetLabel base SID
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As discussed earlier I am going to be submitting a patch which converts
the NetLabel receive permission from "recv_msg" to "recvfrom".  I've
also been thinking about a discussion I've had with Venkat about what to
use as the NetLabel "base" SID in this particular case (this is ignoring
the secid reconciliation work right now as I think we need to have a
good solution in place until the secid work is completed).

Currently NetLabel uses the socket's SID which is convienient but may
make it difficult to distinguish NetLabel traffic in policy.  Venkat
suggested using the SECINITSID_UNLABELED as a base but I don't like that
approach because of the unlabeled connotation.  I believe Stephen
suggested at some point using SECINITSID_NETMSG as the base (Stephen, my
apologies for not doing this sooner, I didn't fully understand at the
time) - any objections?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
