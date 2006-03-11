Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2BF88Rd006311
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 10:08:12 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2BF6Xqf015137
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 15:06:33 GMT
Message-ID: <4412E7CB.4040300@tresys.com>
Date: Sat, 11 Mar 2006 10:07:55 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: We need a tool to extract the file context contents out of a
 policy package.
References: <4412C109.1040906@redhat.com>
In-Reply-To: <4412C109.1040906@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> If we had this we could do something like
> 
> fixfiles -P mypolicy.pp
> 
> And it would restorecon over the file context.

the file contexts in any given package doesn't represent the file 
contexts on the system. Further, you'll lose the homedir and local 
entries (and if there are homedir entries present they'll lose their 
precedence)

what is the problem you are trying to solve? I think we can do this a 
better way.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
