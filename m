Message-ID: <4A9E6406.5000501@martinorr.name>
Date: Wed, 02 Sep 2009 13:24:38 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: restorecon and symbolic links
References: <4A996106.4060604@martinorr.name>	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>	 <4A9BCE45.7060704@martinorr.name>	 <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>	 <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name> <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/09/09 15:46, Stephen Smalley wrote:
> On Tue, 2009-09-01 at 15:34 +0100, Martin Orr wrote:
>> Here's a patch that works, and does what I want.
>>
>> It moves most of process_one into process_one_realpath, which assumes that
>> the path it is given requires no further expansion.
>> Now if given a symlink, call symlink_realpath to get the real path ignoring
>> the last component, and give that to process_one_realpath; tell
>> process_one_realpath not to recurse so this acts on the symlink only.
>> Then call process_one_realpath again with the real path of the target, to
>> recurse into it.
> 
> The function naming seems the reverse of what one might expect (the
> function with _realpath in the name doesn't call realpath).   Also, you
> can pass NULL for the resolved path argument to realpath() rather than
> giving it a fixed-size buffer from the stack and let it allocate the
> buffer for you, as we already do elsewhere.

The reason I named the function that way was because the function with
_realpath expects a real path as an argument, but if this is confusing or
goes against a convention used elsewhere then it could be changed.

I copied the symlink_realpath code from what used to be in match.  I assumed
that it needed a buffer on the stack because it then concatenates the last
component of the path on to that buffer, and realpath might not allocate a
long enough buffer.

> > Not sure it is worth warning about the broken symlink case, and that
> > will trigger warnings for your existing users in the
> > restorecon /dev/stdin case, right?

I agree, it is not worth warning about broken symlinks, except maybe if -v
is specified.

>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>> index 4c47f21..c84cd6f 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -545,7 +545,47 @@ int canoncon(char **contextp)
>>  	return rc;
>>  }
>>  
>> -static int process_one(char *name)
>> +static int symlink_realpath(char *name, char *path)
>> +{
>> +	char *p = NULL, *file_sep;
>> +	char *tmp_path = strdupa(name);
>> +	size_t len = 0;
>> +
>> +	if (!tmp_path) {
>> +		fprintf(stderr, "strdupa on %s failed:  %s\n", name,
>> +			strerror(errno));
>> +		return -1;
>> +	}
>> +	file_sep = strrchr(tmp_path, '/');
>> +	if (file_sep == tmp_path) {
>> +		file_sep++;
>> +		p = strcpy(path, "");
>> +	} else if (file_sep) {
>> +		*file_sep = 0;
>> +		file_sep++;
>> +		p = realpath(tmp_path, path);
>> +	} else {
>> +		file_sep = tmp_path;
>> +		p = realpath("./", path);
>> +	}
>> +	if (p)
>> +		len = strlen(p);
>> +	if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
>> +		fprintf(stderr, "symlink_realpath(%s) failed %s\n", name,
>> +			strerror(errno));
>> +		return -1;
>> +	}
>> +	p += len;
>> +	/* ensure trailing slash of directory name */
>> +	if (len == 0 || *(p - 1) != '/') {
>> +		*p = '/';
>> +		p++;
>> +	}
>> +	strcpy(p, file_sep);
>> +	return 0;
>> +}
>> +
>> +static int process_one_realpath(char *name, int recurse_this_path)
>>  {
>>  	int rc = 0;
>>  	const char *namelist[2];
>> @@ -553,18 +593,6 @@ static int process_one(char *name)
>>  	FTS *fts_handle;
>>  	FTSENT *ftsent;
>>  
>> -	if (expand_realpath) {
>> -		char *p;
>> -		p = realpath(name, NULL);
>> -		if (!p) {
>> -			fprintf(stderr, "realpath(%s) failed %s\n", name,
>> -				strerror(errno));
>> -			return -1;
>> -		}
>> -		name = p;
>> -	}
>> -
>> -
>>  	if (!strcmp(name, "/"))
>>  		mass_relabel = 1;
>>  
>> @@ -604,7 +632,7 @@ static int process_one(char *name)
>>  			fts_set(fts_handle, ftsent, FTS_SKIP);
>>  		if (rc == ERR)
>>  			goto err;
>> -		if (!recurse)
>> +		if (!recurse_this_path)
>>  			break;
>>  	} while ((ftsent = fts_read(fts_handle)) != NULL);
>>  
>> @@ -619,8 +647,6 @@ out:
>>  	}
>>  	if (fts_handle)
>>  		fts_close(fts_handle);
>> -	if (expand_realpath)
>> -		free(name);
>>  	return rc;
>>  
>>  err:
>> @@ -630,6 +656,55 @@ err:
>>  	goto out;
>>  }
>>  
>> +static int process_one(char *name)
>> +{
>> +	int rc = 0;
>> +	char *p;
>> +	struct stat sb;
>> +
>> +	if (!expand_realpath) {
>> +		return process_one_realpath(name, recurse);
>> +	} else {
>> +		rc = lstat(name, &sb);
>> +		if (rc < 0) {
>> +			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
>> +				progname, name,	strerror(errno));
>> +			return -1;
>> +		}
>> +
>> +		if (S_ISLNK(sb.st_mode)) {
>> +			char path[PATH_MAX + 1];
>> +
>> +			rc = symlink_realpath(name, path);
>> +			if (rc < 0)
>> +				return rc;
>> +			rc = process_one_realpath(path, 0);
>> +			if (rc < 0)
>> +				return rc;
>> +
>> +			p = realpath(name, NULL);
>> +			if (!p) {
>> +				fprintf(stderr, "Warning: %s: Broken symlink: %s\n",
>> +					name, strerror(errno));
>> +				return 0;
>> +			}
>> +			rc = process_one_realpath(p, recurse);
>> +			free(p);
>> +			return rc;
>> +		} else {
>> +			p = realpath(name, NULL);
>> +			if (!p) {
>> +				fprintf(stderr, "realpath(%s) failed %s\n", name,
>> +					strerror(errno));
>> +				return -1;
>> +			}
>> +			rc = process_one_realpath(p, recurse);
>> +			free(p);
>> +			return rc;
>> +		}
>> +	}
>> +}
>> +
>>  #ifndef USE_AUDIT
>>  static void maybe_audit_mass_relabel(void)
>>  {
>>


-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
