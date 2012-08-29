Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7TIesLR015872
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 14:40:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 29 Aug 2012 14:40:56 -0400
From: David Quigley <dpquigl@davequigley.com>
To: <russell@coker.com.au>
Cc: Raul da Silva {Sp4wn} <sp4wn.root@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: proof selinux
In-Reply-To: <201208291728.10022.russell@coker.com.au>
References: <CAE_4iW8xF5NLvjrXKpSExgstbFx8JKfx38F5PBN0YP3VaPFz4Q@mail.gmail.com>
 <201208291728.10022.russell@coker.com.au>
Message-ID: <4cee1abc4a7ae191baffce20b516f4f7@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/29/2012 03:28, Russell Coker wrote:
> On Wed, 29 Aug 2012, "Raul da Silva {Sp4wn}" <sp4wn.root@gmail.com> 
> wrote:
>> I know that we have a lot of ways to prove how effective is SELinux 
>> as cgi,
>> perl, shell scripts and I know that is effective but I'd like to 
>> know if
>> someone already tested some kind of exploit of buffer overflow 
>> attack as
>> demo to show how effective could be SELinux.
>> Any information I really appreciate
>
> A simple test of this would be to run a program like telnetd as 
> httpd_t (or
> some other domain that takes remote connections) and configure it to
> launch a
> shell with no password.
>
> http://www.coker.com.au/selinux/play.html
>
> Also I have a Play Machine online right now to demonstrate how the 
> root
> account can be locked down.


An easier example is what I use for my SELinux talks. Custom file 
transfer daemon (gets only) which has a very critical flaw in it. It 
doesn't sanitize the path that is requested for the binary. Because of 
this you can use .. repeatedly to get where you need to in the 
filesystem hierarchy and pull any file you want. Once you install the 
SELinux policy it will only allow you to pull files with the correct 
content type.

https://github.com/dpquigl/ftransferd

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
