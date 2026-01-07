Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589330F53A
	for <selinux@vger.kernel.org>; Wed,  7 Jan 2026 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789532; cv=none; b=bJ8aAGOphc4qIIqWl9Jxyregm6dSBYt9gQ1Cju/S0eBtOckZJpuaMuxI5ZCy7nw4wATSLXQsi86H0OXF99fOP3cfGhi0EdVH/LIGxGsHuvc3oiJGTkbYjcs34OuzvQ77xrPzCzKmQrdLDiGSNpWQGYP+avAvS+L4/KhcICboPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789532; c=relaxed/simple;
	bh=1ZEaLhZWEu5qT8nq4Pic07F6f6ty+wL7eSmReNC0eVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A7beWpa4Z38FtbvYwA0xfUagVSlBU9olBUg8J9SCb6KMnn9Z9htgwxkfsdjxiaO/1D8w344amCDtS76vvqu4Z8HRtvp0Ww5Y/SPZIrBSzMkJTyv1vnuMq5WHV4ucGG84ah69vd7KxGoEPKbuowSeaSE/wHgMaZKr0rXBh16/LiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCNvy/B3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCNvy/B3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso7718275e9.2
        for <selinux@vger.kernel.org>; Wed, 07 Jan 2026 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767789529; x=1768394329; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuhhAti8ePuELlB699xMhhhufVllTtjpYGZdBjBTgU4=;
        b=fCNvy/B3xGt1p1EIU1eMqmzgTOaMF3OFYfNXlAra9g5JbQVEpwQkSq5dv7yMvHL4S0
         mN2d6nyQcKrCXDwMIrAMw6SAJ7OECNouCIqPBDzqthQcvngB9mwQScdHkLYZOASlVUv4
         AqmHcAhat+K4vSwriGaTCkZCt/G79vHb4EtiAE0BRXC8uLyAjYQ7H0ypQRtdSvLQyMBs
         Kq76SFdtdfMlRb+FioEMCLog+Zq54J7C5gk60ZP7XJwjqQH8FpTAZmx6BMuyLWKmFioV
         qH5sXLnI38i3lNNgtIcy1X3vQi9gUX/179hOWvji43Dgt0HzlEZOiXLcWhZcZdSxdqEP
         74Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789529; x=1768394329;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuhhAti8ePuELlB699xMhhhufVllTtjpYGZdBjBTgU4=;
        b=xALkKrGL23TmRUShJFLPjDBX+xFgX1jGnkQckhF1CfugqXN5XuJXVa9swozfrY0tud
         3Tbr3JAhVPmopwzdByU+24pjgHFQ8JSY3Pw6XKQwWNQBU/u+I++qZL8wHT+Yc40awuSA
         krMwcY1l9sK3vo5S/2tqOM3mfSguEPTKZCtFcliyTsAIv5urn1mMIMrSPFIDBVpVtpfq
         rtbCK8Pqirf+vrwioOx/E0SKReIwx/JTN/fxmVEnmp7bv5i/nVoRiV9tVz6kCpnDW/0/
         WWenowisfgWxNzZ0jg3cuuB5ogtelevP98fNzwmjC4HJlTWnPR2k3lI/V+yuxrihWdF0
         SQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCVRzXhGWM6FDsQieRpnpa/8+ruT3U7G/ip8C0EeEuCb+TNM4A8kaXwpTvoEwGp0H6gjbX8kQgJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YxygYXE9kjFvvIdUYqFg29ShtixLA9gjzOeeQs8jEM+O0Sy3PUE
	hPDN9kutbHxUn6g4PooM2dhA3IW/z7lWI/l9dIrDgdzgH3awjQCz66pe
