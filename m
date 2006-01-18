Message-ID: <43CD9BAE.40006@tresys.com>
Date: Tue, 17 Jan 2006 20:36:46 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com>
In-Reply-To: <43CD54B9.4030307@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Includes Ivan and Russells changes
> 
> Now checks to make sure run as root.

while it's probably true that most 'direct' libsemanage sessions need 
root that is not true for policy server so I don't think there should be 
a hard coded root check (aren't we trying to rely on MAC here?)
> 
> Also chcat can now manipulate categories of users as well as files.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
