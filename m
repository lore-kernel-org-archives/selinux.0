Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MAtDdW021818
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 05:55:13 -0500 (EST)
Received: from mail02.infosat.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MAqoZG020866
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 10:52:56 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 207556824 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 12:45:58 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 644728958 for selinux@tycho.nsa.gov; Tue, 22 Feb 2005 12:45:55 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Tue, 22 Feb 2005 12:44:44 +0200
References: <200502220809.40631.jayendren@hivsa.com> <200502221149.59288.jayendren@hivsa.com> <20050222102113.GE14038@lkcl.net>
In-Reply-To: <20050222102113.GE14038@lkcl.net>
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502221244.44315.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 12:21, you wrote:
ic, well i did not compile it, and it does not work with the previous kernel - 
2.6.9
do u suggest that i remove it, and compile it from scratch?

> okay, (i should have also asked you these originally)
>
> does it work with the standard kernel?
> 2.6.9-777889999somethingorother.
>
> have you put the targetted policy source code on (and compiled it
> yourself) or are you using the "standard" binary targetted policy?
>
> i.e. can you get things working from the "known" standard - and support,
> and tested, and approved - state, and then work from there?
>
> in particular, you need to ask yourself: _why_ do you need a
> 2.6.10 kernel, is there a specific reason, other than curiosity?
>
> if the standard targetted policy package, standard 2.6.9-77889899rubbish
> kernel works, why change it?
>
> l.
>
> On Tue, Feb 22, 2005 at 11:49:59AM +0200, Jayendren Anand Maduray wrote:
> > On Tuesday 22 February 2005 11:15, Luke Kenneth Casson Leighton
> > <lkcl@lkcl.net>
> >
> > wrote:
> > > On Tue, Feb 22, 2005 at 08:09:40AM +0200, Jayendren Anand Maduray wrote:
> > > > Hi!
> > > >
> > > > Got FC3 running SELINUX in enforcing mode.
> > >
> > >  you brave person :)
> > >
> > >  which policy - targetted or strict?
> > >
> > >  [remember to tell the list not me]
> >
> > ....
> > brave, i prefer fc3 to other distros, second best is redhat, hence fc3.
> > it is targeted.
> > ;)
> >
> > --
> > Jayendren Anand Maduray
> > Microsoft Certified Professional
> > Network Plus
> > IT Administrator
> >
> > Perinatal HIV Research Unit
> > Old Potch Road
> > Chris Hani Baragwanath Hospital
> > Soweto
> > South Africa
> >
> > Tel: +27 11 989 9776
> > Tel: +27 11 989 9999
> > Fax: +27 11 938 3973
> > Cel: 082 22 774 94
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with the words "unsubscribe selinux" without quotes as the message.

-- 
Jayendren Anand Maduray
Microsoft Certified Professional
Network Plus
IT Administrator  

Perinatal HIV Research Unit
Old Potch Road
Chris Hani Baragwanath Hospital
Soweto
South Africa

Tel: +27 11 989 9776
Tel: +27 11 989 9999
Fax: +27 11 938 3973
Cel: 082 22 774 94

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
