Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E738D
	for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380465; cv=none; b=eLvVtYJ48dWC4rKonR+smI6JTVfFokohYrARA8TPKIfK1N1uDhM1GZ/dej9YIw1gU+VYZ+Vvd2j4URGuBTZeqRZ/XNoxdJ3DHa+AMWfajPzIRxPPkPv2Gujc+yI5fh6wy/o820CnYfcFYvGOB8o4MfDA3POEZPzFN2ZaQs3BKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380465; c=relaxed/simple;
	bh=UX6LSH2t4PmhyS+vRmt83y4tEh6ut529wqGTynUjR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRzaJSQW02db66jc/ELfsv9TCrRs0pK5F5Vja5b+aTmrOnoFJJ2C+GCP+J+OUW6MVEh79THxuKAASW6E6yt1E+7ZVhc5b4ZBzXneR6kFUvSZUmJ1vz1/hREcClAznUONsNFdtxgWPdjlUy+M8Oml1mAs89F9IbaBtmZoZ/Uyr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=K14ngqpK; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="K14ngqpK"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b71557299dso5506080eec.1
        for <selinux@vger.kernel.org>; Sun, 25 Jan 2026 14:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1769380460; x=1769985260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwcx5mssv0eFqdHV4s/JOQvNO6eK04zmdYzhWQg1rWE=;
        b=K14ngqpK7edCej0I6+7d/uv1PsIJVCelrwYVRPW41viA4MLIqqWG00f+9VkRgmepLo
         BHBh7P6XD27C2EUSmxu8FPVwTXKw1nzAYXhg9DlGV4ZroQe8qIcA7/lD6kjEhklpg/nL
         qEjXR9hO+tg0LdrMwWnszZs/1RGYT5pXIRqDC0EJE891AwZdOBx0R1cZDIagtrHZxyD3
         FqgYT3P/6NBBXMSCHd5kwuMdyC8v+q4irJvFJxTtF85uWm8gXijpSKHA/odNSWXKYYU+
         R/dMs32bOntEVDtHxe+OUGKkSFnuF7ThDUzYQVnSo9Y+eoRPRXBruhic9bUxoHKyqoQ0
         TyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769380460; x=1769985260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwcx5mssv0eFqdHV4s/JOQvNO6eK04zmdYzhWQg1rWE=;
        b=kTOQTOJYhS55H6ODFP5diJfM4HM3SKr3zu2YhEF7fZFrNTuEB4ANHGxVgl+N9LMllk
         qdCEMfdkKWpSTybQjzwvMyI7JlXeMRbZnDFmavRAIXCN++isTgg7Y/topgoIVOdeCrn5
         k8Yf7cTOs0ZuEnD3RMyIfCEeIy3GJzKmOwwm/KONkonKTJ1qCblYB0SAaX60BrxxeSOk
         URfzBuyjZ4zJ+sbl3fmoRZi1ob7UbsZLGZGTeMnJeSXNsNGTlWH5Rdu7MPomK85qkTeL
         pgzhei+q8VORy+keOLAkYIL8vn64khvgBpajDSpxE3PILUsIkSh/RF2779sp/7T4vznM
         z4pg==
X-Forwarded-Encrypted: i=1; AJvYcCW7rUdb8B4R/rdafO9rqVOeJ466Z0V4OVbWjUlRU53MM1rNpjf338zO4dRh91j7KXW8P3rdZVh6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39zHa1lkcbWbBQAS099jFk8bZueuRFJJlP19jTtQThnczi5Rv
	myVS4Dlqfrs9bEXJ1721phhxauwYH4yXY1Ot8GI68wzjKH0fGF0t/2YLdANIvVpX9Zk=
