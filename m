Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7BI7XZE007323
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 14:07:33 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7BI7VaG026066
	for <selinux@tycho.nsa.gov>; Sat, 11 Aug 2007 18:07:32 GMT
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 11 Aug 2007 20:07:30 +0200
From: selinux770@tortenboxer.de
In-Reply-To: <20070810141236.128070@gmx.net>
Message-ID: <20070811180730.308640@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>	
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810121259.128050@gmx.net>	
 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810130703.128070@gmx.net>
 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>
 <20070810141236.128070@gmx.net>
Subject: Re: wrong magic number (using old sources)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again,

unfortunately, the problem persists. I've compiled the current stable package and put the files on the target syste... the error is still "wrong magic number"...
I also recompiled the kernel... btw... is this necessary each time i change the SELinux libraries versions? I did that too many times the last week ;-)

I've got to confess it was just a quick shot, maybe i forgot something, but I don't think so. I'll retry it on monday once a again, but I'm not very confident.

Is there some non-SELinux related library that may be responsible for this error? How is the magic number generated? How is it checked? Is some calculation or transformation performed on this number by other libraries? Since I cross-compile all the packages it may be the case that some libraries differ on the compiling system and the using system. It would be helpful to have a list to check these packages/libraries against inconsistencies that may be responsible for that.... 

-------- Original-Nachricht --------
Datum: Fri, 10 Aug 2007 16:12:36 +0200
Von: selinux770@tortenboxer.de
An: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Betreff: Re: wrong magic number (using old sources)

> > > Then i think it's 
> > > selinux-policy-default_1.26-7 or
> > > selinux-policy-default_1.26
> > > 
> > > I'm not really sure about that, because the policy was not written by
> > me. It's only for testing. If the version of the policy is relevant,
> this
> > might by the most probable error. Which version has the policyto be (at
> least)
> >  to work with the (old) packages I mentioned?
> > 
> > That should be fine; you'd only run into problems if using newer
> > reference policy versions with that older checkpolicy.
> > 
> > I'd suggest sending me a copy of your policy.conf and policy.20
> > off-list, and ideally giving me the precise URLs where I can find
> > the .tar.gz files that you used as your baseline.  Then I can try to
> > re-create the bug.
> 
> Ok, I just tried to compile the up-to-date stable package from the nsa
> page. Compiling seems to work with the help you provided. Thanks again for
> that.
> 
> I will now try to bring the system up now with the new packages. This
> might take some days. I'll notify you about results.
> -- 
> Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
> Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
