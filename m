From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bhargava Shastry <bshas3@gmail.com>
Subject: Re: SELinux on Android
Date: Thu, 10 Nov 2011 23:48:49 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com> <1320425998.1015.31.camel@moss-pluto> <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
In-Reply-To: <CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201111102348.49692.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Nov 2011, Bhargava Shastry <bshas3@gmail.com> wrote:
> I see two quick solutions: (1) Re-compile Android kernel with policydb
> version setting changed to 24. Unfortunately, the max version number
> currently supported in Android's 2.6.32 msm kernel is 23. (2) Downgrade to
> policy version 19 on the PC. Any thoughts on alternate solutions.

Why is it version 23?  The Debian 2.6.32 kernels support version 24 according 
to /selinux/policyvers.

Also you can't just change the number.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
