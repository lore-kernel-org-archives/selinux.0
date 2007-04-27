Subject: Re: [PATCH 1/1] libselinux: helpful message when /selinux won't
	mount
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dax Kelson <dax@gurulabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1177618067.26931.13.camel@mentorng.gurulabs.com>
References: <1177618067.26931.13.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 13:03:14 -0400
Message-Id: <1177693394.3357.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 14:07 -0600, Dax Kelson wrote:
> Last night a co-worker was trying to do a Phyical-2-Virtual (P2V)
> migration of a RHEL5 box.
> 
> During bootup, the following not-so-helpful message was seen:
> 
> "Unable to load SELinux Policy. Machine is in enforcing mode. Halting
> now."
> 
> I ran it down to the /selinux mount point not existing on the root
> filesystem, but the troubleshooting was more difficult than it should
> have been (it didn't help that it was a 3am).
> 
> Please consider the following trivial patch for inclusion into
> libselinux so that others may have an easier time if they happen into
> the same situation.
> 
> Signed-off-by:  Dax Kelson <dax@gurulabs.com>
> 
> ===================================================================
> --- libselinux-2.0.8-org/src/load_policy.c	2007-03-08 12:44:37.000000000 -0700
> +++ libselinux-2.0.8/src/load_policy.c	2007-04-26 13:54:18.000000000 -0600
> @@ -226,6 +226,7 @@
>  			 */
>  			*enforce = 0;
>  		}
> +		printf("Mount failed for selinuxfs on /selinux\n");
>  		goto noload;
>  	}
>  	set_selinuxmnt(SELINUXMNT);

Merged, with the following diff on top of it to redirect to stderr and
to provide more information.  Shows up as the following message if you
boot without a /selinux directory:
	Mount failed for selinuxfs on /selinux:  No such file or directory

Index: libselinux/src/load_policy.c
===================================================================
--- libselinux/src/load_policy.c	(revision 2411)
+++ libselinux/src/load_policy.c	(working copy)
@@ -226,7 +226,7 @@
 			 */
 			*enforce = 0;
 		}
-		printf("Mount failed for selinuxfs on /selinux\n");
+		fprintf(stderr, "Mount failed for selinuxfs on %s:  %s\n", SELINUXMNT, strerror(errno));
 		goto noload;
 	}
 	set_selinuxmnt(SELINUXMNT);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
