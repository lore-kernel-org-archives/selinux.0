Message-ID: <4159C55D.4050404@redhat.com>
Date: Tue, 28 Sep 2004 16:11:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Problems with fixfiles and setfiles.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The fixfiles script is used to report and fix file contexts that are 
invalid, the problem is that it gets a lot of
false positives.  Reviewing fixfiles.cron shows that most of the files 
created by mozilla are reported as invalid.
It would be nice if we could remove these false positives by some means.

If we had some mechanism of saying a file could have one of several 
valid contexts, or be in a context that
has a certain attribute.

Ideas?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
