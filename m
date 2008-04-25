Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3PHQUs7008805
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 13:26:30 -0400
Received: from web63011.mail.re1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3PHQTef022139
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 17:26:29 GMT
Date: Fri, 25 Apr 2008 10:26:13 -0700 (PDT)
From: run zhang <zhang4run@yahoo.com>
Subject: Re: labelling with genfscon
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1209126530.26761.95.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-408860394-1209144373=:53592"
Message-ID: <621160.53592.qm@web63011.mail.re1.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-408860394-1209144373=:53592
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I am working on 2.6.21.1. 
  Thanks!
  

Stephen Smalley <sds@tycho.nsa.gov> wrote:
  
On Thu, 2008-04-24 at 13:30 -0700, run zhang wrote:
> Thanks Stephen for the clarifying.
> So where can I find the patch you mentioned? I want to try it.

It will have to be re-based as it no longer applies to a current kernel.
What kernel version are you using as your baseline?

> Also, I will try with the new feature of NFSv4. 

Those changes aren't upstreamed yet; the labeled NFS work is still in
progress.

> 
> Stephen Smalley wrote:
> 
> On Wed, 2008-04-23 at 12:07 -0700, run zhang wrote:
> > In the NSA example policy package, the genfs_contexts
> explains that
> > except /proc, all other filesystems without xattr support
> are limited
> > to a single entry /. Can I specify the subdirs of a
> filesystem with
> > different lables with genfscon just like /proc? 
> > More specifically, I am using NFS and cramfs, where I
> specify 
> > genfscon nfs / root_t
> > genfscon nfs /bin bin_t
> > 
> > However, after boot and load the result policy, still every
> dir in
> > rootfs is labelled with root_t. It seems the same result for
> cramfs.
> > According this thread:
> > http://marc.info/?l=selinux&m=102587231814793&w=2, it seems
> that this
> > should be doable. 
> > Please give hand, thanks very much!
> 
> At the time of that thread, SELinux did support use of
> genfs_contexts
> for other filesystem types. However, that support was dropped
> because
> a) we couldn't provide strong guarantees about such labeling
> for other
> filesystem types (in the case of proc, we can generate an
> unambiguous
> and immutable pathname from the internal kernel data
> structures to use
> as a key; most other filesystem types would suffer from
> aliasing and
> userspace-manipulation issues), and b) it was frowned upon by
> the vfs
> folks as unacceptable for merging selinux into mainline. It
> was
> nonetheless a relatively simple patch to SELinux to support it
> if you
> are willing to patch your kernel.
> 
> For NFS, you are currently limited to per-mount granularity
> (using the
> mount context= option) or the default genfscon label. There is
> ongoing
> work on labeled NFSv4 support to provide native support for
> per-file
> labeling.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
> 
> 
> ______________________________________________________________________
> Be a better friend, newshound, and know-it-all with Yahoo! Mobile. Try
> it now.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.




       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-408860394-1209144373=:53592
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I am working on 2.6.21.1. </div>  <div>Thanks!</div>  <div><BR><BR><B><I>Stephen Smalley &lt;sds@tycho.nsa.gov&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>On Thu, 2008-04-24 at 13:30 -0700, run zhang wrote:<BR>&gt; Thanks Stephen for the clarifying.<BR>&gt; So where can I find the patch you mentioned? I want to try it.<BR><BR>It will have to be re-based as it no longer applies to a current kernel.<BR>What kernel version are you using as your baseline?<BR><BR>&gt; Also, I will try with the new feature of NFSv4. <BR><BR>Those changes aren't upstreamed yet; the labeled NFS work is still in<BR>progress.<BR><BR>&gt; <BR>&gt; Stephen Smalley <SDS@TYCHO.NSA.GOV>wrote:<BR>&gt; <BR>&gt; On Wed, 2008-04-23 at 12:07 -0700, run zhang wrote:<BR>&gt; &gt; In the NSA example policy package, the genfs_contexts<BR>&gt; explains that<BR>&gt; &gt; except /proc, all other filesystems without xattr
 support<BR>&gt; are limited<BR>&gt; &gt; to a single entry /. Can I specify the subdirs of a<BR>&gt; filesystem with<BR>&gt; &gt; different lables with genfscon just like /proc? <BR>&gt; &gt; More specifically, I am using NFS and cramfs, where I<BR>&gt; specify <BR>&gt; &gt; genfscon nfs / root_t<BR>&gt; &gt; genfscon nfs /bin bin_t<BR>&gt; &gt; <BR>&gt; &gt; However, after boot and load the result policy, still every<BR>&gt; dir in<BR>&gt; &gt; rootfs is labelled with root_t. It seems the same result for<BR>&gt; cramfs.<BR>&gt; &gt; According this thread:<BR>&gt; &gt; http://marc.info/?l=selinux&amp;m=102587231814793&amp;w=2, it seems<BR>&gt; that this<BR>&gt; &gt; should be doable. <BR>&gt; &gt; Please give hand, thanks very much!<BR>&gt; <BR>&gt; At the time of that thread, SELinux did support use of<BR>&gt; genfs_contexts<BR>&gt; for other filesystem types. However, that support was dropped<BR>&gt; because<BR>&gt; a) we couldn't provide strong guarantees about such
 labeling<BR>&gt; for other<BR>&gt; filesystem types (in the case of proc, we can generate an<BR>&gt; unambiguous<BR>&gt; and immutable pathname from the internal kernel data<BR>&gt; structures to use<BR>&gt; as a key; most other filesystem types would suffer from<BR>&gt; aliasing and<BR>&gt; userspace-manipulation issues), and b) it was frowned upon by<BR>&gt; the vfs<BR>&gt; folks as unacceptable for merging selinux into mainline. It<BR>&gt; was<BR>&gt; nonetheless a relatively simple patch to SELinux to support it<BR>&gt; if you<BR>&gt; are willing to patch your kernel.<BR>&gt; <BR>&gt; For NFS, you are currently limited to per-mount granularity<BR>&gt; (using the<BR>&gt; mount context= option) or the default genfscon label. There is<BR>&gt; ongoing<BR>&gt; work on labeled NFSv4 support to provide native support for<BR>&gt; per-file<BR>&gt; labeling.<BR>&gt; <BR>&gt; -- <BR>&gt; Stephen Smalley<BR>&gt; National Security Agency<BR>&gt; <BR>&gt; <BR>&gt; --<BR>&gt; This
 message was distributed to subscribers of the selinux<BR>&gt; mailing list.<BR>&gt; If you no longer wish to subscribe, send mail to<BR>&gt; majordomo@tycho.nsa.gov with<BR>&gt; the words "unsubscribe selinux" without quotes as the message.<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; ______________________________________________________________________<BR>&gt; Be a better friend, newshound, and know-it-all with Yahoo! Mobile. Try<BR>&gt; it now.<BR>-- <BR>Stephen Smalley<BR>National Security Agency<BR><BR><BR>--<BR>This message was distributed to subscribers of the selinux mailing list.<BR>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<BR>the words "unsubscribe selinux" without quotes as the message.<BR></BLOCKQUOTE><BR><BR><BR><p>&#32;



      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-408860394-1209144373=:53592--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
