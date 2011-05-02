Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p42CBe7B009532
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2011 08:11:40 -0400
Received: from phoenicia.airattack-central.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p42CBcf6018494
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2011 12:11:38 GMT
Subject: Re: xattr support in cgroupfs
From: Matthew Ife <deleriux@airattack-central.com>
To: selinux@tycho.nsa.gov
Cc: Dave Quigley <dpquigl@davequigley.com>
In-Reply-To: <4DBE6F66.8030502@davequigley.com>
References: <1304118351.23317.1.camel@home.localdomain>
	 <4DBE6F66.8030502@davequigley.com>
Content-Type: multipart/mixed; boundary="=-g4wXVTnXZtFvoXHVzR+0"
Date: Mon, 02 May 2011 13:07:50 +0100
Message-ID: <1304338070.26664.3.camel@home.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-g4wXVTnXZtFvoXHVzR+0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I have attached the patch. Not really done a huge amount of bugtesting
(since the feature wont work anyway). Its also not complete as none of
the corresponding runtime tools permit this (like cgcreate). Basically
what i've added is extra parts to the struct to support an selinux
context and the ability to add a "label" parameter in the same spots
you'd put uid/gid in a cgconfig.conf file.

I also expect the tabbing to be off (spaces where tabs should be for
example). Its rough because I gave up working on it once I realized it
would work anyway.

Its based off of libcgroup-0.37.1.

On Mon, 2011-05-02 at 04:46 -0400, Dave Quigley wrote:
> On 4/29/2011 7:05 PM, Matthew Ife wrote:
> > I was wondering what peoples' thoughts where on doing this.
> >
> > At the moment cgroupfs does not support xattrs so no labelling of selinux
> > types is permitted, but since /proc and other pseudo filesystems support
> > it this should be possible.
> >
> > There are a number of use-cases which would benefit from this. For
> > example I have recently been working with application layer integration
> > of libcgroup with other services (apache being able to switch
> > cgroups for vhosts for example) because cgroups offer an excellent means
> > of offering resource control to prevent abuse of resources.
> >
> > Aa a typical example i'd like to be able to label some cgroups in
> > cgroupfs as "httpd_cgroup_t" / "httpd_cgroup_task_t" so that I can
> > control the access of the files it creates for administering tasks and
> > altering what goes in the task list. But currently I must give httpd_t
> > complete access to cgroup_t files. I can use DAC effectively enough to
> > limit access but without SELinux backing me up it makes me feel somewhat
> > naked.
> >
> > As a matter of fact, I started patching libcgroup to support labelling
> > cgroupfs without realizing this facility is unsupported! So I have about
> > 70% of an effective patch to do this work properly within libcgroup too.
> >
> > I welcome peoples' thoughts on this idea.
> >
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> If you can please try to CC me on the patch so I can give it a look over.


--=-g4wXVTnXZtFvoXHVzR+0
Content-Disposition: attachment; filename="selinux-libcgroup-partial.patch"
Content-Type: text/x-patch; name="selinux-libcgroup-partial.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -cNr ../old/libcgroup-0.37.1/configure ./configure
*** ../old/libcgroup-0.37.1/configure	2011-03-03 08:30:14.000000000 +0000
--- ./configure	2011-04-26 23:38:26.803720368 +0100
***************
*** 15700,15706 ****
  
  ac_config_files="$ac_config_files dist/libcgroup.spec:dist/libcgroup.spec.in"
  
! CFLAGS="$CFLAGS -Wall"
  cat >confcache <<\_ACEOF
  # This file is a shell script that caches the results of configure
  # tests run on this system so they can be shared between configure
--- 15700,15706 ----
  
  ac_config_files="$ac_config_files dist/libcgroup.spec:dist/libcgroup.spec.in"
  
! CFLAGS="$CFLAGS -Wall -lselinux"
  cat >confcache <<\_ACEOF
  # This file is a shell script that caches the results of configure
  # tests run on this system so they can be shared between configure
diff -cNr ../old/libcgroup-0.37.1/configure.in ./configure.in
*** ../old/libcgroup-0.37.1/configure.in	2011-03-03 08:29:41.000000000 +0000
--- ./configure.in	2011-04-26 23:34:28.511466669 +0100
***************
*** 204,209 ****
  	dist/Makefile
  	libcgroup.pc])
  AC_CONFIG_FILES([dist/libcgroup.spec:dist/libcgroup.spec.in])
! CFLAGS="$CFLAGS -Wall"
  AC_OUTPUT
  
