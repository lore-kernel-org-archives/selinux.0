Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3SNsLC2019581
 for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2015 19:56:45 -0400
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <selinux@tycho.nsa.gov> from <zohar@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 05:23:40 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AEE7C125805A
 for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2015 05:25:37 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SNrZ8c46203122
 for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2015 05:23:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SNrYpd031661
 for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2015 05:23:35 +0530
Message-ID: <1430265211.2218.13.camel@linux.vnet.ibm.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Date: Tue, 28 Apr 2015 19:53:31 -0400
In-Reply-To: <alpine.LRH.2.11.1504271528350.16342@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <14c8ec61728.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <alpine.LRH.2.11.1504070004170.7027@namei.org> <47618041.M4z7H003Sc@sifl>
 <alpine.LRH.2.11.1504082055100.32381@namei.org>
 <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2015-04-27 at 15:28 +1000, James Morris wrote:
> On Sun, 26 Apr 2015, Paul Moore wrote:
> 
> > On Fri, Apr 24, 2015 at 6:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > James, do you suppose you could send an announcement when you
> > > do your merge? That would make it easier on the sub-tree maintainers.
> > > Just a quick "I merged the next branch to XXXX" to the LSM list.
> > 
> > That would definitely make my life a little easier.
> 
> Ok, sure.

After posting the integrity patches here, I tried applying them to
Linus' 4.1.0-rc1 branch to make sure they'll apply cleanly.  Looks like
commit c6f439d "VFS: security/: d_backing_inode() annotations" affects
all of the security subsystems.

Mimi
