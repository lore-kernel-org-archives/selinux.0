Subject: iptables err
From: Reino Wallin <reino@oribium.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 24 Apr 2002 09:04:14 +0200
Message-Id: <1019631854.26933.12.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I am executing /etc/init.d/iptables stop, the following error message appears:

iptables: libiptc/libip4tc.c:384: do_check: 
Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.

It works just fine with the standard RedHat kernel.

Reino

-- 
Reino Wallin, Oribium Labs
reino@oribium.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