--- 204,209 ----
  	dist/Makefile
  	libcgroup.pc])
  AC_CONFIG_FILES([dist/libcgroup.spec:dist/libcgroup.spec.in])
! CFLAGS="$CFLAGS -Wall -lselinux"
  AC_OUTPUT
  
diff -cNr ../old/libcgroup-0.37.1/selinux-libcgroup-partial.patch ./selinux-libcgroup-partial.patch
*** ../old/libcgroup-0.37.1/selinux-libcgroup-partial.patch	1970-01-01 01:00:00.000000000 +0100
--- ./selinux-libcgroup-partial.patch	2011-05-02 13:04:09.864144631 +0100
***************
*** 0 ****
--- 1,38 ----
+ diff -cNr ../old/libcgroup-0.37.1/configure ./configure
+ *** ../old/libcgroup-0.37.1/configure	2011-03-03 08:30:14.000000000 +0000
+ --- ./configure	2011-04-26 23:38:26.803720368 +0100
+ ***************
+ *** 15700,15706 ****
+   
+   ac_config_files="$ac_config_files dist/libcgroup.spec:dist/libcgroup.spec.in"
+   
+ ! CFLAGS="$CFLAGS -Wall"
+   cat >confcache <<\_ACEOF
+   # This file is a shell script that caches the results of configure
+   # tests run on this system so they can be shared between configure
+ --- 15700,15706 ----
+   
+   ac_config_files="$ac_config_files dist/libcgroup.spec:dist/libcgroup.spec.in"
+   
+ ! CFLAGS="$CFLAGS -Wall -lselinux"
+   cat >confcache <<\_ACEOF
+   # This file is a shell script that caches the results of configure
+   # tests run on this system so they can be shared between configure
+ diff -cNr ../old/libcgroup-0.37.1/configure.in ./configure.in
+ *** ../old/libcgroup-0.37.1/configure.in	2011-03-03 08:29:41.000000000 +0000
+ --- ./configure.in	2011-04-26 23:34:28.511466669 +0100
+ ***************
+ *** 204,209 ****
+   	dist/Makefile
+   	libcgroup.pc])
+   AC_CONFIG_FILES([dist/libcgroup.spec:dist/libcgroup.spec.in])
+ ! CFLAGS="$CFLAGS -Wall"
+   AC_OUTPUT
+   
+ --- 204,209 ----
+   	dist/Makefile
+   	libcgroup.pc])
+   AC_CONFIG_FILES([dist/libcgroup.spec:dist/libcgroup.spec.in])
+ ! CFLAGS="$CFLAGS -Wall -lselinux"
+   AC_OUTPUT
+   
diff -cNr ../old/libcgroup-0.37.1/src/api.c ./src/api.c
*** ../old/libcgroup-0.37.1/src/api.c	2011-03-03 08:29:41.000000000 +0000
--- ./src/api.c	2011-05-02 12:46:57.690927712 +0100
***************
*** 51,56 ****
--- 51,58 ----
  #include <assert.h>
  #include <linux/un.h>
  #include <grp.h>
