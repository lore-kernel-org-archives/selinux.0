Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95CZbrT025495
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 08:35:37 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95CYTPe014349
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 12:34:30 GMT
Subject: Re: Add a new class
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Trent Jaeger <jaegert@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <4161ED86.2080200@tresys.com>
References: 
	 <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
	 <4161ED86.2080200@tresys.com>
Content-Type: text/plain
Message-Id: <1096979565.3878.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 08:32:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-04 at 20:40, Joshua Brindle wrote:
> Check the files in policy/flask
> 
> specifically you must add the class to security_classes and the 
> permissions to access_vectors and then rebuild the headers with the 
> Makefile in the flask directory and put them in 
> linux/security/selinux/include/
> 
> then reboot on the new kernel and build a policy with the new classes 
> and access vectors, it should be fairly straightforward and no problems 
> should occur.

Note that if you are acting on a policy directory in a selinux-usr tree
and have a linux-2.6 tree at the same level as your selinux-usr tree,
then you can also do 'make all tokern tolib' in policy/flask to build
and push the regenerated headers to the linux-2.6 tree and libselinux
tree.  You can also override LIBSEL and LINUXDIR definitions if they
have different locations.

I should also note that as a result of patches from Ulrich Drepper, the
generated headers have changed, as has the code that uses them, but this
change is only in the CVS tree (sourceforge and our internal tree); we
have not yet pushed the change upstream as no actual kernel definitions
have changed yet.

Please be sure to submit the patch to the policy/flask files to the list
ASAP to reserve the classes so that their values won't be re-used for
another class.  No need to submit a patch for the regenerated headers;
we will rebuild those ourselves when merging the patch for the
policy/flask files.

I don't think it is necessary to boot the new kernel before building the
updated policy, as you can always load a policy with additional classes
and permissions even if the existing kernel doesn't use them; you only
have a problem if you try to change or remove an existing class or
permission (and the kernel will refuse to load such a policy anyway). 
In fact, it is likely not safe to boot the new kernel without first
building and installing the new policy, because the new kernel may try
to use the new classes and permissions before they are defined in the
policy (which would result in denials).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
