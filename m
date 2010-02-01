Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11IQ9Q7005888
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 13:26:09 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o11IPxYO003323
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 18:26:01 GMT
Message-Id: <201002011825.o11IPhsu011947@vivaldi36.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 19:25:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

thanks very much for your last comment. I always forgot to talk about that, despite my intention was to discuss it... It's just that there were many tiny details to discuss.

> ocontexts[OCON_ISID] is a list of initial SIDs and their 
> contexts. Your current code takes the MLS range from 
> whatever happens to be the first entry in the list and uses 
> that for all of the contexts.

At the beginning I was scanning for "unlabeled" in oc->u.name with strcmp(), but then I wasn't sure about adding extra complexity to the code and I left that out waiting for your comments.

At present, for the latest reference policy the first initial SID is "kernel", which surely isn't the best match, but as I already told you I was waiting for some feedback on details.

I will introduce your piece of code (assuming there is always going to be an entry for SECINITSID_UNLABELED in the list).

By the way, is there any drawback in loading the initial SIDs again from security_load_policy() using the appropriate function that you mentioned ?

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
