Message-Id: <see628a5.002@atlas.snu.edu>
Date: Tue, 10 Jun 2003 18:50:54 -0500
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <SELinux@tycho.nsa.gov>
Subject: Policy transport, management, application installation, etc
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, the time has come.. We now have the ability to label files during
installation
and so we have no choice but to confront my worst fear and problem
since day 1

Policy transport:
  How to get the policy to the users machine when they install app X

Policy management:
  How should the package manager deal with policies.
 
  To properly label a package the policy of the package would have to
be
  merged in to the users policy, recompiled and reloaded so that the 
  contexts needed are available. 

  This seems bad, playing with the users policy can't be a good thing,

  but installing files with incorrect labels can't either. 

  Without doing this the user would be installing apps that either
don't 
  have the proper labels to enforce proper use, or apps that just 
  plain don't work


I've really dreaded this moment from the very beginning of this
project
but if we are to make this usable by anyone except us :P this needs to
happen, and if we are to be taken seriously it has to happen the right
way. I'd REALLY like comments, suggestions, flames, advice, details
on existing implementations, etc.

PLEASE HELP! :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
