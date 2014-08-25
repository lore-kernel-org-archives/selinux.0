Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7PHChiP007727
 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2014 13:12:48 -0400
Message-ID: <53FB6E80.6060700@tresys.com>
Date: Mon, 25 Aug 2014 13:12:32 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Currently we can end up with different permissions on the compiled
 file_context regex files than the original.
References: <53F4B02C.90701@redhat.com>
In-Reply-To: <53F4B02C.90701@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> +	if (stat(path, &buf) < 0) {
> +		fprintf(stderr, "Can not stat: %s: %m\n", argv[0]);

Should the fprintf print path instead of argv[0]?

> +		exit(EXIT_FAILURE);
> +	}
> +

Looks good otherwise. I'll add to the repo with that change if that's okay.

- Steve
