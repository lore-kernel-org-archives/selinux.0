Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGE5KmL025063
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 09:05:20 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAGE3gBv003561
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 14:03:43 GMT
Subject: Re: [redhat-lspp] Re: anyway to reverse a dontaudit rule?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joy Latten <latten@austin.ibm.com>, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <455B8F79.4020504@mentalrootkit.com>
References: <1163616448.17737.368.camel@faith.austin.ibm.com>
	 <455B8F79.4020504@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 09:05:46 -0500
Message-Id: <1163685946.7374.32.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-15 at 17:06 -0500, Karl MacMillan wrote:
> Joy Latten wrote:
> > Is there a way to reverse a dontaudit rule without having to
> > modify and recompile base policy? 
> > I need to see the audit message to help determine what permissions
> > are being denied for a particular application.
> > 
> 
> No - that is why the enableaudit.pp base policy is provided in 
> /usr/share/selinux/[policyname]/enableaudit.pp. Install that with:
> 
> semodule -b path_to_enableaudit
> 
> and you should see all denials.

Yes.  Eventually all of the dontaudits will be made conditional,
controlled by a Boolean.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
