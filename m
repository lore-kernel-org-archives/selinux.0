Message-ID: <402D19A9.8040204@snu.edu>
Date: Fri, 13 Feb 2004 12:38:33 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: avc_has_perm gives no useful output in permissive mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok, I'm trying to use avc_has_perm but can't because I'll never get 
useful information in permissive mode, so I tried to use the 
accompanying functions, avc_lookup, security_compute_av and avc_insert 
but still don't get anything reasonable from the avc_entry I pass to it 
(ie: it's always the same thing, no matter what)

How should I deal with this? any hints?

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
