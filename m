Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CGf3Gj008681
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 12:41:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CGf2lJ021782
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 16:41:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8CGf12m015732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 12:41:02 -0400
Subject: Re: Inherited tpe definition
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1189614281.4270.39.camel@localhost.localdomain>
References: <1189614281.4270.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 12:40:55 -0400
Message-Id: <1189615255.4270.44.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-12 at 12:24 -0400, Karl MacMillan wrote:

[...[
> 
> 3) I had suggested in that thread that reference policy interfaces /
> templates was a better solution to these problems. I think that I was
> wrong - these problems seem to still exist and haven't been adequately
> addressed via interfaces.
> 
> So - I'd like to consider this proposal again and see if anyone has any
> ideas on solving the objections.

Just to note - using the inheritance technique would likely break the
current reference policy encapsulation rules. In my view, that is not a
large problem but I know others place more value on the encapsulation.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
