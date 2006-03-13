Message-ID: <4415DA1E.1030208@redhat.com>
Date: Mon, 13 Mar 2006 15:46:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Strange behaviour in MLS Policy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Any idea why devpts in MLS is mounting at SystemHigh?

I see no reason in policy that this would happen. 

 From reading policy I believe it should be mounting at SystemLow, the 
same way tmpfs does.

The goal is to get it to mount at SystemLow-SystemHigh.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
