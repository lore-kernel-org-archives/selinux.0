Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p51NveNK010395
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 19:57:40 -0400
Received: from fep05-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p51Nvcmi021869
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 23:57:39 GMT
Subject: Re: Is there way to set some specific domain to have all
 permissions?
From: Guido Trentalancia <guido@trentalancia.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 02 Jun 2011 01:57:34 +0200
In-Reply-To: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
References: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1306972657.2532.20.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again !

I forgot to add that there is a policy mailing list... It's called
refpolicy mailing list, it doesn't matter that you are not writing
reference policy, it's still more appropriate than here.

Here you go:

http://oss.tresys.com/mailman/listinfo/refpolicy

Regards,

Guido

On Wed, 2011-06-01 at 16:43 -0700, Sam Gandhi wrote:
> If I want to set permission for say program in myprog_t to allow all
> the permissions, is there way to do this in SELinux.
> 
> Example I have program myprog and rule to set it domain correctly,
> what I want to do is this domain myprog_t should be able to do
> anything.
> 
> How would one write such a policy rule? I have done search on mailing
> list archive and see there was a long thread in 2007 called 'concept
> of a permissive domain' but I am not able figure out what the
> conclusion of that thread was...
> 
> -Sam
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
