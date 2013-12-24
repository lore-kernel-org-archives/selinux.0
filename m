Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBO43lXm003729
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 23:03:47 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so2559358lam.25
 for <selinux@tycho.nsa.gov>; Mon, 23 Dec 2013 20:03:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1312240933320.22187@tundra.namei.org>
References: <3917996.DVt9Qik8HG@sifl> <1678336.HYoZuQ9LME@sifl>
 <alpine.LRH.2.02.1312240933320.22187@tundra.namei.org>
Date: Mon, 23 Dec 2013 23:03:44 -0500
Message-ID: <CACLa4ptKh-kkwz2u2bt3YQM-bqcw0R=nbq7_Jqm6-iZtUHQMow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for 3.13 (part three)
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Why?  The SELinux tree should not be rebasing patches or merging
random snapshots in Linus' tree...

On Mon, Dec 23, 2013 at 5:34 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 23 Dec 2013, Paul Moore wrote:
>
>> On Wednesday, December 18, 2013 05:04:26 PM Paul Moore wrote:
>> > Hi James,
>> >
>> > Two more small patches for 3.13-rcX.  Both fix long standing issues, and
>> > both should be very uncontroversial.  FYI, I've left my previous sent
>> > 3.13-rcX fixes in the tree below, including the revert patch that Linus did
>> > himself before it could flow from the SELinux tree.
>> >
>
> Can you make a new branch for me to pull from, based on current Linus?
>
>
> --
> James Morris
> <jmorris@namei.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
