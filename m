Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 16:07:19 +0200
References: <20020412122349.A28382@lemuria.org> <20020412120516.E261F2845B@lyta.coker.com.au> <20020412150120.A29327@lemuria.org>
In-Reply-To: <20020412150120.A29327@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020412140719.EC35D281EF@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 15:01, Tom wrote:
> > I think that if we already had such a feature then Tom would find his
> > problems much easier to solve.
>
> Maybe as simple as an improved output that includes the version number
> of the created/checked policy file. Knowing that the problem lies with
> the versioning of /ss_policy would've saved me an hour or two.

True.

Also it would be good if we had a signature that can be recognised by file(1).

Having SE Linux code in /etc/magic for 0x6, 0x7, or 0x8, etc as the first 
long of the file is not viable, eventually we'll hit a conflict.

This is why I have intentionally not submitted my /etc/magic changes to the 
maintainer of the "file" package.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
