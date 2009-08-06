Message-ID: <COL109-W364E77A3A4C0B0811DD604AB0A0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_a0ef5359-b1da-473c-87f6-9157cb4dcab3_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A question about selinux userspace tools
Date: Thu, 6 Aug 2009 01:33:11 +0000
In-Reply-To: <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
	 <1249397076.9193.101.camel@moss-pluto.epoch.ncsc.mil>
 	 <COL109-W14E611B54676237F879250AB0D0@phx.gbl>
 <1249474151.21455.22.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_a0ef5359-b1da-473c-87f6-9157cb4dcab3_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hey Smalley,

On my laptop. both RAM and swap are about 4G bytes, and the overcomit_memory is 0 while the overcommit_ration is 50.

Is it possible to tune these vm settings in some way so that bzip-blocksize=4 or 9 would succeed in building a policy store?

Thanks!

Harry


> Subject: RE: A question about selinux userspace tools
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Date: Wed, 5 Aug 2009 08:09:11 -0400
> 
> On Wed, 2009-08-05 at 03:03 +0000, TaurusHarry wrote:
> > Hey Smalley,
> > 
> > So many thanks for giving me your help so promptly, you are such a
> > kind person !:-D
> > 
> > Yep, the quick test reveal that only with disabling bzip feature by
> > "bzip-blocksize=0" would the libsemanage-2.0.33 successfully build a
> > policy store, the option of bzip-blocksize=4 and bzip-small=true would
> > result in the same libsepol out of memeory error.
> > 
> > If there is any thing I could ever help test for you, just let me
> > know.
> 
> Thanks for testing.  Could you let us know the amount of memory and swap
> you had configured on your laptop to help with reproducing the behavior?
> And also, what your /proc/sys/vm/overcommit_memory
> and /proc/sys/vm/overcommit_ratio settings were?
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

_________________________________________________________________
张三挖到了元宝,小美又掉进陷阱了,快来MClub与好友齐乐乐！立刻访问！
http://club.msn.cn/?from=3
--_a0ef5359-b1da-473c-87f6-9157cb4dcab3_
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
Hey Smalley,<br><br>On my laptop. both RAM and swap are about 4G bytes, and the overcomit_memory is 0 while the overcommit_ration is 50.<br><br>Is it possible to tune these vm settings in some way so that bzip-blocksize=4 or 9 would succeed in building a policy store?<br><br>Thanks!<br><br>Harry<br><br><br>&gt; Subject: RE: A question about selinux userspace tools<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Date: Wed, 5 Aug 2009 08:09:11 -0400<br>&gt; <br>&gt; On Wed, 2009-08-05 at 03:03 +0000, TaurusHarry wrote:<br>&gt; &gt; Hey Smalley,<br>&gt; &gt; <br>&gt; &gt; So many thanks for giving me your help so promptly, you are such a<br>&gt; &gt; kind person !:-D<br>&gt; &gt; <br>&gt; &gt; Yep, the quick test reveal that only with disabling bzip feature by<br>&gt; &gt; "bzip-blocksize=0" would the libsemanage-2.0.33 successfully build a<br>&gt; &gt; policy store, the option of bzip-blocksize=4 and bzip-small=!
 true would<br>&gt; &gt; result in the same libsepol out of memeory error.<br>&gt; &gt; <br>&gt; &gt; If there is any thing I could ever help test for you, just let me<br>&gt; &gt; know.<br>&gt; <br>&gt; Thanks for testing.  Could you let us know the amount of memory and swap<br>&gt; you had configured on your laptop to help with reproducing the behavior?<br>&gt; And also, what your /proc/sys/vm/overcommit_memory<br>&gt; and /proc/sys/vm/overcommit_ratio settings were?<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br><br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_a0ef5359-b1da-473c-87f6-9157cb4dcab3_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
