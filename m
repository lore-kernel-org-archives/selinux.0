Subject: Re: avc: denied with kernel module .. someone help !!!
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, nsa <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@verbum.org>
In-Reply-To: <20041102003903.GR9643@lkcl.net>
References: <1099347144.9776.3.camel@jsingh>
	 <1099347590.9784.3.camel@jsingh>  <20041102003903.GR9643@lkcl.net>
Content-Type: text/plain
Message-Id: <1099409000.12251.17.camel@jsingh>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 20:53:20 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi ,

Sir. Stephen Smalley ... i think i badly need your help here :-(
coz this may be .. one of my last mails to selinux community ...

thanx for the mail ... Luke 

I tried what you said ... 

overlay_fs is a layer ... on top of other file-systems ... which does a
BSD unionfs kind of thing. It exposes methods to get/setxattrs and
depends upon the underlying file-systems for it. So i am successfully
able to use 'setfiles' on top of it ...

I am using it with target policies ....

I added the following line in fs_use (thanx for luke kenneth )
fs_use_xattr mini_fo system_u:object_r:fs_t;

It works fine for the unconfined_t and gives very positive results while
working as root doing normal file operations. But gives hell lot of
problems while working with apache ...

apache at-random starts considering all files and dirs as fifo_file and
start giving blank denials like -

 avc:  denied  { } for  pid=1687 exe=/usr/sbin/httpd name=home
dev=overlay_fs ino=109 scontext=root:system_r:httpd_t
tcontext=system_u:object_r:home_root_t tclass=fifo_file

on re-mounts some of the avc's disappear ..and this is random.

I can't make sense out of it .. please help..... :-((

I have come very far .. with selinux but seems like loosing all ...

help would be highly appreciated ...
Jaspreet :-(


On Tue, 2004-11-02 at 06:09, Luke Kenneth Casson Leighton wrote:
> jaspreet, hi,
> 
> is your "overlay" filesystem a proxy view of other parts of the
> filesystem?
> 
> in other words, is it a bit like doing a hard link to a directory?
> [which i know if you try to do a hard link on a directory using
> "ln" it fails]
> 
> l.
> 
> On Tue, Nov 02, 2004 at 03:49:51AM +0530, Jaspreet Singh wrote:
> > Hi,
> > 
> > sorry it was foolish of me to ask this question in the mailing list .. i
> > didn't know about audit2allow ...
> > 
> > Jaspreet
> > 
> > On Tue, 2004-11-02 at 03:42, Jaspreet Singh wrote:
> > > Hi,
> > > 
> > > I am using a overlay-fs module .. and tried setting security context on
> > > files and got this message ....
> > > 
> > >  avc:  denied  { associate } for  pid=1530 exe=/usr/sbin/setfiles
> > > name=public_html dev=overlay_fs ino=42
> > > scontext=site1-admin:object_r:httpd_site1_content_t
> > > tcontext=system_u:object_r:unlabeled_t tclass=filesystem
> > > 
> > > setenforce 0 .. allows it (obviously ;-)
> > > 
> > > I understand the message .. but don't know the steps to avoid it.
> > > 
> > > Jaspreet
> > > 
> > > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
