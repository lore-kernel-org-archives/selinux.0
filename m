Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9T51MCw025980
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 01:01:22 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9T4xkrp010855
	for <selinux@tycho.nsa.gov>; Sun, 29 Oct 2006 04:59:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Graffam <michael.graffam@gmail.com>
Subject: Re: New to SELinux -- any suggestions?
Date: Sun, 29 Oct 2006 15:01:18 +1000
Cc: selinux@tycho.nsa.gov
References: <1162086080.2566.16.camel@endless> <200610291432.01272.russell@coker.com.au> <1162096212.15530.22.camel@endless>
In-Reply-To: <1162096212.15530.22.camel@endless>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200610291601.19715.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 29 October 2006 15:30, Michael Graffam <michael.graffam@gmail.com> 
wrote:
> > The problem here is your idea of "removing the permission".  Chcon does
> > not add or remove permissions, it merely changes the labels of files. 
> > What the label means is determined by the policy.
> >
> > So if you want to change a file back to it's default context you can
> > use "restorecon", in this case "restorecon -F -R -v /usr/local /usr/bin"
> > should do what you want.
>
> Thank you for the help. Can one AND/OR the contexts? Based on the above,
> it would seem to me that if an executable violated two points of policy
> it wouldn't be possible to 'bless' it -- since I'm sure this isn't the
> case, I'm wondering how I might apply multiple contexts. Or am I still
> out in left field here?

I don't know what you mean by "bless" in this message.

SE Linux does not support multiple contexts on one object.  If multiple 
contexts are supported then it becomes almost impossible to analyse the 
policy.  For example if we want to make sure that domain user_t can not write 
to any file that allows a domain transition to a domain that can write to 
the /etc/shadow file (shadow_t) then we need to make sure that there is no 
file type which is an entry point for passwd_t that is also writable by 
user_t, this is a fairly simple analysis to perform.

If however a file could have multiple types then such analysis would be 
impossible unless you also had rules determining which pairs of contexts 
might be applied to one file (in which case every permitted pair of contexts 
could be mapped to a single context in the current SE Linux system for the 
same result).

> > Another option is to know what the original context was (maybe by
> > examining the file with "ls -Z" before changing it in the first place). 
> > In this case I know that the bin directories have type bin_t, so the
> > following would work: chcon -t bin_t /usr/bin/sbcl /usr/local/bin/lisp
>
> Whooo.. new ls fields too! Man, I feel like a kid again! This is
> great! :) Having been using GNU/Linux for so long, I almost forgot how
> fun it is to learn new stuff about it!

There is also "id -Z", "ps -Z" and "cp -Z".  There are also a few new 
commands, in addition to chcon there's runcon and newrole (which isn't being 
used so much nowadays) and there is semanage and getsebool/setsebool to 
manage it.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