X-Gm-Gg: AZuq6aIMzBCHEPsY/3LfenYNqVLXeHEoSlux280aVejMnQJ3BvNn4UAWexyZm4Z/ZXK
	P3omPu7VNLXb1IXZKRUwBtdSq0Zh/1XXYF7qum9nm2LxTfso1AN/jOJnZikc3bsD3uEUuJ9LR+j
	6DCKQ0r4Iv1LzoMVypMTM3SVyVRLOpouNCYWpYkIWDlaw7nndYjbf1KlClCai4TEHzDUkpfNbJ7
	2V7T8b5p2H4gFOALYvWkT2hWsTQTuAucSGFRpz5dgKY/rirGhq5cmrYO2zbJOa0Ced7ewLqCL1g
	7/3Yv7ykI4cwOpN/o4OZK4eHM0LW4+V23IBMVn0EVcW88U8bpCyVyYqqL40tl8FNctxg+TharfC
	HPFvu5ON+n1uuDvhYjttkPtWmswCOWaynVARUT1siCC4grveALIwb36DVc+fP1yU1leDr8cusru
	MRwDlQeN8CZT3t+RC/nv4zgySyxV1L/r+HpMNAVC0lBlsLZgY=
X-Received: by 2002:a05:7022:1e04:b0:11a:e610:ee32 with SMTP id a92af1059eb24-1248ec3d7admr1459570c88.25.1769380459690;
        Sun, 25 Jan 2026 14:34:19 -0800 (PST)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d9a3f22sm16301556c88.13.2026.01.25.14.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:34:19 -0800 (PST)
Date: Sun, 25 Jan 2026 14:34:18 -0800
From: Jason Zaman <jason@perfinion.com>
To: James Carter <jwcart2@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org,
	Rahul Sandhu <nvraxn@gmail.com>
Subject: Re: [PATCH v2] sandbox/seunshare: Replace system() with execv() to
 prevent shell injection
Message-ID: <aXaaapxDeXIo19LQ@anduin.perfinion.com>
References: <DFID35MI20QY.1TO7H1O354V64@gmail.com>
 <20260107165908.1584087-1-lautrbach@redhat.com>
 <CAP+JOzS23+GZdXGGXdce8-UCvAc8jpsZ84aCCTP1_QJ2tNmNoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP+JOzS23+GZdXGGXdce8-UCvAc8jpsZ84aCCTP1_QJ2tNmNoA@mail.gmail.com>

On Fri, Jan 23, 2026 at 10:03:10AM -0500, James Carter wrote:
> On Wed, Jan 7, 2026 at 12:33 PM Petr Lautrbach <lautrbach@redhat.com> wrote:
> >
> > Refactor spawn_command() to use execv() instead of system() to eliminate
> > shell injection vulnerabilities.
> >
> > Reported-By: Rahul Sandhu <nvraxn@gmail.com>
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> 
> Acked-by: James Carter <jwcart2@gmail.com>

Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied

