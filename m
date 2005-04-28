Message-ID: <36282A1733C57546BE392885C06185928E2A19@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Davide Bolcioni <dbolcioni@3di.it>
Cc: fedora-selinux-list@redhat.com, SELinux <SELinux@tycho.nsa.gov>
Subject: RE: Is there a SELinux tutorial for ISVs ?
Date: Thu, 28 Apr 2005 14:29:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> This string of messages brings up something I wanted to get a 
> conversation going on how to handle non OS Provided policy.
> 
> We all know we need a better mechanism for handling "binary" 
> policy in 
> the future.  ( I think the future is now.)
> I see three people providing policy.
> 

I agree, as an ISV we need a way to add custom policy to support our
applications. We currently use a processed version to the policy to have
source modules until the binary modules are part of Fedora.

> 1. OS Provider with base policy.  (It would also be nice if the base 
> policy got broken into several policies and only the policy
> of the running service would be loaded.  If we got to this state we 
> would need a new mechanism for restoring file context since
> file_context might not meet the currently loaded policy. 
> 
> 2. Third Party application developers.  As the use of targeted policy 
> has begun to take off, Third Party ISV have started to question
> how they can play in this world.
> 

Exactly, see statement above.

> I see Tresys Stuff solving the problems of both of the above.
> 
> 3 Local User customization and minor policies.  Currently we 
> have people 

Along with local user policy, there needs to be local network policy
customizations as well. This is required from an MLS perspective and I would
think be useful for TE network restrictions as well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
