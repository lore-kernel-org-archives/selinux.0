Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGEf4xG013786
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 09:41:04 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAGEf2co001276
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 14:41:02 GMT
Subject: Re: [DSE-Dev] [martin@martinorr.name:  /selinux getattr messages]
From: Erich Schubert <erich@debian.org>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, Martin Orr <martin@martinorr.name>,
        selinux-devel@lists.alioth.debian.org
In-Reply-To: <20071116125923.GA25905@bobek.pm.i.cz>
References: <20071116125923.GA25905@bobek.pm.i.cz>
Content-Type: text/plain; charset=utf-8
Date: Fri, 16 Nov 2007 15:40:49 +0100
Message-Id: <1195224049.22415.42.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> selinux_get_fs_mount(fsadm_t)
> -> ./policy/modules/system/fstools.te
> 
> selinux_get_fs_mount(mount_t)
> -> ./policy/modules/system/mount.te

> Is such solution ok and acceptable upstream (conditionaly for
> Debian distro or so)?

That is a well-defined access control switch, so I figure it's okay, at
least if it has been checked that these aren't due to some bug in the
programs doing these commands.

You might also want to browse the changes I did to my policy.
They're all in SVN at
http://svn.debian.org/wsvn/selinux/refpolicy/branches/debian/

If you want, I can give you write access to that repository.
All you need is an alioth account and join the SELinux project there.

>From the changelog you can see that upstream revision 2337 was the last
one I merged, so you should be able to get a clean diff via SVN by
comparing that revision from upstream with my 'HEAD' revision.
I don't know if I did something to fix that audit error. Maybe I
modified one of the other macros instead to include this getattr.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
                 Friends are those who reach out for                //\
                   your hand but touch your heart.                  V_/_
   Es ist beschämender seinen Freunden zu mißtrauen als von ihnen
        getäuscht zu werden. --- François de la Rochefoucauld



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
