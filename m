Subject: Key unlink permission
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: dhowells@redhat.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 31 May 2006 15:25:04 -0400
Message-Id: <1149103504.3269.5.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

Do you think the unlink permission will be something that you'd like to
add to your userspace discretionary controls at some point?  I'm trying
to decide where to position the bit.  I can put it out of the way in the
most significant position, or I can give it the 0x40 position so that it
will be accessible from userspace...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
