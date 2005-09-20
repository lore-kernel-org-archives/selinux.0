Message-ID: <4330648F.7040609@cornell.edu>
Date: Tue, 20 Sep 2005 15:35:43 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
References: <432FBD08.2050903@cornell.edu> <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>How useful is it to wrap these libsepol interfaces with libsemanage?
>  
>
What do you mean?

The alternative is to either:
- implement the same interfaces in both places (which is worse), or
- have semanage functions take sepol data stuctures as arguments (which 
is bad design practice).

I don't think the current scheme is too bad - esp. because the wrap 
functions are inlined.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