+ #include <selinux/selinux.h>
+ #include <selinux/context.h>
  
  /*
   * The errno which happend the last time (have to be thread specific)
***************
*** 120,125 ****
--- 122,179 ----
  	"Value setting does not succeed",
  };
  
+ static int cg_setfilecon_file(FTS *fts, FTSENT *ent, security_context_t filecon)
+ {
+         int ret = 0;
+         const char *filename = fts->fts_path;
+         cgroup_dbg("setfilecon: seeing file %s\n", filename);
+         switch (ent->fts_info) {
+         case FTS_ERR:
+                 errno = ent->fts_errno;
+                 break;
+         case FTS_D:
+         case FTS_DC:
+         case FTS_NSOK:
+         case FTS_NS:
+         case FTS_DNR:
+         case FTS_DP:
+         case FTS_F:
+         case FTS_DEFAULT:
+ 		ret = setfilecon(filename, filecon);
+                 break;
+         }
+         if (ret < 0) {
+                 last_errno = errno;
+                 ret = ECGOTHER;
+         }
+         return ret;
+ }
+ 
+ static int cg_setfilecon_recursive(char **path, security_context_t filecon)
+ {
+         int ret = 0;
+         FTS *fts;
+ 
+         cgroup_dbg("setfilecon: path is %s\n", *path);
+         fts = fts_open(path, FTS_PHYSICAL | FTS_NOCHDIR |
+                                 FTS_NOSTAT, NULL);
+         if (fts == NULL) {
+                 last_errno = errno;
+                 return ECGOTHER;
+         }
+         while (1) {
+                 FTSENT *ent;
+                 ent = fts_read(fts);
+                 if (!ent) {
+                         cgroup_dbg("fts_read failed\n");
+                         break;
+                 }
+                 ret = cg_setfilecon_file(fts, ent, filecon);
+         }
+         fts_close(fts);
+         return ret;
+ }
+ 
  static int cg_chown_file(FTS *fts, FTSENT *ent, uid_t owner, gid_t group)
  {
  	int ret = 0;
***************
*** 1411,1416 ****
--- 1465,1475 ----
  				cgroup->control_uid, cgroup->control_gid);
  		}
  
+ 		if (cgroup->control_context != NULL) {
+ 			error = cg_setfilecon_recursive(fts_path,
+ 			cgroup->control_context);
+ 		}
+ 
  		if (error)
  			goto err;
  
***************
*** 1455,1460 ****
--- 1514,1524 ----
  			}
  			error = chown(path, cgroup->tasks_uid,
  							cgroup->tasks_gid);
+ 			
+ 			if (cgroup->tasks_context != NULL) {
+ 				error = setfilecon(path, cgroup->tasks_context);
+ 			}
+ 
  			if (error) {
  				last_errno = errno;
  				error = ECGOTHER;
***************
*** 1996,2001 ****
--- 2060,2066 ----
  	char path[FILENAME_MAX+1];
  	char *buffer = NULL;
  	int error = 0;
+ 	security_context_t filecon;
  	struct stat stat_buffer;
  
  	d_name = strdup(ctrl_dir->d_name);
***************
*** 2021,2026 ****
--- 2086,2093 ----
  		goto fill_error;
  	}
  
+ 	error = getfilecon(path, &filecon);
+ 
  	/*
  	 * We have already stored the tasks_uid & tasks_gid.
  	 * This check is to avoid the overwriting of the values
***************
*** 2047,2052 ****
--- 2114,2126 ----
  	if (strcmp(tmp_path, "/tasks")){
  		cgroup->control_uid = stat_buffer.st_uid;
  		cgroup->control_gid = stat_buffer.st_gid;
+ 		
+ 		if (!error) {
+ 			cgroup->control_context = strdup(filecon);
+ 		}
+ 		else {
+ 			cgroup->control_context = NULL;
+ 		}
  	}
  
  	ctrl_name = strtok_r(d_name, ".", &buffer);
***************
*** 2097,2102 ****
--- 2171,2177 ----
  	char *control_path = NULL;
  	int error;
  	int ret;
+ 	security_context_t filecon;
  
  	if (!cgroup_initialized) {
  		/* ECGROUPNOTINITIALIZED */
***************
*** 2157,2166 ****
--- 2232,2251 ----
  			goto unlock_error;
  		}
  
+ 		error = getfilecon(control_path, &filecon);
+ 
  		cgroup->tasks_uid = stat_buffer.st_uid;
  		cgroup->tasks_gid = stat_buffer.st_gid;
+ 		
+ 		if (error < 0) {
+ 			cgroup->tasks_context = NULL;
+ 		}
+ 		else {
+ 			cgroup->tasks_context = strdup(filecon);
+ 		}
  
  		free(control_path);
+ 		freecon(filecon);
  
  		cgc = cgroup_add_controller(cgroup,
  				cg_mount_table[i].name);
diff -cNr ../old/libcgroup-0.37.1/src/config.c ./src/config.c
*** ../old/libcgroup-0.37.1/src/config.c	2011-03-03 08:29:41.000000000 +0000
--- ./src/config.c	2011-05-02 12:52:13.566775625 +0100
***************
*** 35,40 ****
--- 35,42 ----
  #include <pwd.h>
  #include <pthread.h>
  #include <search.h>
+ #include <selinux/selinux.h>
+ #include <selinux/context.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
***************
*** 180,191 ****
  }
  
  /*
!  * Sets the tasks file's uid and gid
   */
  int cgroup_config_group_task_perm(char *perm_type, char *value)
  {
  	struct passwd *pw, *pw_buffer;
  	struct group *group, *group_buffer;
  	int error;
  	long val = atoi(value);
  	char buffer[CGROUP_BUFFER_LEN];
--- 182,195 ----
  }
  
  /*
!  * Sets the tasks file's uid, gid and selinux label
   */
  int cgroup_config_group_task_perm(char *perm_type, char *value)
  {
  	struct passwd *pw, *pw_buffer;
  	struct group *group, *group_buffer;
+ 	context_t selinux_context = NULL;
+ 	security_context_t filecon;
  	int error;
  	long val = atoi(value);
  	char buffer[CGROUP_BUFFER_LEN];
***************
*** 233,238 ****
--- 237,266 ----
  		config_cgroup->tasks_gid = val;
  	}
  
