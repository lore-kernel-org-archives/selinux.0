Message-ID: <SNT139-w484C3469CDD20572093639ABEB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_4e7a7021-62f4-4a18-bcac-65bd287421ad_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: How the native device nodes of /dev/* get relabeled?
Date: Fri, 28 May 2010 08:53:10 +0000
In-Reply-To: <1274790919.2742.33.camel@moss-pluto.epoch.ncsc.mil>
References: 
 <SNT139-w43C25DEB5952D5BB6F5452ABE80@phx.gbl>,<1274790919.2742.33.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_4e7a7021-62f4-4a18-bcac-65bd287421ad_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit




> Subject: Re: How the native device nodes of /dev/* get relabeled?
> From: sds@tycho.nsa.gov
> To: harrytaurus2002@hotmail.com
> CC: selinux@tycho.nsa.gov
> Date: Tue, 25 May 2010 08:35:19 -0400
> 
> On Tue, 2010-05-25 at 06:01 +0000, TaurusHarry wrote:
> > Hi SELinux experts,
> > 
> > Thanks for reading my question. I know the whole file system could be
> > relabeled if we touch /.autorelabel, then during system boots up
> > rc.sysinit will go on to call relabel_selinux() function to fix the
> > label for the whole file system, however, this happens after
> > rc.sysinit has called start_udev, which will mount tmpfs onto /dev/
> > and take the responsibility to restorecon it properly. So how do we
> > make sure those native device nodes under /dev/* such as /dev/console
> > and /dev/null being properly labeled? They would be accessed by the
> > hostname or mount program before rc.sysinit calls start_udev(when the
> > tmpfs has not been mounted and labeled on /dev/).
> 
> Once policy has been loaded, you can run restorecon -R /dev to fix up
> the labels of any device nodes that were previously created; rc.sysinit
> does that in Fedora, but you could take it earlier in the initialization
> process, anytime after policy load (you could do it from the initramfs
> script right after policy load).
> 

Thanks Stephen!

Now I understand the purpose of the initramfs script of "_restorecon" on my Ubuntu desktop - it is to relabel the raw /dev/ directory after the "_load_policy" initramfs script loaded SELinux policy image. I have taken Fedora's approach and make rc.sysinit relabel /dev/console and /dev/null properly before tmpfs is mounted on /dev/ by the start_udev script.

Best regards,
Harry

> Otherwise, you have to just allow certain domains to access the default
> type applied to the initial /dev nodes (e.g. tmpfs_t if it is a tmpfs
> mount or a devtmpfs mount). refpolicy does this via
> fs_rw_tmpfs_chr_files() for certain domains, including init_t, initrc_t,
> mount_t, hotplug_t.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
_________________________________________________________________
SkyDrive电子画册，带你领略精彩照片，分享“美”时“美”刻!
http://www.windowslive.cn/campaigns/e-magazine/ngmchina/?a=c
--_4e7a7021-62f4-4a18-bcac-65bd287421ad_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
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
--></style>
</head>
<body class='hmmessage'>
<br><br>&gt; Subject: Re: How the native device nodes of /dev/* get relabeled?<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: harrytaurus2002@hotmail.com<br>&gt; CC: selinux@tycho.nsa.gov<br>&gt; Date: Tue, 25 May 2010 08:35:19 -0400<br>&gt; <br>&gt; On Tue, 2010-05-25 at 06:01 +0000, TaurusHarry wrote:<br>&gt; &gt; Hi SELinux experts,<br>&gt; &gt; <br>&gt; &gt; Thanks for reading my question. I know the whole file system could be<br>&gt; &gt; relabeled if we touch /.autorelabel, then during system boots up<br>&gt; &gt; rc.sysinit will go on to call relabel_selinux() function to fix the<br>&gt; &gt; label for the whole file system, however, this happens after<br>&gt; &gt; rc.sysinit has called start_udev, which will mount tmpfs onto /dev/<br>&gt; &gt; and take the responsibility to restorecon it properly. So how do we<br>&gt; &gt; make sure those native device nodes under /dev/* such as /dev/console<br>&gt; &gt; and /dev/null being properly labeled? They would be accessed by th!
 e<br>&gt; &gt; hostname or mount program before rc.sysinit calls start_udev(when the<br>&gt; &gt; tmpfs has not been mounted and labeled on /dev/).<br>&gt; <br>&gt; Once policy has been loaded, you can run restorecon -R /dev to fix up<br>&gt; the labels of any device nodes that were previously created; rc.sysinit<br>&gt; does that in Fedora, but you could take it earlier in the initialization<br>&gt; process, anytime after policy load (you could do it from the initramfs<br>&gt; script right after policy load).<br>&gt; <br><br>Thanks Stephen!<br><br>Now I understand the purpose of the initramfs script of "_restorecon" on my Ubuntu desktop - it is to relabel the raw /dev/ directory after the "_load_policy" initramfs script loaded SELinux policy image. I have taken Fedora's approach and make rc.sysinit relabel /dev/console and /dev/null properly before tmpfs is mounted on /dev/ by the start_udev script.<br><br>Best regards,<br>Harry<br><br>&gt; Otherwise, you have to just allo!
 w certain domains to access the default<br>&gt; type applied to the in
itial /dev nodes (e.g. tmpfs_t if it is a tmpfs<br>&gt; mount or a devtmpfs mount). refpolicy does this via<br>&gt; fs_rw_tmpfs_chr_files() for certain domains, including init_t, initrc_t,<br>&gt; mount_t, hotplug_t.<br>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  <br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://3g.msn.cn/' target='_new'>立刻下载！</a></body>
</html>
--_4e7a7021-62f4-4a18-bcac-65bd287421ad_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
