Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6BF0CO3003518
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2012 11:00:12 -0400
Message-ID: <1342018753.29461.39.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SE Android: Install-time MAC update, possible merge to seandroid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Wed, 11 Jul 2012 10:59:13 -0400
In-Reply-To: <1340723142.29157.40.camel@moss-pluto.epoch.ncsc.mil>
References: <1340723142.29157.40.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-06-26 at 11:05 -0400, Stephen Smalley wrote:
> Hi,
> 
> The install-time MAC support has been updated to allow one to specify
> seinfo strings based on the app certificates in the mac_permissions.xml
> configuration and then map those seinfo string values to SELinux
> security contexts in the seapp_contexts configuration.  This replaces
> the fixed, hardcoded seinfo=systemApp selector (based on whether the app
> was from the system partition) with a more flexible scheme based on
> certificates.  The example mac_permissions.xml configuration defines
> seinfo= strings for each of the AOSP build keys (platform, media,
> shared, release), and the seapp_contexts configuration maps each of
> these seinfo strings to a distinct SELinux domain (replacing the old
> trusted_app domain).  These changes are on the mac-install feature
> branch and merged onto the mmac branch.
> 
> We are contemplating merging the install-time MAC support onto the main
> seandroid branch as this now provides enhanced capabilities for SELinux
> policy and creates a linkage between the two mechanisms.  The permission
> revocation and tag propagation mechanisms would remain separate.
> Comments and feedback on this enhancement and on the proposed merge are
> welcome.

The install-time MAC support has been merged onto the main seandroid
(and seandroid-4.0.4) branch.  Thus, it is no longer necessary to use
the mmac or mmac-4.0.4 branch in order to obtain the install-time MAC
functionality.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
