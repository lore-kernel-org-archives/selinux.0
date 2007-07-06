Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l66Db6bP019768
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 09:37:06 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l66Db5ip003307
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 13:37:05 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l66DY6V9008277
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 09:34:06 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l66DY69P008276
	for selinux@tycho.nsa.gov; Fri, 6 Jul 2007 09:34:06 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l66Admun009294
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 06:39:48 -0400
Received: from web34805.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l66Adlip009830
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2007 10:39:47 GMT
Date: Fri, 6 Jul 2007 11:39:46 +0100 (BST)
From: Louis Lam <lshoujun@yahoo.com>
Subject: Re: Newbie: Using SELINUX to contain vmware
To: Ken YANG <spng.yang@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <468E12BB.7090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <896266.60611.qm@web34805.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Ken,

Thank you for your replies. I'll try that out.

About my system. My target is to use RHEL 5. But i have no restrictions to use FC either.

Pardon my ignorance, btw, what do you mean by the "upstream" vmware policy? Where may I be able to
get it?

Thanks in advance,
Louis


--- Ken YANG <spng.yang@gmail.com> wrote:

> Louis Lam wrote:
> > Hi All,
> > 
> > I'm trying to use SELINUX to contain vmware. I'm a newbie to the "newer" modules based SELINUX
> > under RHEL5/CenTOS5. I can see that there is a vmware.if defined but don't know how to build
> the
> > module vmware.pp. Not even sure if i'm on the correct track doing this. pl advice.
> 
> what is your system? in fedora, there is vmware module at default:
> 
> -(:17:48:$)-> sudo semodule -l|grep vmware
> vmware  1.1.1
> 
> if your policy have not vmware module, you can build it from policy source:
> 
> # cd "dir containg your vmware source policy"
> (vmware.fc, vmware.te, vmware.if)
> 
> # make -f /usr/share/selinux/devel/Makefile
> (you must install selinux-policy-devel package first)
> 
> # semodule -i vmware.pp
> # restorecon -R -v "vmware relative directories"
> 
> 
> > 
> > I'm trying to use SELINUX to contain the free vmplayer 2.0.0 downloadable from vmware site.
> Has
> > anyone succeeded in doing so? Maybe can point me to the right resources. Thanks.
> 
> through upstream vmware policy, i can run vmware-workstation 6 smoothly,
> so i think vmplayer 2.0.0 is also ok.
> 
> 
> > 
> > Thanks in Advance,
> > Louis
> > 
> > Send instant messages to your online friends http://uk.messenger.yahoo.com 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


Send instant messages to your online friends http://uk.messenger.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