+         if (!strcmp(perm_type, "label")) {
+                 if (!val) {
+ 			error = getcon(&filecon);
+ 
+ 			if (error < 0) {
+ 				goto group_task_error;
+ 			}
+ 
+ 			selinux_context = context_new(filecon);
+ 			context_type_set(selinux_context, strdup(value));
+ 			context_role_set(selinux_context, strdup("object_r"));
+ 			filecon = context_str(selinux_context);
+ 			error = security_check_context(filecon);
+ 			
+ 			if (error < 0) {
+ 				context_free(selinux_context);
+ 				freecon(filecon);
+ 				goto group_task_error;
+ 			}
+                 }
+                 config_cgroup->tasks_context = filecon;
+         }
+ 
+ 	context_free(selinux_context);
  	free(perm_type);
  	free(value);
  	return 1;
***************
*** 253,258 ****
--- 281,288 ----
  	struct passwd *pw, *pw_buffer;
  	struct group *group, *group_buffer;
  	int error;
+ 	context_t selinux_context = NULL;
+ 	security_context_t filecon;
  	struct cgroup *config_cgroup =
  				&config_cgroup_table[cgroup_table_index];
  	long val = atoi(value);
***************
*** 299,304 ****
--- 329,358 ----
  		config_cgroup->control_gid = val;
  	}
  
+         if (!strcmp(perm_type, "label")) {
+                 if (!val) {
+                         error = getcon(&filecon);
+ 
+                         if (error < 0) {
+                                 goto admin_error;
+                         }
+ 
+                         selinux_context = context_new(filecon);
+                         context_type_set(selinux_context, strdup(value));
+ 			context_role_set(selinux_context, strdup("object_r"));
+                         filecon = context_str(selinux_context);
+                         error = security_check_context(filecon);
+ 
+                         if (error < 0) {
+ 				context_free(selinux_context);
+                                 freecon(filecon);
+                                 goto admin_error;
+                         }
+                 }
+                 config_cgroup->control_context = filecon;
+         }
+ 
+ 	context_free(selinux_context);
  	free(perm_type);
  	free(value);
  	return 1;
diff -cNr ../old/libcgroup-0.37.1/src/libcgroup-internal.h ./src/libcgroup-internal.h
*** ../old/libcgroup-0.37.1/src/libcgroup-internal.h	2011-03-03 08:29:41.000000000 +0000
--- ./src/libcgroup-internal.h	2011-04-26 23:42:11.894616419 +0100
***************
*** 23,28 ****
--- 23,29 ----
  #include <libcgroup.h>
  #include <limits.h>
  #include <pthread.h>
+ #include <selinux/selinux.h>
  #include <sys/stat.h>
  #include <sys/types.h>
  
***************
*** 86,91 ****
--- 87,94 ----
  	gid_t tasks_gid;
  	uid_t control_uid;
  	gid_t control_gid;
+ 	security_context_t tasks_context;
+ 	security_context_t control_context;
  };
  
  
Binary files ../old/libcgroup-0.37.1/src/tools/core.22269 and ./src/tools/core.22269 differ
Binary files ../old/libcgroup-0.37.1/src/tools/core.23078 and ./src/tools/core.23078 differ
diff -cNr ../old/libcgroup-0.37.1/src/wrapper.c ./src/wrapper.c
*** ../old/libcgroup-0.37.1/src/wrapper.c	2011-03-03 08:29:41.000000000 +0000
--- ./src/wrapper.c	2011-05-02 12:50:07.366595056 +0100
***************
*** 31,36 ****
--- 31,38 ----
  		return NULL;
  
  	strncpy(cgroup->name, name, sizeof(cgroup->name));
+ 	cgroup->tasks_context = NULL;
+ 	cgroup->control_context = NULL;
  
  	return cgroup;
  }
***************
*** 100,105 ****
--- 102,109 ----
  		return;
  
  	cgroup_free_controllers(cg);
+ 	freecon(cg->tasks_context);
+ 	freecon(cg->control_context);
  	free(cg);
  	*cgroup = NULL;
  }

--=-g4wXVTnXZtFvoXHVzR+0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
