Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96KPmrT008785
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 16:25:48 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96KOdnN026106
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 20:24:39 GMT
Subject: Re: Today's Diffs.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4164315F.40803@redhat.com>
References: <4164315F.40803@redhat.com>
Content-Type: text/plain
Message-Id: <1097094279.3364.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 16:24:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2004-10-06 at 13:54, Daniel J Walsh wrote:
> I added a rpm.te for targeted policy.  This will allow snmpd to work 
> correctly and read the /var/lib/rpm files.  Doing this required me
> to break out the distro specific files at the bottom of the rpm.fc file 
> into a distro.fc file.
> 
> Added reiserfs changes
> 
> Added getty access to initrc_devpts_t.
> 
> Some fixes for i18n.
> 
> Minor fixes for inetd_child stuff.
> 
> Fixes for rpm_script.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
