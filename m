Message-ID: <20050914130323.29097.qmail@web51502.mail.yahoo.com>
Date: Wed, 14 Sep 2005 06:03:23 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: New ideas on implementation on libsetrans.
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Am I missing other disadvantages?

How often would this library be called? Is it a performance hit for programs to
parse the flat file everytime they run? I'm thinking mostly of coreutils style
programs that would be in shell scripts. What program would be the heaviest user
of the translation library? Is anything other than translation being considered? 

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
