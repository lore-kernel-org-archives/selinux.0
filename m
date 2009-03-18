Message-ID: <49C144A7.3010401@manicmethod.com>
Date: Wed, 18 Mar 2009 14:59:51 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Robert Story <Robert.Story@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Policy Access Control
References: <49777FFB.1030504@manicmethod.com> <20090318143856.3abf45ef@sparta.com>
In-Reply-To: <20090318143856.3abf45ef@sparta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Robert Story wrote:
> On Wed, 21 Jan 2009 15:05:15 -0500 Joshua wrote:
> JB> class policy.bool inherits policy
> JB> Like users and roles, booleans are created and set using the same 
> JB> declaration. Booleans may not be further modified; thus they have no 
> JB> class-specific permissions.
> 
> I find this an odd omission... If I were delegating responsibility for
> modifying policy, booleans are something I'd definitely want to be able to
> lock down. For example, I might not want my ftp admin (or anyone else that
> can tweak policy) turning on allow_ftpd_anon_write...
> 

Boolean state at run time can be controlled via filesystem labeling of the 
selinuxfs filesystem (as is done in Fedora today).

Persistent changes to the policy can't currently controlled because the policy 
access control doesn't "diff" the policies as such and therefore can't see a 
change vs. a remove/add. This is something we want to work on at a later time.

semanage changes to booleans require hooks in libsemanage which wasn't part of 
this effort, which was to nail down an acceptable way to do access control on 
policy additions and subtractions.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
