Message-ID: <46CC341A.6070109@redhat.com>
Date: Wed, 22 Aug 2007 09:03:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Don't know postfix well enough to know what to do with this one.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=253809

Obviously policy is written to deny postfix_local_t "write" of 
mail_spool_t, so this is unexpected behaviour.  Should I dontaudit it?  
Should I allow it?  I have no idea.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
