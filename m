Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KL7fgA020893
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 17:07:41 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KL2Q9b009902
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 21:02:26 GMT
Subject: RE: [RFC][PATCH] polyinstantiation using process namespace
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov, janak@us.ibm.com
Content-Type: text/plain
Date: Wed, 20 Jul 2005 17:03:04 -0400
Message-Id: <1121893384.6269.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Janak,

Very nice.  I'm glad to see that you took my code and ran with it.  At
first glance, it looks much less hackish than my initial patch.  I'm at
OLS this week, so I won't be able to test out your patches till I
return.  I wanted to respond to your questions now, though.  See the
answers below.

Thanks,
Chad

Janak Desai wrote:

        Hello,
        
        Here is a pam patch that adds a new pam module pam_namesapce to
        create a private namespace with polyinstantiated directories 
        based on the configuration file /etc/security/namespace.conf.
        It implements the polyinstatiation scheme proposed by Stephen
        Smalley and prototyped by Chad Sellers.
        
        I have unit tested this pam module with login, su, sshd, gdm 
        and newrole. Because of lack of pam session management hooks 
        in newrole, newrole command itself will be modified as well. 
        I will post newrole patch next week. To test this patch, in 
        addition to this pam patch, you will need three other (four 
        if you are testing newrole) patches. The first two implement 
        a new system call unshare, and the 3rd provides a policy patch 
        that adds type-member rules used in polyinstantiation. Few 
        weeks ago, unshare patches were posted to linux-fsdevel mailing 
        list and policy patch (part of Chad Seller's namespace setup 
        patch) was posted on this list. However, I will post them again 
        on this list to make it easier for you to try this one out. The
        README file explains the configuration and use of namespaces. 
        
        Please provide comments and suggestions for improvement. 
        Especially on the following issues/questions:
        
        1) Because we didn't have unshare system call, Chad's patch
           modified libselinux, and session establishing programs
           such as login and gdm. Now that there is strong possibility
           of getting the new system call unshare accepted upstream,
           we don't have to modify individual commands. Therefore I
           have moved namespace setup functions from libselinux to
           the new pam module. Is that ok? Do you see any need for
           providing this library routine to other programs that may
           not want to use pam? It won't be very difficult to move
           core functionality from pam module to the selinux library,
           but I thought that it was better to tie namespace setup
           with session setup.

This seems like a good idea to me.  The idea behind this function is to
only occur at a user/role entrypoint.  The one concern I would have
would be for systems that choose not to use PAM because of its security
(Slackware was like this for a while, not sure if they've changed).  I
think this is a rare case now, though, so it's probably a good idea to
move it to pam.
        
        2) Current patch skips malformed or invalid lines in the 
           /etc/security/namespace.conf file. For example, missing
           arguments or lack of absolute pathnames or unknown
           polyinstantiation method. Is it better to exit with an
           error instead of not performing polyinstnation for that
           particular directory?
        
Probably should exit with error, as that's failing secure.  The only
catch here is that if you boot a machine, and there are no users listed
as exempt (I think you renamed this to override_user), then no one could
log in.  That's definitely failing secure, but it's not going to earn
you popularity points.  Assuming that most systems will have users not
subject to polyinstantiation, I'd say it's better to exit with an error.

        3) Since security_compute_member() returns proper context
           in permissive mode as well, I am not making any distinction
           for enforcing/permissive mode. Please let me know if that
           is NOT ok.
        
Please do not change this.  If I'm developing a system in permissive
mode that I will eventually switch over to enforcing (a common use of
permissive mode), I don't want the system to start functioning
differently when I switch into enforcing.
        
        4) What should be the security context of the reset directory,
           where original contents are available to only authorized
           processes? Right now I am using mode of 000, but I know 
           that is not correct since polyinstantiated directory is 
           mounted on top of that directory. 
        
I'm not sure if you're referring to the context and mode of the created
reset directory (*-poly.orig), or the original directory that is mounted
on it.  The original directory should have a system context (in
file_contexts) and mode appropriate to keep the access limited to
authorized processes.  These will probably vary from directory to
directory.  The created reset directory is only a mount point, so it
needs a label that has almost no permissions on it (essentially only
mounton given to entrypoint programs).  This should be the same type
(something like poly_reset_t) for all mount points.  The mode doesn't
matter, but I made it 000 to make sure that no one accidentally put
something there while in permissive mode.
        
        5) If newrole or su is executed from inside a polyinstantiated
           directory, undoing bind mount fails since the process has
           the directory open. Currently, I am changing the process
           working directory to the parent of polyinstantiated 
           directory. Please let me know if that is acceptable or if
           there is a better way to handle that. 
        
        
        Thanks. 
        
        -Janak
        
        Patch Summary:
        This patch provides pam_namespace pam module to setup a 
        private namespace with polyinstantiated directories.
        
        Patch Justification:
        This patch is needed to provide polyinstantiated directories.
        Polyinstantiated directories are needed to achieve greater 
        information separation for public use directories such 
        as /tmp and /var/tmp, and provide users with writeable home 
        directories as they transition roles, types or mls level.
        
        
        Overall Approach:
        After unsharing (disassociating from current shared) namespace,
        the pam module will cycle through all directories listed in 
        configuration file for polyinstantiation, bind mount the
        original
        directory to a "reset" location from where its contents will
        be available to authorized processes, create a member directory
        based on polyinstantiation method (user, context, or both as
        specified in the configuration file) and bind mount this member
        directory on top of the directory to polyinstantiate. This 
        gives an instance of the directory based on the process context.
        
        Testing:
        The patch has been unit tested on uni-processor i386
        architecture
        based Fedora Core 3 system running 2.6.12 kernel.
        
        Signed-off-by: Janak Desai


-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
