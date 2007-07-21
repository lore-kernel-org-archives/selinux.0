Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6L4KHkW015033
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 00:20:17 -0400
Received: from fk-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6L4KGqb012444
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 04:20:16 GMT
Received: by fk-out-0910.google.com with SMTP id 19so192329fkr
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 21:20:15 -0700 (PDT)
Message-ID: <f71a82820707202120h46791ea4xaeef58248a8c346b@mail.gmail.com>
Date: Sat, 21 Jul 2007 13:20:15 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Karl MacMillan" <kmacmill@redhat.com>
Subject: Re: There is a bug in checkmodule that is driving me nuts
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1184970504.14677.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <46A11983.5090405@redhat.com>
	 <1184970504.14677.6.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Can I ask what policyrep is ?
Is that policy-generating project on going or wat ?

Thanks.

2007/7/21, Karl MacMillan <kmacmill@redhat.com>:
>
> On Fri, 2007-07-20 at 16:22 -0400, Daniel J Walsh wrote:
> > The compiler is mistakenly seeing a
> >
> > gen_requires {
> >        type  xguest_gnome_home_t;
> > }
> >
> > As a redefinition of the type
> >
> >  /usr/bin/checkmodule -M -m guest.tmp -o guest.mod/usr/bin/checkmodule:
> > loading policy configuration from guest.tmp
> > policy/modules/users/guest.te:4:ERROR 'duplicate declaration of
> > type/attribute' at token ';' on line 55020:
> >         type xguest_gnome_home_t;
> > #line 4
> > /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> >
> > The problem is the gen_requires happens before the declaration.
> >
> > The type is being declared in  a template file.
>
> For better or discarding of requires upon hitting a declaration isn't
> like to be fixed (when the require is first).
>
> I have an alternative suggestion - remove all of the requires from the
> policy and use an sepolgen-based pre-processor to add them back in until
> the policyrep work is done. That will ease the migration and can be done
> far more easily than fixing the current compiler.
>
> Karl
>
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
