Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFM6cPQ006048
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 17:06:38 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFM5tGt019146
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 22:05:56 GMT
Message-ID: <455B8F79.4020504@mentalrootkit.com>
Date: Wed, 15 Nov 2006 17:06:49 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joy Latten <latten@austin.ibm.com>
CC: redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: anyway to reverse a dontaudit rule?
References: <1163616448.17737.368.camel@faith.austin.ibm.com>
In-Reply-To: <1163616448.17737.368.camel@faith.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joy Latten wrote:
> Is there a way to reverse a dontaudit rule without having to
> modify and recompile base policy? 
> I need to see the audit message to help determine what permissions
> are being denied for a particular application.
> 

No - that is why the enableaudit.pp base policy is provided in 
/usr/share/selinux/[policyname]/enableaudit.pp. Install that with:

semodule -b path_to_enableaudit

and you should see all denials.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
