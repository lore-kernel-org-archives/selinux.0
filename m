Message-ID: <45115E89.7060209@redhat.com>
Date: Wed, 20 Sep 2006 11:30:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: run_init requires full path.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why does run_init require me to have the full path?  Is there a security 
reason for this?

The basic problem is run_init, does a chdir("/") before execing the app.

So if I want to run a test script
run_init test.sh or
run_init ./test.sh

does not work.

I end up having to do
run_init `pwd`/test.sh



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
