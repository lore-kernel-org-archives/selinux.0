MIME-Version: 1.0
Date: Tue, 4 Sep 2012 12:00:30 -0700
Message-ID: <CAFftDdrVyPdLnRUP20gyEuNrZqu35KVGESS6_f_AJxjhvuC9oQ@mail.gmail.com>
Subject: Pull request for check_seapp
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>, rpcraig <rpcraig@tycho.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I sent a pull request using bitbucket for the sepolicy changes I have
made. The changes include adding support for a tool that checks the
validity of the seapp_contexts file and allows overriding entries.
This allows a OEM to override the reference policy without having to
make a direct change the reference policy.

Please review.

For others that would like to follow, you can check out this code at:
https://bitbucket.org/seandroid/external-sepolicy/overview

-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
