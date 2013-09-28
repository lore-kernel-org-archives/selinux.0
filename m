Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8SDUm39015353
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2013 09:30:48 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so1738063eek.34
        for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2013 06:30:45 -0700 (PDT)
Message-ID: <1380375042.3100.1.camel@d30>
Subject: Re: File context not applied due to regex ordering
From: Dominick Grift <dominick.grift@gmail.com>
To: Laurent Bigonville <bigon@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Sat, 28 Sep 2013 15:30:42 +0200
In-Reply-To: <20130928112945.02687778@fornost.bigon.be>
References: <20130321123256.198ba5b6@soldur.bigon.be>
	 <5159AEA8.2090004@tresys.com> <20130401185508.3d15476e@fornost.bigon.be>
	 <CACLa4psh+Litc-ko0g7NhQ3BDYRX7_BX1TZqzg4uxYVhZ3VQzw@mail.gmail.com>
	 <20130402114105.1356b034@soldur.bigon.be>
	 <20130928112945.02687778@fornost.bigon.be>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2013-09-28 at 11:29 +0200, Laurent Bigonville wrote:
> Hi,
> 
> Did anybody had the time to look at this? Dominick and I have observed
> this with other file contexts as well.

Yes there is inconsistent behavior when it comes to regular expressions
in file context files. Its very confusing.


> Cheers
> 
> Laurent Bigonville
> 
> Le Tue, 2 Apr 2013 11:41:05 +0200,
> Laurent Bigonville <bigon@debian.org> a écrit :
> 
> > Le Mon, 1 Apr 2013 13:40:46 -0400,
> > Eric Paris <eparis@parisplace.org> a écrit :
> > 
> > > I feel like we talked about it...  Regex ordering is a bit tricky.
> > > I think I hacked up a patch which added an additional tie breaker
> > > step with the total number of 'non-regex' type characters being
> > > used.  It's been long lost though...
> > > 
> > > Do you still have that hack around?  Maybe we can see what others
> > > think?
> > 
> > I definitely have a bad memory...
> > 
> > I grepped my IRC logs and found this patch[0] from you at the date of
> > the 28th of Sept 2012.
> > 
> > Cheers
> > 
> > Laurent Bigonville
> > 
> > [0] http://fpaste.org/p48W/
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
