Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MG2FgA006848
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 12:02:15 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFvSYP028822
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:57:28 GMT
Message-Id: <200507221557.j6MFvKvx017930@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>, "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 11:57:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1122046798.25951.27.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]

<snip>

Josh will answer the above questions.

> > /* semanage_homedir accessors */
> >
> > const char* semanage_homedir_get_user(semanage_handle_t *);
> > const char* semanage_homedir_get_path(semanage_handle_t *);
> >
> > int semanage_homedir_set_user(semanage_handle_t *, char *user);
> > int semanage_homedir_set_path(semanage_handle_t *, char *path);
> 
> There is no api to trigger regeneration of the file_contexts file.
> 

Trigger? The commit should cause the regeneration to happen.

> Also, I believe the mapping of paths to selinux users is
> fundamentally flawed, and needs to be more generic. I will
> acknowledge that the code I've posted so far offers no solution
> either, and may actually be worse.
> 
> I want to add a new expansion called... CONTENT_DIR, which maps
> to a bunch of locations where I store music and movies on my home
> computer, and labels those to a certain type.
> 
> I want to add a new expansion called... REMOVABLE_MNT_POINT, that
> I want labeled removable_t via integration with udev, which follows
> my custom naming policy.
> 
> How does this future-proof API handle those scenarios.
> 

I agree that this api doesn't cut it. The only alternative I have is the ability
to specify arbitrary name-value pairs that get expanded and pass in the selinux
user in addition to the pairs. HOME_DIR would just be one of the name-value
pairs. This has a few problems that I have no solution to:

1) How are reasonable defaults determined with the caller doesn't set a
particular name that a file context expects? Is it just not expanded?

2) How do we handle the case where some of the labeling should be present but
not others (e.g., /tmp but not /home/username when home directories are remote)?

> > struct semanage_handle {
> > 	int con_id;		/* Connection ID */
> > 	int policy_serial;	/* Policy serial number at connect time */
> > 	char *err_buf;
> 
> We should not buffer errors - we should provide the user
> with a better debugging system - do you oppose sepol_enable_debug* ?
> 

I think that the caller should be able to chose how to display errors - that is
what this api is for and it seems straight forward to me. What is your
objection? Not that may be separate from a logging mechanism that sends errors
to a log file.

Karl
---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
