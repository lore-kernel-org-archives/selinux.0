Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA1I4xWt024568
	for <selinux@tycho.nsa.gov>; Sat, 1 Nov 2003 13:04:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA1I4dC7015469
	for <selinux@tycho.nsa.gov>; Sat, 1 Nov 2003 18:04:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hA1I4duw015466
	for <selinux@tycho.nsa.gov>; Sat, 1 Nov 2003 18:04:39 GMT
Date: Sat, 1 Nov 2003 18:04:52 +0000
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils
Message-ID: <20031101180452.GC4790@vnl.com>
References: <20031031145133.GA16818@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031031145133.GA16818@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 02:51:33PM +0000, Dale Amon wrote:
> Where did policycoreutils go to? I can seem to find it
> in the sid packages lists:
> 
> grep policycore *
> ftp.de.debian.org_debian_dists_sid_main_binary-i386_Packages:Pre-Depends: policycoreutils, checkpolicy
> www.coker.com.au_newselinux_._Packages:Pre-Depends: policycoreutils, checkpolicy
> 
> Package files:
> ftp.de.debian.org_debian_dists_sid_contrib_binary-i386_Packages
> ftp.de.debian.org_debian_dists_sid_contrib_binary-i386_Release
> ftp.de.debian.org_debian_dists_sid_main_binary-i386_Packages
> ftp.de.debian.org_debian_dists_sid_main_binary-i386_Release
> ftp.de.debian.org_debian_dists_sid_non-free_binary-i386_Packages
> ftp.de.debian.org_debian_dists_sid_non-free_binary-i386_Release
> non-us.debian.org_debian-non-US_dists_sid_non-US_contrib_binary-i386_Packages
> non-us.debian.org_debian-non-US_dists_sid_non-US_contrib_binary-i386_Release
> non-us.debian.org_debian-non-US_dists_sid_non-US_main_binary-i386_Packages
> non-us.debian.org_debian-non-US_dists_sid_non-US_main_binary-i386_Release
> non-us.debian.org_debian-non-US_dists_sid_non-US_non-free_binary-i386_Packages
> non-us.debian.org_debian-non-US_dists_sid_non-US_non-free_binary-i386_Release
> www.coker.com.au_newselinux_._Packages
> 
> /usr/bin/apt-get -y install policycoreutils selinux-policy-default
> Reading Package Lists...
> Building Dependency Tree...
> Package policycoreutils has no available version, but exists in the database.
> This typically means that the package was mentioned in a dependency and
> never uploaded, has been obsoleted or is not available with the contents
> of sources.list
> E: Package policycoreutils has no installation candidate
> 
> Any idea what's up? 

I don't know is Russ got the above question, and in any case he might
just be too busy to think about it. Does anyone else have a suggestion?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
