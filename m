Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SBiSLa018249
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 07:44:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7SBiRet007490
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 11:44:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h7SBiQlq007487 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 11:44:26 GMT
Subject: Re: About mkinitrd ...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ripin Natani <ripinfs@hotmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <BAY8-DAV530OUIHNkjg0000040d@hotmail.com>
References: <BAY8-DAV530OUIHNkjg0000040d@hotmail.com>
Content-Type: text/plain
Message-Id: <1062071061.2517.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 28 Aug 2003 07:44:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-08-27 at 18:19, Ripin Natani wrote:
> Hi,
> I am compiling SElinux on  VMWare (VM : rh 9.0 , Host rh 9.0). I am
> using the same config file as Mark MacMillan(who has compiled SELinux
> on VMware) has sent me .
> I am getting the following error :  
>  
> "No module BusLogic found for kernel mykernel, aborting mkinitrd
> failed" 
>  
> I have installed the 'mkinitrd-3.5.8-2.src.rpm' from
> ftp://rawhide.redhat.com/pub/redhat/linux/rawhide/SRPMS/SRPMS/ 
> Also I have installed the module-init-tools-0.9.13-pre.tar.gz and
> oprofile-0.5.4.tar.gz .I have all (except nfs-tools) as required for
> SELinux (Documentation/Changes)
>  
> any clues why this is happening ? Do I need anything else ?

I don't know about the BusLogic error, but you do need to patch your
mkinitrd script as described in the selinux-doc README so that it will
set up the initrd to perform an initial policy load.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
