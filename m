Subject: Why use write_lock_irq() in services.c
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 17 Aug 2009 14:26:13 -0400
Message-Id: <1250533573.4829.9.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In security_load_policy() and security_set_bools() we take
write_lock_irq(&policy_rwlock);  I want to make sure I understand why we
need the _irq.  Is it just because it's possible that in irq context we
might come down a path that leads to a read_lock() which would deadlock
against the write_lock?  There is no concern for irqs to ever get to a
write_lock that I can see, is that correct as well?

/me playing with locking a bit....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
