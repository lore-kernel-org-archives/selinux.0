Message-ID: <43BAB2D6.4030103@cornell.edu>
Date: Tue, 03 Jan 2006 12:22:30 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com>
In-Reply-To: <43BAC4EA.8020106@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please use < 0 to check for error everywhere.
This is correct behavior, even though the only error code I currently 
use is -1.
Once commit numbers are included (commit numbers are positive integers), 
some
of those calls might fail if you check with != 0.

I already fixed a few earlier - not sure this patch is affected, but < 0 
should be used in general.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
