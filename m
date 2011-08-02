Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p72GvaV7027268
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 12:57:36 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p72GvZu4018419
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 16:57:35 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p72GvZ8a001359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2011 12:57:35 -0400
Message-ID: <4E382C7D.60504@redhat.com>
Date: Tue, 02 Aug 2011 12:57:33 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 91/92] policycoreutils: sandbox: FIXME update sandbox
References: <4E3819A9.3050203@redhat.com>
In-Reply-To: <4E3819A9.3050203@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/02/2011 11:37 AM, Daniel J Walsh wrote:
>  This patch looks good to me. acked.
> 
> I agree that this is almost an entire rewrite.  Most of the sandbox code
> that went into upstream has changed drastically.


I think that your repo has a bit of breakdown of this patch.  I plan see
if I can't do a better job of breaking it into pieces....

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
