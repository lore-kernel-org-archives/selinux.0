Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s754jUSl028618
 for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2014 00:45:30 -0400
In-Reply-To: <F766E4F80769BD478052FB6533FA745D5944BD49F8@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D5944BD49F8@SC-VEXCH4.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: confusing policy in unconfineddomain.te SEAndroid kk4.4
From: Russell Coker <russell@coker.com.au>
Date: Tue, 05 Aug 2014 14:45:11 +1000
To: Zhi Xin <xinzhi@marvell.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <721ffab3-85ff-452b-bca6-2a2689665c9e@email.android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It means that a process can access file handles opened by another process (usually inheriting file handles from parent but sometimes exchanging them via unix domain sockets), can acces dir and file for the process (see the process in ps output) and read write named pipes created by another process.

Migh not be desirable but no doubt about what it does.

On 5 August 2014 1:41:36 PM AEST, Zhi Xin <xinzhi@marvell.com> wrote:
>Hi,
>
>Recently, I'm working on SEAndroid for kk4.4.  I found that some policy
>are confused in sepolicy/unconfineddomain.te.
>
>allow unconfineddomain domain:fd *;
>
>allow unconfineddomain domain:dir r_dir_perms;
>
>allow unconfineddomain domain:lnk_file r_file_perms;
>
>allow unconfineddomain domain:{ fifo_file file } rw_file_perms;
>
>
>
>I know sometimes object can be a domain. But when object is domain,
>should class be process ? In the examples above, the class are dir,
>lnk_file and file. How can this happen ? Does anyone know any scenario
>fit these situations ?
>
>Thanks.
>Sincerely
>Alan Xin
>
>
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to
>Selinux-request@tycho.nsa.gov.

-- 
Sent from my Samsung Galaxy Note 2 with K-9 Mail.
