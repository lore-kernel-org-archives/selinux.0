Date: Fri, 26 Sep 2003 14:02:32 +0100
From: Dale Amon <amon@vnl.com>
To: David Caplan <dac@tresys.com>
Cc: "NSA's SELinux" <SELinux@tycho.nsa.gov>
Subject: Re: policy language extensions
Message-ID: <20030926130232.GF10225@vnl.com>
References: <3F7361F8.1080603@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F7361F8.1080603@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 05:45:28PM -0400, David Caplan wrote:
> We are currently working on a couple of policy language extensions for 
> which we'd like to let the group comment on.  Both grew out of the 

Looks like just what the doctor ordered. I was thinking
about a related issue yesterday while battling sshd policy
issues (actually I should not use past tense: still am) and
how much easier it would be if I could simply execute or delete
policy statements during a live debugt sessions using a 
policy interpreter. A sort of "perl -de 1" for policy
would be nice. 

Some things could be difficult though: policy statements
do not appear to me to have a 1:1 relation to the binary 
representation.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
