Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: pppd with ipppd
Date: Mon, 9 Sep 2002 22:36:02 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au> <20020909200540.D0833FAC1@ivanova.coker.com.au>
In-Reply-To: <20020909200540.D0833FAC1@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200209092236.02733.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Sep 2002 22:00, Carsten Grohmann wrote:
> Am Sonntag, 8. September 2002 22:34 schrieb Russell Coker:
> > On Sun, 8 Sep 2002 22:00, Carsten Grohmann wrote:
> > > > Why does ipppd need to run "ifconfig" while the regular pppd doesn't?
> > > >  Or is it some script that calls ifconfig?
> > >
> > > ifconfig is uesing by the SuSE ip-(up|down) scripts. You can remove the
> > > complete ifconfig section.
> >
> > Or could just have "can_exec(pppd_t, ifconfig_exec_t)"...
>
> If you don't need it, I would don't add this to the general rules. For my

I think that there's no reason not to add it.  I use ifconfig in a similar 
manner on some of my machines (which aren't using SE Linux yet), so there is 
definately a use for it on non-SUSE machines.  I'll add it to my policy now.

> SuSE rules I would add this in a seperate file (pppd_suse.(te|fc)) like the
> other SuSE specific settings.

Now this is an issue.  Up until now we have had two branches of policy, my 
Debian policy and the Red Hat policy, and we have been putting things in 
rpm.te and dpkg.te.

If SUSE is doing the same thing as Red Hat in this regard (I get the 
impression that no-one is doing anything serious with Red Hat and SE Linux 
apart from NSA people, and they don't use dial-up networking - so it could be 
that Red Hat has the same issue but no-one noticed it) then it can go in 
rpm.te.  Otherwise what do we do?

Having pppd_suse.te, crond_suse.te, etc will get ugly very quickly.

I suggest having suse.te for all the SUSE specific policy.  It can have policy 
for all the different programs with appropriate ifdef()'s around them.

Also if we do that then perhaps we should have a redhat.te and move some of 
the stuff out of rpm.te, and change some of the "ifdef(`rpm.te'," statements 
to "ifdef(`redhat.te',".

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
