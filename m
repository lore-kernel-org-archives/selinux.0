Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8KHvU9a027932
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2010 13:57:31 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o8KHvUhF013555
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2010 17:57:30 GMT
Subject: Re: genfscon question
From: Eric Paris <eparis@redhat.com>
To: Roberto Sassu <roberto.sassu@polito.it>
Cc: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
In-Reply-To: <201009201107.27478.roberto.sassu@polito.it>
References: <201009201107.27478.roberto.sassu@polito.it>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Sep 2010 13:57:16 -0400
Message-ID: <1285005436.2661.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-09-20 at 11:07 +0200, Roberto Sassu wrote:
> Hi all
> 
> i want to create a custom filesystem policy using the genfscon statement for labelling 
> files. I need to specify rules with the wildcard character, in order to obtain the same behaviour 
> for multiple subdirectories but this is currently unsupported (building of the policy fails).
> There are security/design concerns in order to introduce this feature or it can be added
> by patching the code?
> Thanks in advance for replies.

genfscon is only usable to label inodes when we know the name and path
to that inode is immutable.  Thus you will see in policy that we use
genfscon to label only the / directory of most filesystem types.  The
only places we use more than / is in /proc and /sys where the kernel
determines the name of the objects and those names are both
deterministic and immutable.

Aside from the fact that trying to use name based labeling breaks the
security model (we label the object not the name of the object) on
general purpose filesystems, your specific request has technical issues
in that the kernel has no regular expression parser.  I see that as an
insurmountable hurdle if you try to actually implement this.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
