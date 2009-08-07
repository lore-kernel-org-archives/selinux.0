Message-ID: <COL109-W33EAFD3ECB726B75FBEA16AB0B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6bebb8cd-3512-4181-8f4a-5ec1eeb72c3f_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A question about selinux userspace tools
Date: Fri, 7 Aug 2009 02:04:08 +0000
In-Reply-To: <1249560616.5213.25.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
 	 <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W364E77A3A4C0B0811DD604AB0A0@phx.gbl>
 <1249560616.5213.25.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_6bebb8cd-3512-4181-8f4a-5ec1eeb72c3f_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Smalley,

My laptop is i686.

Is there anything I could do to facilitate reproducing the same issue on your side?

Cheers,

Harry


> Subject: RE: A question about selinux userspace tools
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Date: Thu, 6 Aug 2009 08:10:16 -0400
> 
> On Thu, 2009-08-06 at 01:33 +0000, TaurusHarry wrote:
> > Hey Smalley,
> > 
> > On my laptop. both RAM and swap are about 4G bytes, and the
> > overcomit_memory is 0 while the overcommit_ration is 50.
> > 
> > Is it possible to tune these vm settings in some way so that
> > bzip-blocksize=4 or 9 would succeed in building a policy store?
> 
> That's curious, as I've tested on a much smaller memory configuration (a
> VM with 512M RAM, 1G swap) without any problems using the same
> overcommit settings.
> 
> Is your arch i686 or x86_64?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

_________________________________________________________________
张三挖到了元宝,小美又掉进陷阱了,快来MClub与好友齐乐乐！立刻访问！
http://club.msn.cn/?from=3
--_6bebb8cd-3512-4181-8f4a-5ec1eeb72c3f_
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
Hi Smalley,<br><br>My laptop is i686.<br><br>Is there anything I could do to facilitate reproducing the same issue on your side?<br><br>Cheers,<br><br>Harry<br><br><br>&gt; Subject: RE: A question about selinux userspace tools<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Date: Thu, 6 Aug 2009 08:10:16 -0400<br>&gt; <br>&gt; On Thu, 2009-08-06 at 01:33 +0000, TaurusHarry wrote:<br>&gt; &gt; Hey Smalley,<br>&gt; &gt; <br>&gt; &gt; On my laptop. both RAM and swap are about 4G bytes, and the<br>&gt; &gt; overcomit_memory is 0 while the overcommit_ration is 50.<br>&gt; &gt; <br>&gt; &gt; Is it possible to tune these vm settings in some way so that<br>&gt; &gt; bzip-blocksize=4 or 9 would succeed in building a policy store?<br>&gt; <br>&gt; That's curious, as I've tested on a much smaller memory configuration (a<br>&gt; VM with 512M RAM, 1G swap) without any problems using the same<br>&gt; overcommit settings.<br!
 >&gt; <br>&gt; Is your arch i686 or x86_64?<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br><br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_6bebb8cd-3512-4181-8f4a-5ec1eeb72c3f_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
