MIME-Version: 1.0
Date: Thu, 23 Aug 2012 21:16:02 -0700
Message-ID: <CAFftDdqVC0ho6C0GzWsyLqSFkR71E7KaY5FeqJYbripPjG7DjA@mail.gmail.com>
Subject: Inheriting labels
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Suppose you have a directory in /efs/dir1 that is labeled as X

suppose you create /efs/dir1/B, it is unlabeled...

When I go to system or another partition, the label is inherited from
the parent, how come it is not like this on efs?

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
