Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1N5uNdW028236
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 00:56:23 -0500 (EST)
Received: from mail02.infosat.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1N5pVrg004219
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 05:51:37 GMT
Received: from [196.38.110.14] (HELO mail01.infosat.net)
  by mail02.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with ESMTP id 208171756 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 07:53:38 +0200
Received: from [66.18.72.157] (HELO hivsa.com)
  by mail01.infosat.net (CommuniGate Pro SMTP 4.1.8)
  with SMTP id 646214973 for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 07:53:36 +0200
From: Jayendren Anand Maduray <jayendren@hivsa.com>
Reply-To: jayendren@mweb.co.za
To: jayendren@mweb.co.za, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: fc3 - password change problem - syslog and portmapper
Date: Wed, 23 Feb 2005 09:52:18 +0200
References: <200502220809.40631.jayendren@hivsa.com> <200502221244.44315.jayendren@hivsa.com> <20050222121127.GH14038@lkcl.net>
In-Reply-To: <20050222121127.GH14038@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502230952.18953.jayendren@hivsa.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 22 February 2005 14:11, Luke Kenneth Casson Leighton wrote:
thanks!
i do have vmware, i will try that out.

> On Tue, Feb 22, 2005 at 12:44:44PM +0200, Jayendren Anand Maduray wrote:
> > On Tuesday 22 February 2005 12:21, you wrote:
> > ic, well i did not compile it, and it does not work with the previous
> > kernel - 2.6.9
>
>  are you saying that out-of-the-box, you installed FC3, selected
>  on the anaconda install program the option to enable selinux,
>  and that you selected to "enable" rather than "warn" i think
>  that's the option...
>
>  ... and having done that, it _didn't_ work?
>
>  because if so, that is very very odd, and you should resolve to
>  fix _that_ rather than going to other lengths such as installing
>  a 2.6.10 kernel or installing policy from source.
>
> > do u suggest that i remove it, and compile it from scratch?
>
>  no, i'm suggesting that you resolve the initial problem with
>  your install (by reinstalling if necessary - do you have vmware
>  or a spare machine?)
>
>  and if necessary, raising a bug on redhat's bug tracking site.
>
>  l.
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.

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