X-Gm-Gg: AY/fxX5jlim85RRWNSu2qLoGSV3HrFzIkZAu/q/oX8cwOlFIXHqBP3hLhkI3QAlYl2Z
	ZO3VIV+SzKnyEgy3EapoYhknY1Xpih3+6WIVFpQ763v/9ZBkR3XO0U4NpT4qxtmWDGJzE1OGJ8A
	qpbi30glTJ5RdxuyJCdJ4gEXmjoR5xhM92iDaWjo/EGCAbRRjbX51zkfetcqsuIcLo/GKSroQoE
	5V0VMNK9fJiH+tKptHsPamFXggIJQ2QfducTaMrkvRWpPab5XXufnE2JzFQJXfY9W1QiuztqouZ
	ShR245+qJFvdMQP5PtBe7N9DEw/9QxQjKlVYBmWd2RDenjvJFLdocU3wC0hXE/geu+m49upP9/G
	YcyJS94xg9I2DvWWZoI8eoyezzNRrDBXM+Q/6GkT4QHvtCrPzvIOSahOllhO9/YDF7platWw=
X-Google-Smtp-Source: AGHT+IEuWLhXwa8pLmsC0XlvY5X9COcvls4Rf7n31EK9hXgnIp5uD/0+FV8hAHeSreegQWLHOUT/6A==
X-Received: by 2002:a05:600c:a48:b0:47a:829a:ebb with SMTP id 5b1f17b1804b1-47d84b36a2amr25448215e9.19.1767789528482;
        Wed, 07 Jan 2026 04:38:48 -0800 (PST)
