Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TGtmZ5007632
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 12:55:48 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4TGtjgZ026105
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 16:55:45 GMT
Message-ID: <465C5AFD.3070909@redhat.com>
Date: Tue, 29 May 2007 12:55:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ted X Toth <txtoth@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: unshare behavior when polyinstantiating
References: <465C31D0.2040606@gmail.com>
In-Reply-To: <465C31D0.2040606@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ted X Toth wrote:
> I've run into some polyinstantiation bugs but want to make sure I 
> understand what unshare(CLONE_NEWNS) does before I submit a patch. Is 
> it the case that the new namespace created by unshare is related to 
> the current process and when this process exits the namespace is 
> destroyed or is no longer valid? All mounts and unmounts done in the 
> new namespace have no affect on the parent processes namespace, correct?
>
> Ted
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
That is my understanding.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
