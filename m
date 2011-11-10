MIME-Version: 1.0
In-Reply-To: <201111102348.49692.russell@coker.com.au>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320425998.1015.31.camel@moss-pluto>
	<CAGGozWSziAmmDb-eO3AjVL=eRgeCHzGb6vo-uNpLy_2sxog2tQ@mail.gmail.com>
	<201111102348.49692.russell@coker.com.au>
Date: Thu, 10 Nov 2011 08:11:45 -0500
Message-ID: <CACLa4pu-M+KhKWxBwD6ap+9ojUdESSttwwkE5nNpwFxTD+gadw@mail.gmail.com>
Subject: Re: SELinux on Android
From: Eric Paris <eparis@parisplace.org>
To: russell@coker.com.au
Cc: Bhargava Shastry <bshas3@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How are you loading the policy on the target?  libsepol and
load_policy should automatically downgrade as needed.  At least I
thought it did.  In any case, you should be able to edit semanage.conf
on the build system and build a lower version policy.

-Eric

On Thu, Nov 10, 2011 at 7:48 AM, Russell Coker <russell@coker.com.au> wrote:
> On Thu, 10 Nov 2011, Bhargava Shastry <bshas3@gmail.com> wrote:
>> I see two quick solutions: (1) Re-compile Android kernel with policydb
>> version setting changed to 24. Unfortunately, the max version number
>> currently supported in Android's 2.6.32 msm kernel is 23. (2) Downgrade to
>> policy version 19 on the PC. Any thoughts on alternate solutions.
>
> Why is it version 23?  The Debian 2.6.32 kernels support version 24 according
> to /selinux/policyvers.
>
> Also you can't just change the number.
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
