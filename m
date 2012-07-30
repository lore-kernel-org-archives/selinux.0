MIME-Version: 1.0
Date: Mon, 30 Jul 2012 16:59:48 -0700
Message-ID: <CAFftDdoBpZ9ruMjnBwiA9Cxh0L14xJiXh5LXam3V=n-jHTbYkg@mail.gmail.com>
Subject: Cloning Android repo's from bitbucket
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HTTPS checkouts of device-samsung-tuna fail, but the ssh clone worked for me.

Can we get new local_manifest branches, that specify using the git/ssh
checkout as the fetch url instead of https?

something like this:

master <-- https
master-ssh <-ssh

Keep is simple and consistent please so scripting is easy.

The only downside is you must have a registered bitbucket account and
ssh keys set up, but thats not a major problem if people use those
branches!

Thanks!

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
