Message-Id: <200209101310.NAA02014@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: redhat.te and suse.te (was Re: pppd with ipppd)
Date: Tue, 10 Sep 2002 15:11:13 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <20020909200540.D0833FAC1@ivanova.coker.com.au> <200209092236.02733.russell@coker.com.au>
In-Reply-To: <200209092236.02733.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Montag, 9. September 2002 22:36 schrieb Russell Coker:
> > SuSE rules I would add this in a seperate file (pppd_suse.(te|fc)) like
> > the other SuSE specific settings.
>
> Now this is an issue.  Up until now we have had two branches of policy,
> my Debian policy and the Red Hat policy, and we have been putting things
> in rpm.te and dpkg.te.
>
> If SUSE is doing the same thing as Red Hat in this regard (I get the
> impression that no-one is doing anything serious with Red Hat and SE
> Linux apart from NSA people, and they don't use dial-up networking - so
> it could be that Red Hat has the same issue but no-one noticed it) then
> it can go in rpm.te.  Otherwise what do we do?
>
> Having pppd_suse.te, crond_suse.te, etc will get ugly very quickly.
>
> I suggest having suse.te for all the SUSE specific policy.  It can have
> policy for all the different programs with appropriate ifdef()'s around
> them.
>
> Also if we do that then perhaps we should have a redhat.te and move some
> of the stuff out of rpm.te, and change some of the "ifdef(`rpm.te',"
> statements to "ifdef(`redhat.te',".

Sound like good. And we should use the m4 macro processor for the fc files 
too.
In my eyes we needs the m4 conditionals to build simple file contexts 
files. And it will by possible to remove unused single rules (like dhcpd_t) 
without get an error ( Unkown type ...).

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
