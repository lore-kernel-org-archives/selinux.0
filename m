Message-ID: <4951F766.5060901@gmail.com>
Date: Wed, 24 Dec 2008 00:48:38 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Tim <timasyk@gmail.com>
CC: SELinux mailing list <SELinux@tycho.nsa.gov>
Subject: Re: Alternative location of policy files
References: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
In-Reply-To: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tim wrote:
> Hello all,
>
> I was wondering, how can I change default location of SELinux policy
> from /etc/selinux/_policyname_ to some other path?
> What source codes should be modified for that?
>
> The reason to do that are:
> - I want to work with loadable policy modules --> that requires
> /etc/selinux/_policyname_ directory to be writable.
> - limitation of my filesystem having /etc directory (it is read-only filesystem)
> - unfortunately, I can not mount /etc into some other writable filesystem
>
> Kindest regards,
> Tim
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   
FWIW
SELinux reads the policy, then
enforces what it reads.
so if everything is (chmoded 0400) then you should be fine.

but could be wrong;  ;/

regards;

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
