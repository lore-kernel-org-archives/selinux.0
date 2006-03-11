Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2BEAdtr005528
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 09:10:39 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2BE94qf009382
	for <selinux@tycho.nsa.gov>; Sat, 11 Mar 2006 14:09:04 GMT
Message-ID: <4412DA4E.4030706@cornell.edu>
Date: Sat, 11 Mar 2006 09:10:22 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
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
- what if the contexts used are defined in another module that isn't 
linked yet?
- what if the contexts are in this module, but it isn't loaded?
- what about genhomedircon processing?

Why can't we do this in semanage_commit()?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
