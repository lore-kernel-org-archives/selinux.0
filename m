Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6IDsQgA028181
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 09:54:26 -0400 (EDT)
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6IDoLlV003323
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 13:50:21 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6IDoMqY012893
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 09:50:22 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6IDoMod257324
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 09:50:22 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6IDoMgN008499
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 09:50:22 -0400
Message-ID: <42DBB397.4020101@us.ibm.com>
Date: Mon, 18 Jul 2005 09:50:15 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Janak Desai <janak@us.ibm.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] polyinstantiation using process namespace
References: <Pine.WNT.4.63.0507151435390.1188@IBM-AIP3070F3AM>
In-Reply-To: <Pine.WNT.4.63.0507151435390.1188@IBM-AIP3070F3AM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

Can I please request that when you send your comments on the
pam_namespace patch, that you remove, if possible, portions of
code/README/etc that you are not commenting on? That way, we
will stay under the 40KB limit and the emails won't go over to
the list admin for manual approval. It will reduce admin work
and emails will arrive in chronological order for more coherent
discussion.

Thanks.

-Janak


Janak Desai wrote:
> Hello,
> 
> Here is a pam patch that adds a new pam module pam_namesapce to
> create a private namespace with polyinstantiated directories 
> based on the configuration file /etc/security/namespace.conf.
> It implements the polyinstatiation scheme proposed by Stephen
> Smalley and prototyped by Chad Sellers.
> 
> I have unit tested this pam module with login, su, sshd, gdm 
> and newrole. Because of lack of pam session management hooks 
> in newrole, newrole command itself will be modified as well. 
> I will post newrole patch next week. To test this patch, in 
> addition to this pam patch, you will need three other (four 
> if you are testing newrole) patches. The first two implement 
> a new system call unshare, and the 3rd provides a policy patch 
> that adds type-member rules used in polyinstantiation. Few 
> weeks ago, unshare patches were posted to linux-fsdevel mailing 
> list and policy patch (part of Chad Seller's namespace setup 
> patch) was posted on this list. However, I will post them again 
> on this list to make it easier for you to try this one out. The
> README file explains the configuration and use of namespaces. 
> 
> Please provide comments and suggestions for improvement. 
> Especially on the following issues/questions:
> 
> 1) Because we didn't have unshare system call, Chad's patch
>    modified libselinux, and session establishing programs
>    such as login and gdm. Now that there is strong possibility
>    of getting the new system call unshare accepted upstream,
>    we don't have to modify individual commands. Therefore I
>    have moved namespace setup functions from libselinux to
>    the new pam module. Is that ok? Do you see any need for
>    providing this library routine to other programs that may
>    not want to use pam? It won't be very difficult to move
>    core functionality from pam module to the selinux library,
>    but I thought that it was better to tie namespace setup
>    with session setup.
> 
> 2) Current patch skips malformed or invalid lines in the 
>    /etc/security/namespace.conf file. For example, missing
>    arguments or lack of absolute pathnames or unknown
>    polyinstantiation method. Is it better to exit with an
>    error instead of not performing polyinstnation for that
>    particular directory?
> 
> 3) Since security_compute_member() returns proper context
>    in permissive mode as well, I am not making any distinction
>    for enforcing/permissive mode. Please let me know if that
>    is NOT ok.
> 
> 4) What should be the security context of the reset directory,
>    where original contents are available to only authorized
>    processes? Right now I am using mode of 000, but I know 
>    that is not correct since polyinstantiated directory is 
>    mounted on top of that directory. 
> 
> 5) If newrole or su is executed from inside a polyinstantiated
>    directory, undoing bind mount fails since the process has
>    the directory open. Currently, I am changing the process
>    working directory to the parent of polyinstantiated 
>    directory. Please let me know if that is acceptable or if
>    there is a better way to handle that. 
> 
> 
> Thanks. 
> 
> -Janak
> 
> Patch Summary:
> This patch provides pam_namespace pam module to setup a 
> private namespace with polyinstantiated directories.
> 
> Patch Justification:
> This patch is needed to provide polyinstantiated directories.
> Polyinstantiated directories are needed to achieve greater 
> information separation for public use directories such 
> as /tmp and /var/tmp, and provide users with writeable home 
> directories as they transition roles, types or mls level.
> 
> 
> Overall Approach:
> After unsharing (disassociating from current shared) namespace,
> the pam module will cycle through all directories listed in 
> configuration file for polyinstantiation, bind mount the original
> directory to a "reset" location from where its contents will
> be available to authorized processes, create a member directory
> based on polyinstantiation method (user, context, or both as
> specified in the configuration file) and bind mount this member
> directory on top of the directory to polyinstantiate. This 
> gives an instance of the directory based on the process context.
> 
> Testing:
> The patch has been unit tested on uni-processor i386 architecture
> based Fedora Core 3 system running 2.6.12 kernel.
> 
> Signed-off-by: Janak Desai
> 
> -----------------------------------------------------------------
> diff -Naurp Linux-PAM-0.79/modules/pam_namespace/Makefile Linux-PAM-0.79+pam_namespace/modules/pam_namespace/Makefile
> --- Linux-PAM-0.79/modules/pam_namespace/Makefile	1970-01-01 00:00:00.000000000 +0000
> +++ Linux-PAM-0.79+pam_namespace/modules/pam_namespace/Makefile	2005-07-15 15:57:45.000000000 +0000



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
