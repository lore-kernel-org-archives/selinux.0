MIME-Version: 1.0
Date: Thu, 13 Sep 2012 16:58:59 -0700
Message-ID: <CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
Subject: Update to docs
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can I get the documentation on the wiki updated under "SE Android
policy" the second paragraph. I would like to update that you can
specify genfs_context files and seapp_context files...maybe something
like below will be sufficient:

Device-specific additions for the policy configuration can be placed
in a sepolicy.te file (for kernel TE policy rules), a sepolicy.fc file
(for file_contexts entries), a sepolicy.pc file (for property_contexts
entries), a sepolicy.genfs_contexts file (for genfs entries), or
seapp_contexts (for seapp rule entries) under any of the
target/board/<device>, device/<vendor>/<device>, or
vendor/<vendor>/<device> directories. These files if present are
merged into the policy during the build.

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
