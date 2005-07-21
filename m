Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LEG4gA026105
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:16:09 -0400 (EDT)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LEBTrg008269
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:11:29 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6LEBF4m007764
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:11:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6LEBFWU227722
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:11:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6LEBFx3005807
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:11:15 -0400
Message-ID: <42DFACFB.6050603@us.ibm.com>
Date: Thu, 21 Jul 2005 10:11:07 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] polyinstantiation using process namespace
References: <1121893384.6269.29.camel@localhost.localdomain>
In-Reply-To: <1121893384.6269.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks Chad!

My comments/answers are inline.

Chad Sellers wrote:
> Janak,
> 
> Very nice.  I'm glad to see that you took my code and ran with it.  At
> first glance, it looks much less hackish than my initial patch.  I'm at
> OLS this week, so I won't be able to test out your patches till I
> return.  I wanted to respond to your questions now, though.  See the
> answers below.
> 
> Thanks,
> Chad
> 
> Janak Desai wrote:
> 
>         Hello,
>         
>         Here is a pam patch that adds a new pam module pam_namesapce to
>         create a private namespace with polyinstantiated directories 
>         based on the configuration file /etc/security/namespace.conf.
>         It implements the polyinstatiation scheme proposed by Stephen
>         Smalley and prototyped by Chad Sellers.
>         
>         I have unit tested this pam module with login, su, sshd, gdm 
>         and newrole. Because of lack of pam session management hooks 
>         in newrole, newrole command itself will be modified as well. 
>         I will post newrole patch next week. To test this patch, in 
>         addition to this pam patch, you will need three other (four 
>         if you are testing newrole) patches. The first two implement 
>         a new system call unshare, and the 3rd provides a policy patch 
>         that adds type-member rules used in polyinstantiation. Few 
>         weeks ago, unshare patches were posted to linux-fsdevel mailing 
>         list and policy patch (part of Chad Seller's namespace setup 
>         patch) was posted on this list. However, I will post them again 
>         on this list to make it easier for you to try this one out. The
>         README file explains the configuration and use of namespaces. 
>         
>         Please provide comments and suggestions for improvement. 
>         Especially on the following issues/questions:
>         
>         1) Because we didn't have unshare system call, Chad's patch
>            modified libselinux, and session establishing programs
>            such as login and gdm. Now that there is strong possibility
>            of getting the new system call unshare accepted upstream,
>            we don't have to modify individual commands. Therefore I
>            have moved namespace setup functions from libselinux to
>            the new pam module. Is that ok? Do you see any need for
>            providing this library routine to other programs that may
>            not want to use pam? It won't be very difficult to move
>            core functionality from pam module to the selinux library,
>            but I thought that it was better to tie namespace setup
>            with session setup.
> 
> This seems like a good idea to me.  The idea behind this function is to
> only occur at a user/role entrypoint.  The one concern I would have
> would be for systems that choose not to use PAM because of its security
> (Slackware was like this for a while, not sure if they've changed).  I
> think this is a rare case now, though, so it's probably a good idea to
> move it to pam.
>     

Ok, thanks.

>         2) Current patch skips malformed or invalid lines in the 
>            /etc/security/namespace.conf file. For example, missing
>            arguments or lack of absolute pathnames or unknown
>            polyinstantiation method. Is it better to exit with an
>            error instead of not performing polyinstnation for that
>            particular directory?
>         
> Probably should exit with error, as that's failing secure.  The only
> catch here is that if you boot a machine, and there are no users listed
> as exempt (I think you renamed this to override_user), then no one could
> log in.  That's definitely failing secure, but it's not going to earn
> you popularity points.  Assuming that most systems will have users not
> subject to polyinstantiation, I'd say it's better to exit with an error.
> 

Good point. I can easily change this to exit with error. However, since
I have made exempt/override user specification per directory, an
improperly configured namespce.conf will still result in no one being
able to login from init state 3 or 5. If that happens, admins will have
to boot in single user mode to fix it.

>         3) Since security_compute_member() returns proper context
>            in permissive mode as well, I am not making any distinction
>            for enforcing/permissive mode. Please let me know if that
>            is NOT ok.
>         
> Please do not change this.  If I'm developing a system in permissive
> mode that I will eventually switch over to enforcing (a common use of
> permissive mode), I don't want the system to start functioning
> differently when I switch into enforcing.
>  

Ok, thanks.

>         4) What should be the security context of the reset directory,
>            where original contents are available to only authorized
>            processes? Right now I am using mode of 000, but I know 
>            that is not correct since polyinstantiated directory is 
>            mounted on top of that directory. 
>         
> I'm not sure if you're referring to the context and mode of the created
> reset directory (*-poly.orig), or the original directory that is mounted
> on it.  The original directory should have a system context (in
> file_contexts) and mode appropriate to keep the access limited to
> authorized processes.  These will probably vary from directory to
> directory.  The created reset directory is only a mount point, so it
> needs a label that has almost no permissions on it (essentially only
> mounton given to entrypoint programs).  This should be the same type
> (something like poly_reset_t) for all mount points.  The mode doesn't
> matter, but I made it 000 to make sure that no one accidentally put
> something there while in permissive mode.
> 

Yes, the problem is that once you bind mount original directory on
the created reset directory, access checks are made against the
bind mounted original directory mode/context. For example, /tmp is 777.
The reset directory, /.poly-orig is 000. Now, after /tmp is bind mounted
on /.poly-orig, /.poly-orig is also 777. Which means a user is
still able to access the original directory.

>         5) If newrole or su is executed from inside a polyinstantiated
>            directory, undoing bind mount fails since the process has
>            the directory open. Currently, I am changing the process
>            working directory to the parent of polyinstantiated 
>            directory. Please let me know if that is acceptable or if
>            there is a better way to handle that. 
>         
>         
>         Thanks. 
>         
>         -Janak
>         
>         Patch Summary:
>         This patch provides pam_namespace pam module to setup a 
>         private namespace with polyinstantiated directories.
>         
>         Patch Justification:
>         This patch is needed to provide polyinstantiated directories.
>         Polyinstantiated directories are needed to achieve greater 
>         information separation for public use directories such 
>         as /tmp and /var/tmp, and provide users with writeable home 
>         directories as they transition roles, types or mls level.
>         
>         
>         Overall Approach:
>         After unsharing (disassociating from current shared) namespace,
>         the pam module will cycle through all directories listed in 
>         configuration file for polyinstantiation, bind mount the
>         original
>         directory to a "reset" location from where its contents will
>         be available to authorized processes, create a member directory
>         based on polyinstantiation method (user, context, or both as
>         specified in the configuration file) and bind mount this member
>         directory on top of the directory to polyinstantiate. This 
>         gives an instance of the directory based on the process context.
>         
>         Testing:
>         The patch has been unit tested on uni-processor i386
>         architecture
>         based Fedora Core 3 system running 2.6.12 kernel.
>         
>         Signed-off-by: Janak Desai
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