> 
> > ---
> > v2  - drop index initialization
> >
> >  sandbox/seunshare.c | 132 ++++++++++++++++++++++++++------------------
> >  1 file changed, 79 insertions(+), 53 deletions(-)
> >
> > diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> > index 65da46463a8f..2512a18c7b52 100644
> > --- a/sandbox/seunshare.c
> > +++ b/sandbox/seunshare.c
> > @@ -56,6 +56,12 @@
> >  #define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] \
> >  [ -r runuserdir ] [ -P pipewiresocket ] [ -W waylandsocket ] [ -Z CONTEXT ] -- executable [args] ")
> >
> > +#define strdup_or_err(args, index, src) do {   \
> > +               args[index] = strdup(src); \
> > +               if (! args[index]) \
> > +                       goto err; \
> > +       } while(0)
> > +
> >  static int verbose = 0;
> >  static int child = 0;
> >
> > @@ -136,15 +142,14 @@ static int set_signal_handles(void)
> >         } while(0)
> >
> >  /**
> > - * Spawn external command using system() with dropped privileges.
> > - * TODO: avoid system() and use exec*() instead
> > + * Spawn external command with dropped privileges.
> >   */
> > -static int spawn_command(const char *cmd, uid_t uid){
> > +static int spawn_command(char **cmd, uid_t uid){
> >         int childpid;
> >         int status = -1;
> >
> >         if (verbose > 1)
> > -               printf("spawn_command: %s\n", cmd);
> > +               printf("spawn_command: %s\n", cmd[0]);
> >
> >         childpid = fork();
> >         if (childpid == -1) {
> > @@ -155,8 +160,7 @@ static int spawn_command(const char *cmd, uid_t uid){
> >         if (childpid == 0) {
> >                 if (drop_privs(uid) != 0) exit(-1);
> >
> > -               status = system(cmd);
> > -               status_to_retval(status, status);
> > +               status = execv(cmd[0], cmd);
> >                 exit(status);
> >         }
> >
> > @@ -342,15 +346,24 @@ static int bad_path(const char *path) {
> >         return 0;
> >  }
> >
> > -static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
> > -{
> > +static void free_args(char **args) {
> > +       char **args_p = args;
> > +       if (! args)
> > +               return;
> > +       while (*args_p != NULL) {
> > +               free(*args_p);
> > +               args_p++;
> > +       }
> > +       free(args);
> > +}
> > +
> > +static int rsynccmd(const char * src, const char *dst, char ***cmd) {
> > +       char **args;
> >         char *buf = NULL;
> > -       char *newbuf = NULL;
> >         glob_t fglob;
> >         fglob.gl_offs = 0;
> >         int flags = GLOB_PERIOD;
> > -       unsigned int i = 0;
> > -       int rc = -1;
> > +       unsigned int i = 0, index;
> >
> >         /* match glob for all files in src dir */
> >         if (asprintf(&buf, "%s/*", src) == -1) {
> > @@ -365,43 +378,35 @@ static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
> >
> >         free(buf); buf = NULL;
> >
> > -       for ( i=0; i < fglob.gl_pathc; i++) {
> > -               const char *path = fglob.gl_pathv[i];
> > -
> > -               if (bad_path(path)) continue;
> > -
> > -               if (!buf) {
> > -                       if (asprintf(&newbuf, "\'%s\'", path) == -1) {
> > -                               fprintf(stderr, _("Out of memory\n"));
> > -                               goto err;
> > -                       }
> > -               } else {
> > -                       if (asprintf(&newbuf, "%s  \'%s\'", buf, path) == -1) {
> > -                               fprintf(stderr, _("Out of memory\n"));
> > -                               goto err;
> > -                       }
> > -               }
> > -
> > -               free(buf); buf = newbuf;
> > -               newbuf = NULL;
> > +       /* rsync  -trlHDq + <glob list> + dst + NULL */
> > +       *cmd = calloc(2 + fglob.gl_pathc + 2, sizeof(char *));
> > +       if (! *cmd) {
> > +               fprintf(stderr, _("Out of memory\n"));
> > +               return -1;
> >         }
> >
> > -       if (buf) {
> > -               if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", buf, dst) == -1) {
> > -                       fprintf(stderr, _("Out of memory\n"));
> > -                       goto err;
> > -               }
> > -               *cmdbuf=newbuf;
> > -       }
> > -       else {
> > -               *cmdbuf=NULL;
> > -       }
> > -       rc = 0;
> > +       args = *cmd;
> > +       strdup_or_err(args, 0, "/usr/bin/rsync");
> > +       strdup_or_err(args, 1, "-trlHDq");
> >
> > +       for ( i=0, index = 2; i < fglob.gl_pathc; i++) {
> > +               const char *path = fglob.gl_pathv[i];
> > +               if (bad_path(path)) continue;
> > +               strdup_or_err(args, index, path);
> > +               index++;
> > +       }
> > +       strdup_or_err(args, index, dst);
> > +       index++;
> > +       args[index] = NULL;
> > +       globfree(&fglob);
> > +       return 0;
> >  err:
> > -       free(buf); buf = NULL;
> >         globfree(&fglob);
> > -       return rc;
> > +       if (args) {
> > +               free_args(args);
> > +               *cmd = NULL;
> > +       }
> > +       return -1;
> >  }
> >
> >  /*
> > @@ -472,21 +477,38 @@ static bool rm_rf(int targetfd, const char *path) {
> >  static int cleanup_tmpdir(const char *tmpdir, const char *src,
> >         struct passwd *pwd, int copy_content)
> >  {
> > -       char *cmdbuf = NULL;
> > +       char **args;
> >         int rc = 0;
> >
> >         /* rsync files back */
> >         if (copy_content) {
> > -               if (asprintf(&cmdbuf, "/usr/bin/rsync --exclude=.X11-unix -utrlHDq --delete '%s/' '%s/'", tmpdir, src) == -1) {
> > +               args = calloc(7, sizeof(char *));
> > +               if (! args) {
> >                         fprintf(stderr, _("Out of memory\n"));
> > -                       cmdbuf = NULL;
> > -                       rc++;
> > +                       return 1;
> > +               }
> > +
> > +               strdup_or_err(args, 0, "/usr/bin/rsync");
> > +               strdup_or_err(args, 1, "--exclude=.X11-unix");
> > +               strdup_or_err(args, 2, "-utrlHDq");
> > +               strdup_or_err(args, 3, "--delete");
> > +               if (asprintf(&args[4], "%s/", tmpdir) == -1) {
> > +                       fprintf(stderr, _("Out of memory\n"));
> > +                       free_args(args);
> > +                       return 1;
> >                 }
> > -               if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) {
> > +               if (asprintf(&args[5], "%s/", src) == -1) {
> > +                       fprintf(stderr, _("Out of memory\n"));
> > +                       free_args(args);
> > +                       return 1;
> > +               }
> > +               args[6] = NULL;
> > +
> > +               if (spawn_command(args, pwd->pw_uid) != 0) {
> >                         fprintf(stderr, _("Failed to copy files from the runtime temporary directory\n"));
> >                         rc++;
> >                 }
> > -               free(cmdbuf); cmdbuf = NULL;
> > +               free_args(args);
> >         }
> >
> >         if ((uid_t)setfsuid(0) != 0) {
> > @@ -506,6 +528,10 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
> >         }
> >
> >         return rc;
> > +err:
> > +       if (args)
> > +               free_args(args);
> > +       return 1;
> >  }
> >
> >  /**
> > @@ -518,7 +544,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
> >         struct stat *out_st, struct passwd *pwd, const char *execcon)
> >  {
> >         char *tmpdir = NULL;
> > -       char *cmdbuf = NULL;
> > +       char **cmd = NULL;
> >         int fd_t = -1, fd_s = -1;
> >         struct stat tmp_st;
> >         char *con = NULL;
> > @@ -605,7 +631,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
> >         if ((uid_t)setfsuid(pwd->pw_uid) != 0)
> >                 goto err;
> >
> > -       if (rsynccmd(src, tmpdir, &cmdbuf) < 0) {
> > +       if (rsynccmd(src, tmpdir, &cmd) < 0) {
> >                 goto err;
> >         }
> >
> > @@ -613,7 +639,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
> >         if ((uid_t)setfsuid(0) != pwd->pw_uid)
> >                 goto err;
> >
> > -       if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) != 0) {
> > +       if (spawn_command(cmd, pwd->pw_uid) != 0) {
> >                 fprintf(stderr, _("Failed to populate runtime temporary directory\n"));
> >                 cleanup_tmpdir(tmpdir, src, pwd, 0);
> >                 goto err;
> > @@ -623,7 +649,7 @@ static char *create_tmpdir(const char *src, struct stat *src_st,
> >  err:
> >         free(tmpdir); tmpdir = NULL;
> >  good:
> > -       free(cmdbuf); cmdbuf = NULL;
> > +       free_args(cmd);
> >         freecon(con); con = NULL;
> >         if (fd_t >= 0) close(fd_t);
> >         if (fd_s >= 0) close(fd_s);
> > --
> > 2.52.0
> >
> >
> 