Received: from localhost ([2a0a:ef40:90a:9600:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm98827715e9.14.2026.01.07.04.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 04:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Jan 2026 12:38:47 +0000
Message-Id: <DFID35MI20QY.1TO7H1O354V64@gmail.com>
Cc: "Rahul Sandhu" <nvraxn@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: Replace system() with execv() to
 prevent shell injection
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Petr Lautrbach" <lautrbach@redhat.com>, <selinux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260107114900.1482675-1-lautrbach@redhat.com>
In-Reply-To: <20260107114900.1482675-1-lautrbach@redhat.com>

On Wed Jan 7, 2026 at 11:48 AM GMT, Petr Lautrbach wrote:
> Refactor spawn_command() to use execv() instead of system() to eliminate
> shell injection vulnerabilities.
>
> Reported-By: Rahul Sandhu <nvraxn@gmail.com>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>  sandbox/seunshare.c | 132 ++++++++++++++++++++++++++------------------
>  1 file changed, 79 insertions(+), 53 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 65da46463a8f..74b87b7d13ec 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -56,6 +56,12 @@
>  #define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdi=
r ] [ -h homedir ] \
>  [ -r runuserdir ] [ -P pipewiresocket ] [ -W waylandsocket ] [ -Z CONTEX=
T ] -- executable [args] ")
> =20
> +#define strdup_or_err(args, index, src) do {	\
> +		args[index] =3D strdup(src); \
> +		if (! args[index]) \
> +			goto err; \
> +	} while(0)
> +
>  static int verbose =3D 0;
>  static int child =3D 0;
> =20
> @@ -136,15 +142,14 @@ static int set_signal_handles(void)
>  	} while(0)
> =20
>  /**
> - * Spawn external command using system() with dropped privileges.
> - * TODO: avoid system() and use exec*() instead
> + * Spawn external command with dropped privileges.
>   */
> -static int spawn_command(const char *cmd, uid_t uid){
> +static int spawn_command(char **cmd, uid_t uid){
>  	int childpid;
>  	int status =3D -1;
> =20
>  	if (verbose > 1)
> -		printf("spawn_command: %s\n", cmd);
> +		printf("spawn_command: %s\n", cmd[0]);
> =20
>  	childpid =3D fork();
>  	if (childpid =3D=3D -1) {
> @@ -155,8 +160,7 @@ static int spawn_command(const char *cmd, uid_t uid){
>  	if (childpid =3D=3D 0) {
>  		if (drop_privs(uid) !=3D 0) exit(-1);
> =20
> -		status =3D system(cmd);
> -		status_to_retval(status, status);
> +		status =3D execv(cmd[0], cmd);
>  		exit(status);
>  	}
> =20
> @@ -342,15 +346,24 @@ static int bad_path(const char *path) {
>  	return 0;
>  }
> =20
> -static int rsynccmd(const char * src, const char *dst, char **cmdbuf)
> -{
> +static void free_args(char **args) {
> +	char **args_p =3D args;
> +	if (! args)
> +		return;
> +	while (*args_p !=3D NULL) {
> +		free(*args_p);
> +		args_p++;
> +	}
> +	free(args);
> +}
> +
> +static int rsynccmd(const char * src, const char *dst, char ***cmd) {
> +	char **args;
>  	char *buf =3D NULL;
> -	char *newbuf =3D NULL;
>  	glob_t fglob;
>  	fglob.gl_offs =3D 0;
>  	int flags =3D GLOB_PERIOD;
> -	unsigned int i =3D 0;
> -	int rc =3D -1;
> +	unsigned int i =3D 0, index =3D 0;

Why initalize this as 0?

> =20
>  	/* match glob for all files in src dir */
>  	if (asprintf(&buf, "%s/*", src) =3D=3D -1) {
> @@ -365,43 +378,35 @@ static int rsynccmd(const char * src, const char *d=
st, char **cmdbuf)
> =20
>  	free(buf); buf =3D NULL;
> =20
> -	for ( i=3D0; i < fglob.gl_pathc; i++) {
> -		const char *path =3D fglob.gl_pathv[i];
> -
> -		if (bad_path(path)) continue;
> -
> -		if (!buf) {
> -			if (asprintf(&newbuf, "\'%s\'", path) =3D=3D -1) {
> -				fprintf(stderr, _("Out of memory\n"));
> -				goto err;
> -			}
> -		} else {
> -			if (asprintf(&newbuf, "%s  \'%s\'", buf, path) =3D=3D -1) {
> -				fprintf(stderr, _("Out of memory\n"));
> -				goto err;
> -			}
> -		}
> -
> -		free(buf); buf =3D newbuf;
> -		newbuf =3D NULL;
> +	/* rsync  -trlHDq + <glob list> + dst + NULL */
> +	*cmd =3D calloc(2 + fglob.gl_pathc + 2, sizeof(char *));
> +	if (! *cmd) {
> +		fprintf(stderr, _("Out of memory\n"));
> +		return -1;
>  	}
> =20
> -	if (buf) {
> -		if (asprintf(&newbuf, "/usr/bin/rsync -trlHDq %s '%s'", buf, dst) =3D=
=3D -1) {
> -			fprintf(stderr, _("Out of memory\n"));
> -			goto err;
> -		}
> -		*cmdbuf=3Dnewbuf;
> -	}
> -	else {
> -		*cmdbuf=3DNULL;
> -	}
> -	rc =3D 0;
> +	args =3D *cmd;
> +	strdup_or_err(args, 0, "/usr/bin/rsync");
> +	strdup_or_err(args, 1, "-trlHDq");
> =20
> +	for ( i=3D0, index =3D 2; i < fglob.gl_pathc; i++) {

The next reference to it is here, where it's simply set as two, so it
would probably look nicer to get rid of the above decl and just change
it to:

for (int i =3D 0, index =3D 2; i < fglob.gl_pathc; i++) {

> +		const char *path =3D fglob.gl_pathv[i];
> +		if (bad_path(path)) continue;
> +		strdup_or_err(args, index, path);
> +		index++;
> +	}
> +	strdup_or_err(args, index, dst);
> +	index++;
> +	args[index] =3D NULL;
> +	globfree(&fglob);
> +	return 0;
>  err:
> -	free(buf); buf =3D NULL;
>  	globfree(&fglob);
> -	return rc;
> +	if (args) {
> +		free_args(args);
> +		*cmd =3D NULL;
> +	}
> +	return -1;
>  }
> =20
>  /*
> @@ -472,21 +477,38 @@ static bool rm_rf(int targetfd, const char *path) {
>  static int cleanup_tmpdir(const char *tmpdir, const char *src,
>  	struct passwd *pwd, int copy_content)
>  {
> -	char *cmdbuf =3D NULL;
> +	char **args;
>  	int rc =3D 0;
> =20
>  	/* rsync files back */
>  	if (copy_content) {
> -		if (asprintf(&cmdbuf, "/usr/bin/rsync --exclude=3D.X11-unix -utrlHDq -=
-delete '%s/' '%s/'", tmpdir, src) =3D=3D -1) {
> +		args =3D calloc(7, sizeof(char *));
> +		if (! args) {
>  			fprintf(stderr, _("Out of memory\n"));
> -			cmdbuf =3D NULL;
> -			rc++;
> +			return 1;
> +		}
> +
> +		strdup_or_err(args, 0, "/usr/bin/rsync");
> +		strdup_or_err(args, 1, "--exclude=3D.X11-unix");
> +		strdup_or_err(args, 2, "-utrlHDq");
> +		strdup_or_err(args, 3, "--delete");
> +		if (asprintf(&args[4], "%s/", tmpdir) =3D=3D -1) {
> +			fprintf(stderr, _("Out of memory\n"));
> +			free_args(args);
> +			return 1;
>  		}
> -		if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) {
> +		if (asprintf(&args[5], "%s/", src) =3D=3D -1) {
> +			fprintf(stderr, _("Out of memory\n"));
> +			free_args(args);
> +			return 1;
> +		}
> +		args[6] =3D NULL;
> +
> +		if (spawn_command(args, pwd->pw_uid) !=3D 0) {
>  			fprintf(stderr, _("Failed to copy files from the runtime temporary di=
rectory\n"));
>  			rc++;
>  		}
> -		free(cmdbuf); cmdbuf =3D NULL;
> +		free_args(args);
>  	}
> =20
>  	if ((uid_t)setfsuid(0) !=3D 0) {
> @@ -506,6 +528,10 @@ static int cleanup_tmpdir(const char *tmpdir, const =
char *src,
>  	}
> =20
>  	return rc;
> +err:
> +	if (args)
> +		free_args(args);
> +	return 1;
>  }
> =20
>  /**
> @@ -518,7 +544,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>  	struct stat *out_st, struct passwd *pwd, const char *execcon)
>  {
>  	char *tmpdir =3D NULL;
> -	char *cmdbuf =3D NULL;
> +	char **cmd =3D NULL;
>  	int fd_t =3D -1, fd_s =3D -1;
>  	struct stat tmp_st;
>  	char *con =3D NULL;
> @@ -605,7 +631,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>  	if ((uid_t)setfsuid(pwd->pw_uid) !=3D 0)
>  		goto err;
> =20
> -	if (rsynccmd(src, tmpdir, &cmdbuf) < 0) {
> +	if (rsynccmd(src, tmpdir, &cmd) < 0) {
>  		goto err;
>  	}
> =20
> @@ -613,7 +639,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>  	if ((uid_t)setfsuid(0) !=3D pwd->pw_uid)
>  		goto err;
> =20
> -	if (cmdbuf && spawn_command(cmdbuf, pwd->pw_uid) !=3D 0) {
> +	if (spawn_command(cmd, pwd->pw_uid) !=3D 0) {
>  		fprintf(stderr, _("Failed to populate runtime temporary directory\n"))=
;
>  		cleanup_tmpdir(tmpdir, src, pwd, 0);
>  		goto err;
> @@ -623,7 +649,7 @@ static char *create_tmpdir(const char *src, struct st=
at *src_st,
>  err:
>  	free(tmpdir); tmpdir =3D NULL;
>  good:
> -	free(cmdbuf); cmdbuf =3D NULL;
> +	free_args(cmd);
>  	freecon(con); con =3D NULL;
>  	if (fd_t >=3D 0) close(fd_t);
>  	if (fd_s >=3D 0) close(fd_s);

