Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GKIVVB028951
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 16:18:31 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GKIUhv023888
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 20:18:31 GMT
Date: Wed, 16 Jul 2008 22:18:29 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Fedora refpolicy patches
Message-ID: <20080716201829.GC11166@hardeman.nu>
References: <20080716165634.GA8072@hardeman.nu> <487E2C1F.4010308@redhat.com> <20080716174410.GA9226@hardeman.nu> <1216232357.21191.76.camel@gorn> <487E451C.5000603@redhat.com> <20080716192942.GA11166@hardeman.nu> <487E4EAD.5070207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
In-Reply-To: <487E4EAD.5070207@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 16, 2008 at 03:40:29PM -0400, Daniel J Walsh wrote:
>All of these suggestions are fine and yes if we had to do it all over
>again, every change would be documented with links to bugzilla.emails,
>conversations in the hall.  I am looking for help to get it better under
>control.  I am not looking for direct commit, or at least a commit via
>an ack process.

I'm sorry, but I still haven't understood what *kind* of help you're 
looking for...except for wishing Chris had > 24h per day. :)

>Patches have been sent up stream in the past that have got lost in the
>volume of work that Chris has to do.  Not his fault.  But we have a
>system where we have only one person whose primary job is not to check
>in policy patches, having to review every patch. 

So obviously something is wrong in the refpolicy patch acceptance 
process? As a comparison, every single patch is applied by Linus to the 
kernel (even though they've been filtered by maintainers first) and going 
from 2.6.25 to 2.6.26-rc1 alone was 7555 patches.

>And we have the person
>generating most of the policy falling further and further behind.  While
>the kernel has teams of engineers working on patches, reviewing them and
>applying them.  They also have people who just cherry pick obvious fixes
>and apply them.

Well, I still don't know what should be done? Just splitting the RH patch 
into per-module patches was a great help to me. Out of those 200+ patches, 
about 50% were less than 100 lines and I'm guessing around 50% are of the 
no-brainer kind (3 were 1000+ lines). If those 50% could be identified and 
applied in quick succession by Chris...the RH patch wouldn't shrink by 50% 
in number of lines but it would shrink by 50% in number of modules affected.

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
