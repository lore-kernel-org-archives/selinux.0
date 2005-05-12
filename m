Message-ID: <428368FF.2080603@redhat.com>
Date: Thu, 12 May 2005 10:32:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Busted by constraints.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Auditing of constraint failures sucks.  We are putting out incorrect 
error messages.  Or at least not informative enough to help the 
user/policy writer to figure out what is wrong.

Yesterday,  Another engineer and I spent a lot of time trying to figure 
out why setfscreatecon was failing.  The only indication was the the
application was not allowed to created a directory.  Of course the allow 
rule was present in the policy.  Eventually we figured out we needed
the privowner priv to get by a constraint.    Shouldn't the kernel be 
reporting a constraint failure.  Isn't this going to become a lot more
important with MLS?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
