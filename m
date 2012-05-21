Subject: Re: labeled NFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: zyxel <zyx1984@gmail.com>
Cc: selinux@tycho.nsa.gov, Dave Quigley <selinux@davequigley.com>
In-Reply-To: <CAHx7xgUSgC+NgtroN8CpUJCbRvwbmtXw8HuerTFbRRXbMW9nBg@mail.gmail.com>
References: 
	 <CAHx7xgUSgC+NgtroN8CpUJCbRvwbmtXw8HuerTFbRRXbMW9nBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 May 2012 08:27:47 -0400
Message-ID: <1337603267.28413.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-05-21 at 15:50 +0400, zyxel wrote:
> Hello.
> I have another question about labeled nfs.
> 
> If both client and server have are patched to support labeled NFS and
> if on the client side policy is set to permissive and on server side
> policy is set to enforcing,
> we can access files on the server from the client without any
> restrictions.
> Is it correct behaviour?

I believe so, as the LNFS implementation only deals with object labeling
support for NFSv4.  Conveying the client process security label to the
server (so that the server can enforce per-process access controls)
would be provided by another mechanism such as RPCSEC_GSSv3.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
