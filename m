Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s68CUorY000517
 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2014 08:30:50 -0400
References: <53BB794B.7070206@gmail.com>
Message-ID: <1404822463.29866.YahooMailNeo@web87901.mail.ir2.yahoo.com>
Date: Tue, 8 Jul 2014 13:27:43 +0100
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: What's a 'permission map'?
To: dE <de.techno@gmail.com>
In-Reply-To: <53BB794B.7070206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This file is only required when using the "Analysis" tab features. It is fully described
in the "Help" - "Information Flow Analysis" tab.


APOL will try to find a default in your home directory called .apol_perm_mapping

There are various versions in usr/share/setools-3.3 (apol_perm_mapping_*). Best to
select the latest one and copy to home dir as .apol_perm_mapping to stop it
complaining.

It will be loaded when you do the first analysis, and can then be modified using
"Tools - "View Perm Map".



----- Original Message -----
> From: dE <de.techno@gmail.com>
> To: selinux@tycho.nsa.gov
> Cc: 
> Sent: Tuesday, 8 July 2014, 5:53
> Subject: What's a 'permission map'?
> 
>T his seems to be required by apol sometimes. Loading the default policy 
> as the permission map works, but what is permission map?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
