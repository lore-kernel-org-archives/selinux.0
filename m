Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2DF74HY009201
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 10:07:04 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2DF722b004211
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 15:07:02 GMT
Message-ID: <44158A89.7040004@redhat.com>
Date: Mon, 13 Mar 2006 10:06:49 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: We need a tool to extract the file context contents out of a
 policy package.
References: <4412C109.1040906@redhat.com> <4412E7CB.4040300@tresys.com>
In-Reply-To: <4412E7CB.4040300@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> If we had this we could do something like
>>
>> fixfiles -P mypolicy.pp
>>
>> And it would restorecon over the file context.
>
> the file contexts in any given package doesn't represent the file 
> contexts on the system. Further, you'll lose the homedir and local 
> entries (and if there are homedir entries present they'll lose their 
> precedence)
>
> what is the problem you are trying to solve? I think we can do this a 
> better way.
If I install a package I need a way of relabeling the files that are 
being installed.  Currently when the policy package gets updated, it 
does a diff between previous file_context and new file_context and then 
runs a restorecon on the diff.  We currently ignore homedirs.  Moving to 
modules, we need similar capabilities.  Relabeling the entire system 
ever time you update a policy module is not going to work.     The 
current method is not full proof, but it has been fairly effective over 
the last couple of years.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
