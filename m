Date: Mon, 6 Nov 2006 22:54:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 2/8] make newrole suid (take 3)
Message-ID: <20061107045404.GA11273@sergelap.austin.ibm.com>
References: <454A8F35.2020006@us.ibm.com> <454A9566.1000304@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <454A9566.1000304@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Michael C Thompson (thompsmc@us.ibm.com):
> +	setpwent();
> +	pw = getpwuid(uid);
> +	endpwent();

Why the set/endpwent() calls?  The original code didn't have them,
and you aren't useing getpwent() so they don't seem to do anything.

> +	if (!(pw && pw->pw_name && pw->pw_name[0] && pw->pw_shell
> +	      && pw->pw_shell[0] && pw->pw_dir && pw->pw_dir[0])) {
> +		fprintf(stderr,
> +			_("cannot find valid entry in the passwd file.\n"));
> +		return -1;
> +	}
> +
> +	*pw_copy = *pw;
> +	pw = pw_copy;
> +	pw->pw_name = strdup(pw->pw_name);

You switched from xstrdup to strdup - don't know whether that means
anything...

> +	pw->pw_dir = strdup(pw->pw_dir);
> +	pw->pw_shell = strdup(pw->pw_shell);

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
