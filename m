Date: Sat, 22 Feb 2003 14:47:52 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: XML ACL standard ratified
Message-ID: <20030222034752.GC25815@snoopy.apana.org.au>
References: <se55ee2c.092@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <se55ee2c.092@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 21, 2003 at 09:14:52AM -0600, Joshua Brindle wrote:
> http://www.eweek.com/article2/0,3959,893831,00.asp
> XACML (extensible access control markup language) ratified
> 
> will selinux be taking advantage of this? i know someone was working on
> some xml stuff a while back but everytime i go look at where it is it
> hasn't changed.. anyone else planning on implementing an XML policy
> translator or something? Thanks..

So far I only have had a quick look at XACML (and may be totally
mistaken, I am still downloading the specs), but it would appear to
serve a different purpose to SE-Linux.

XACML, while a central policy, like SE-Linux, appears to be focused
around what actions individual users can/can't do. eg. Can a user log in
at time X:XXam?.

SE-Linux on the other hand is focused on what processes can access
what resources. eg. Can Mozilla access the user's PGP private key?
Can inetd bind on port 80?

These aren't necessarily mutually exclusive goals, just different
goals.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
