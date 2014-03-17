Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2HBM18L011110
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 07:22:01 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so3585828lab.32
 for <selinux@tycho.nsa.gov>; Mon, 17 Mar 2014 04:21:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1403171445570.2002@tundra.namei.org>
References: <2794067.Wx0yCIiBrQ@sifl>
 <alpine.LRH.2.02.1403171445570.2002@tundra.namei.org>
Date: Mon, 17 Mar 2014 07:21:59 -0400
Message-ID: <CACLa4pukOH8TLmRorra4Wh0962y-QF4D2eFzgvr7KSSJnSLKZw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 3.15
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

You think a security tree based on 3.13-rc7 is good and Paul, who
tested on the actual release of 3.13 is bad?

I know you got yelled at for randomly picking fast forward-ish merge
points, but now you've got a crappy merge point.  Apparently, it was
needed it for the Xen/TPM work (not sure why YOU merged it instead of
the TPM people, but that's beside the point).

But the problem stands.  You are based on a crummy location.  When are
you going to pick up 3.13?  After 3.14 is out?

Seems like Paul's move to include 3.13 made a lot of sense...

On Sun, Mar 16, 2014 at 11:51 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 14 Mar 2014, Paul Moore wrote:
>
>> Hi James,
>>
>> Here are the SELinux patches for 3.15.  There are three patches here, the
>> first and last are obvious fixes and the middle patch is a straightforward
>> DAC-before-MAC fix.  They should merge into the linux-security tree without
>> problem.
>>
>> Enjoy,
>> -Paul
>
> Your tree is ahead of mine wrt Linus.  It doesn't apply.
>
>
>
>
> --
> James Morris
> <jmorris@namei.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
