Message-ID: <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_54931d26-4d11-4a41-b89b-07c56a0a33f5_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A question about selinux userspace tools
Date: Wed, 5 Aug 2009 03:03:22 +0000
In-Reply-To: <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_54931d26-4d11-4a41-b89b-07c56a0a33f5_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hey Smalley,

So many thanks for giving me your help so promptly, you are such a kind person !:-D

Yep, the quick test reveal that only with disabling bzip feature by "bzip-blocksize=0" would the libsemanage-2.0.33 successfully build a policy store, the option of bzip-blocksize=4 and bzip-small=true would result in the same libsepol out of memeory error.

If there is any thing I could ever help test for you, just let me know.

Best regards,

Harry


> Subject: Re: A question about selinux userspace tools
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> Date: Tue, 4 Aug 2009 10:44:36 -0400
> 
> On Tue, 2009-08-04 at 03:11 +0000, TaurusHarry wrote:
> > Hi all,
> > 
> > I am a newcomer to SELinux and have a question about the latest
> > SELinux userspace tools.
> > 
> > Before I try to install the latest refpolicy-20090730 from tresys
> > website on Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed
> > the below latest SELinux userspace tools on the laptop:
> 
> Hi Harry,
> 
> If you could try the last version of the patch I posted for libsemanage
> configure your /etc/selinux/semanage.conf with different settings, try
> again, and see if that resolves your problem on your laptop, that would
> be helpful.
> 
> I'd suggest first trying something like:
> bzip-blocksize=4
> bzip-small=true
> 
> If that still doesn't help, then I'd suggest disabling bzip compression
> altogether via:
> bzip-blocksize=0
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

_________________________________________________________________
上Windows Live 中国首页，下载最新版Messenger！
http://www.windowslive.cn
--_54931d26-4d11-4a41-b89b-07c56a0a33f5_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Hey Smalley,<br><br>So many thanks for giving me your help so promptly, you are such a kind person !:-D<br><br>Yep, the quick test reveal that only with disabling bzip feature by "bzip-blocksize=0" would the libsemanage-2.0.33 successfully build a policy store, the option of bzip-blocksize=4 and bzip-small=true would result in the same libsepol out of memeory error.<br><br>If there is any thing I could ever help test for you, just let me know.<br><br>Best regards,<br><br>Harry<br><br><br>&gt; Subject: Re: A question about selinux userspace tools<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; Date: Tue, 4 Aug 2009 10:44:36 -0400<br>&gt; <br>&gt; On Tue, 2009-08-04 at 03:11 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi all,<br>&gt; &gt; <br>&gt; &gt; I am a newcomer to SELinux and have a question about the latest<br>&gt; &gt; SELinux userspace tools.<br>&gt; &gt; <br>&gt; &gt; Before I try to install the latest refpolicy-20090730 from tresys<br>&gt!
 ; &gt; website on Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed<br>&gt; &gt; the below latest SELinux userspace tools on the laptop:<br>&gt; <br>&gt; Hi Harry,<br>&gt; <br>&gt; If you could try the last version of the patch I posted for libsemanage<br>&gt; configure your /etc/selinux/semanage.conf with different settings, try<br>&gt; again, and see if that resolves your problem on your laptop, that would<br>&gt; be helpful.<br>&gt; <br>&gt; I'd suggest first trying something like:<br>&gt; bzip-blocksize=4<br>&gt; bzip-small=true<br>&gt; <br>&gt; If that still doesn't help, then I'd suggest disabling bzip compression<br>&gt; altogether via:<br>&gt; bzip-blocksize=0<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br><br /><hr />搜索本应是快乐的，不是么?  快乐搜索，有问必应！微软隆重推出! <a href='http://bing.com.cn?FORM=M00HCN&Publ=WLHMTAG&Crea=TEXT_Search_Where_You_Are_1X1' target='_new'>立即试用！</a></body>
</html>
--_54931d26-4d11-4a41-b89b-07c56a0a33f5_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
