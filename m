Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19KOkcG006175
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 15:24:46 -0500
Received: from gregerhaga.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l19KPtYh007165
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 20:25:55 GMT
From: "Greger" <boss@gregerhaga.net>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: how to enable se linux for my app?
Date: Fri, 9 Feb 2007 22:25:48 +0200
Message-Id: <20070209202228.M65047@gregerhaga.net>
In-Reply-To: <45CCC7B0.6080109@us.ibm.com>
References: <20070209185428.M24608@gregerhaga.net> <45CCC7B0.6080109@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 09 Feb 2007 13:12:48 -0600, Michael C Thompson wrote
> Greger wrote:
> > well just a quickie:
> > I wrote an application, but can not run the linux executable nor libraries
> > when selinux is activated. what command should i use to "include" the
> > libraries and executable under selinux?
> 
> Its most likely a type enforcement issue. Your application need not 
> be "SELinux aware" for it to execute at all. However, it must be 
> labeled appropriately in the file system, with a type that is 
> executable (e.g. bin_t). Common library types are lib_t and shlib_t.
> 
> What policy are you using (strict/targeted/custom)?
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> quotes as the message.
hi, well not sure, 
I have these options in the settings dialog:
1)"upprätthållande"( swedish) means sort of "maintained or 'protected' in english)
2)"tillåtande", which means "allowing" 
3)"inactiverad", inactivated.
I'd like to have protection with the first option, but with that I can't run
the app. So, what do I need to do on the executable and libs when I install
them, to make them runnable?
many thank's for any advice.


--
http://www.gregerhaga.net/
http://hack-space.biz/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
