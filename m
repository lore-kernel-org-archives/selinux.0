Message-ID: <20060208171037.31031.qmail@web51504.mail.yahoo.com>
Date: Wed, 8 Feb 2006 09:10:36 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Add version option to newrole
To: Glauber de Oliveira Costa <glommer@br.ibm.com>, Selinux@tycho.nsa.gov,
   Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <200602081445.14747.glommer@br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I moved the constant definition to the makefile, and also, I'm gathering the
data
>from the version file.

Thanks. That should be easier to maintain.

>Also, Steve, I would like to hear from you why do you think the -v
>option is not that descriptive.

OK my bad. I though the -- ARGS was added. -v is fine.

But waht about the other programs? load_policy, restorecon, run_init, etc...

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
