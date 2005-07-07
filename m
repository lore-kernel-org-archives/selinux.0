Subject: RE: Useradd patchset - seeking comments..
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, sds@tycho.nsa.gov,
   selinux@tycho.nsa.gov
In-Reply-To: <200507072013.j67KDjQ4012679@gotham.columbia.tresys.com>
References: <200507072013.j67KDjQ4012679@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 16:27:10 -0400
Message-Id: <1120768031.6275.13.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Long term maintenance is everyone's concern 

Which is why this patch should be merged for clarity.

> Also, I don't like the style - I think that people
> start worrying about the keyword even though it is useless. Verbosity is only
> useful if it communicates something not already stated.

It communicates the storage class of the function, which I believe
is not explicitly stated anywhere. It only stated implicitly, and
programmers such as myself get confused by the lack of keyword -
there's several storage classes to choose from, and this makes it clear.
It also allows you to grep the file for extern, which you may
want to do for some reason.

You can disagree, but /usr/include/* speaks for itself - 
the vast majority of headers are explicitly marked extern, 
which establishes the dominant style.

===============

Also, we should move all headers describing functions 
not exported by the shared library into a subfolder...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
