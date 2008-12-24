Message-ID: <4951FA70.6000100@city-fan.org>
Date: Wed, 24 Dec 2008 09:01:36 +0000
From: Paul Howarth <paul@city-fan.org>
MIME-Version: 1.0
To: SELinux mailing list <SELinux@tycho.nsa.gov>
Subject: Re: Alternative location of policy files
References: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
In-Reply-To: <a5e2b64d0812232358u19f442dfwd27da7f0978a508c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Perhaps you could mount /etc/selinux/_policyname_ rather than /etc from 
a writeable filesystem?

Paul.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
