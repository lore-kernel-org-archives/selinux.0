Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89COWrT011063
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 08:24:32 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89CNdo3026073
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:23:40 GMT
Subject: Re: at last: info regarding boot problems on multiple partitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040908224949.GK7717@lkcl.net>
References: <20040908224949.GK7717@lkcl.net>
Content-Type: text/plain
Message-Id: <1094732553.22014.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 08:22:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-08 at 18:49, Luke Kenneth Casson Leighton wrote:
> FINALLY i got a useable system when i encountered a boot problem
> [well, i got a console login].
> 
> the issue is that partitions fail to be mounted.
> 
> i had noticed over a period of time that programs like pump and dhclient
> and some others would stop partitions from being unmounted during
> shutdown.
> 
> [remember i have /boot, /, /usr, /var and /home]
> 
> for some reason, this also caused the partitions to fail to MOUNT on
> startup.
> 
> just now i was able to log in.
> 
> audit2allow shows these:
> 
> 	allow local_login_t file_t:dir { search }
> 	allow rpcd_t file_t:dir { search }.
> 
> and, sure enough, doing a ls -Z /usr shows that it is, in fact, set to
> file_t.
> 
> the question is, therefore... why?
> 
> i figure it must be because i have that partition mounted.
> 
> consequently, the context of the mount point, /usr, never gets set
> to a correct context because, of course, make relabel is only ever
> run with all partitions mounted.
> 
> so.
> 
> my question is:
> 
> 	how do i restore the context of a mount-point....
> 	whilst it's actually mounted!

You can't.  And you should't need to do so, as nothing should require
access to the empty mount point directory except for mount itself, which
has access to search and mounton file_t.  What good would it do to allow
login or others to search the empty mount point when it is empty
anyway?  They will fail regardless, just a difference between errno of
ENOENT and EACCES.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
