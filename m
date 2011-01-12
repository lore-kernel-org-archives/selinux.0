Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0CKCjd8022747
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 15:12:45 -0500
Received: from qmta11.emeryville.ca.mail.comcast.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0CKCib1014884
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 20:12:45 GMT
Message-ID: <4D2E0B3E.3090302@tresys.com>
Date: Wed, 12 Jan 2011 15:12:46 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: iodine and SE Linux
References: <201101091656.21062.russell@coker.com.au>
In-Reply-To: <201101091656.21062.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/9/2011 12:56 AM, Russell Coker wrote:
> I notice that iodine (IP over DNS tunnel daemon) has sample SE Linux policy
> and a SE Linux patch to the source code.
>
> The way it works is that you give iodine a -z parameter with the context that
> you want and it then calls setcon() to get it.
>
> What I am thinking of doing is writing policy for iodine, icmptx, and any
> other daemon that operates in a similar manner that has an automatic domain
> transition and no setcon().  I am thinking of making this tunnel_t.
>
> What do you think?

I'm not familiar with these tunnel services; does it make sense to adapt 
the existing stunnel policy?  Or if we went to a tunnel_t generic 
service, would it be possible to get stunnel over to it?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
