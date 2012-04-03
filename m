Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q33M3rO9017956
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2012 18:03:56 -0400
Message-ID: <4F7B73C6.20307@schaufler-ca.com>
Date: Tue, 03 Apr 2012 15:03:50 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: David Quigley <selinux@davequigley.com>
CC: selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: Fwd: [nfsv4] Last call for "Requirements for Labeled NFS" - ends
 on April 27th
References: <1f4c6a50d6f2ac2bcdedd8cb19ec41cf@countercultured.net>
In-Reply-To: <1f4c6a50d6f2ac2bcdedd8cb19ec41cf@countercultured.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/3/2012 1:16 PM, David Quigley wrote:
> A heads up for everyone who has been involved in the process. Take a
> look and provide some comments if you'd like. I will be reviewing it
> soon and providing my feedback.

Overall well done document.

Section 3.3 uses the term "context" differently than it is used in
sections 3.5.1 and 3.7.1.
It is not clear what comprises the "context" referenced in section 3.3.
The "security context" referenced in 3.5.1 and 3.7.1 may not translate
between client and server.
If the client is a strictly capability based Unix (e.g. Trusted Irix)
and the server SELinux the "security context" of the client may be
completely incomprehensible to the server.

Perhaps a change on the order of:

    "Both the server and the client have MAC functionality enabled, and
full LNFS functionality is extended over the network between both client
and server."

to

    "The server and the client have mutually recognized MAC
functionality enabled, and full LNFS functionality is extended over the
network between both client and server. "

And I've added the LSM list to the CC, as SELinux isn't the only
environment concerned with the outcome of Labeled NFS.

>
> -------- Original Message --------
> Subject: [nfsv4] Last call for "Requirements for Labeled NFS" - ends
> on April 27th
> Date: 04/03/2012 14:13
> From: Spencer Shepler <sshepler@microsoft.com>
> To: "nfsv4@ietf.org" <nfsv4@ietf.org>
>
>
>
> The following has been made available (Thanks Tom).
>
> We are staring last call on this document and it will end on April 27th..
>
> Please take the time to read and provide comments.
>
> Note that this work is targeted as an informational RFC in preparation
> for NFSv4.2 work.
>
> Spencer
>
> "Requirements for Labeled NFS"
>
> draft-ietf-nfsv4-labreqs-00.txt
>
> http://www.ietf.org/id/draft-ietf-nfsv4-labreqs-00.txt
>
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
