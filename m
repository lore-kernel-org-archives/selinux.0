Message-ID: <43663282.8030707@redhat.com>
Date: Mon, 31 Oct 2005 10:04:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Should this be a dontaudit or an allow in targeted.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=172040

Basically if a normal uses does a ps -ef on a system, his process will attempt to read the context of udev and friends that are running at a higher sensitivity level.  So apps like login, udev and others will generate 
AVC messages with MCS policy.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
