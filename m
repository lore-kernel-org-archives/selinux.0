Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3OKV3VM019004
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 16:31:03 -0400
Received: from web63006.mail.re1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3OKV2ft010787
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 20:31:02 GMT
Date: Thu, 24 Apr 2008 13:30:57 -0700 (PDT)
From: run zhang <zhang4run@yahoo.com>
Subject: Re: labelling with genfscon
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1209040207.15796.386.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1456839550-1209069057=:57048"
Message-ID: <294258.57048.qm@web63006.mail.re1.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1456839550-1209069057=:57048
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Stephen for the clarifying.
  So where can I find the patch you mentioned? I want to try it.
  Also, I will try with the new feature of NFSv4. 
   
  

Stephen Smalley <sds@tycho.nsa.gov> wrote:
  
On Wed, 2008-04-23 at 12:07 -0700, run zhang wrote:
> In the NSA example policy package, the genfs_contexts explains that
> except /proc, all other filesystems without xattr support are limited
> to a single entry /. Can I specify the subdirs of a filesystem with
> different lables with genfscon just like /proc? 
> More specifically, I am using NFS and cramfs, where I specify 
> genfscon nfs / root_t
> genfscon nfs /bin bin_t
> 
> However, after boot and load the result policy, still every dir in
> rootfs is labelled with root_t. It seems the same result for cramfs.
> According this thread:
> http://marc.info/?l=selinux&m=102587231814793&w=2, it seems that this
> should be doable. 
> Please give hand, thanks very much!

At the time of that thread, SELinux did support use of genfs_contexts
for other filesystem types. However, that support was dropped because
a) we couldn't provide strong guarantees about such labeling for other
filesystem types (in the case of proc, we can generate an unambiguous
and immutable pathname from the internal kernel data structures to use
as a key; most other filesystem types would suffer from aliasing and
userspace-manipulation issues), and b) it was frowned upon by the vfs
folks as unacceptable for merging selinux into mainline. It was
nonetheless a relatively simple patch to SELinux to support it if you
are willing to patch your kernel.

For NFS, you are currently limited to per-mount granularity (using the
mount context= option) or the default genfscon label. There is ongoing
work on labeled NFSv4 support to provide native support for per-file
labeling.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-1456839550-1209069057=:57048
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Thanks Stephen&nbsp;for the clarifying.</div>  <div>So where can I&nbsp;find the patch you mentioned? I want to try it.</div>  <div>Also, I will try with the new feature of NFSv4. </div>  <div>&nbsp;</div>  <div><BR><BR><B><I>Stephen Smalley &lt;sds@tycho.nsa.gov&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On Wed, 2008-04-23 at 12:07 -0700, run zhang wrote:<BR>&gt; In the NSA example policy package, the genfs_contexts explains that<BR>&gt; except /proc, all other filesystems without xattr support are limited<BR>&gt; to a single entry /. Can I specify the subdirs of a filesystem with<BR>&gt; different lables with genfscon just like /proc? <BR>&gt; More specifically, I am using NFS and cramfs, where I specify <BR>&gt; genfscon nfs / root_t<BR>&gt; genfscon nfs /bin bin_t<BR>&gt; <BR>&gt; However, after boot and load the result policy, still every dir in<BR>&gt; rootfs is labelled with
 root_t. It seems the same result for cramfs.<BR>&gt; According this thread:<BR>&gt; http://marc.info/?l=selinux&amp;m=102587231814793&amp;w=2, it seems that this<BR>&gt; should be doable. <BR>&gt; Please give hand, thanks very much!<BR><BR>At the time of that thread, SELinux did support use of genfs_contexts<BR>for other filesystem types. However, that support was dropped because<BR>a) we couldn't provide strong guarantees about such labeling for other<BR>filesystem types (in the case of proc, we can generate an unambiguous<BR>and immutable pathname from the internal kernel data structures to use<BR>as a key; most other filesystem types would suffer from aliasing and<BR>userspace-manipulation issues), and b) it was frowned upon by the vfs<BR>folks as unacceptable for merging selinux into mainline. It was<BR>nonetheless a relatively simple patch to SELinux to support it if you<BR>are willing to patch your kernel.<BR><BR>For NFS, you are currently limited to per-mount
 granularity (using the<BR>mount context= option) or the default genfscon label. There is ongoing<BR>work on labeled NFSv4 support to provide native support for per-file<BR>labeling.<BR><BR>-- <BR>Stephen Smalley<BR>National Security Agency<BR><BR><BR>--<BR>This message was distributed to subscribers of the selinux mailing list.<BR>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>the words "unsubscribe selinux" without quotes as the message.<BR></BLOCKQUOTE><BR><p>&#32;

      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-1456839550-1209069057=:57048--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
