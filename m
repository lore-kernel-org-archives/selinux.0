Message-ID: <1954376199-1294864398-cardhu_decombobulator_blackberry.rim.net-2144160136-@bda2781.bisx.prod.on.blackberry>
Reply-To: hmarti2@umbc.edu
References: <201101091656.21062.russell@coker.com.au><4D2E0B3E.3090302@tresys.com>
In-Reply-To: <4D2E0B3E.3090302@tresys.com>
Subject: Re: iodine and SE Linux
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        owner-selinux@tycho.nsa.gov, russell@coker.com.au
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
From: hmarti2@umbc.edu
Date: Wed, 12 Jan 2011 20:33:20 +0000
Content-Type: text/plain
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris,
 
Perhaps a generic one may be best, as some of the custom protocols desired to be tunneled will not make it into a 'stunnel' discussion or forum. At least not in some places where we use the product.

Best, Hal 
Sent via BlackBerry by AT&T

-----Original Message-----
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
Date: Wed, 12 Jan 2011 15:12:46 
To: <russell@coker.com.au>
Cc: SE-Linux<selinux@tycho.nsa.gov>
Subject: Re: iodine and SE Linux

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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
