Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u53Cu1qY028058
 for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2016 08:56:05 -0400
Received: by mail-qg0-f42.google.com with SMTP id q32so10980393qgq.3
 for <selinux@tycho.nsa.gov>; Fri, 03 Jun 2016 05:55:52 -0700 (PDT)
Received: from strange.local ([50.253.7.1])
 by smtp.googlemail.com with ESMTPSA id 127sm1463211qhg.49.2016.06.03.05.55.51
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Fri, 03 Jun 2016 05:55:51 -0700 (PDT)
Message-ID: <57517E56.4090909@quarksecurity.com>
Date: Fri, 03 Jun 2016 08:55:50 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Modify audit2why analyze function to use loaded policy
References: <1464913152-28265-1-git-send-email-brindle@quarksecurity.com>
In-Reply-To: <1464913152-28265-1-git-send-email-brindle@quarksecurity.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Joshua Brindle wrote:
> Class and perms should come from the policy being used for analysis,
> not the system policy so use sepol_ interfaces
>

Hrm, this solved my original problem which was that I was getting the 
wrong answer back from audit2why (classes in my policy that weren't in 
the system policy can back with BADTCLASS instead of a more appropriate 
answer) but now I have a segfault so I'll try to track that down.

> Change-Id: Ia0590ed2514249fd98810a8d4fe87f8bf5280561
> ---
>   libselinux/src/audit2why.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 12745b3..abe1701 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -343,8 +343,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
>   	if (rc<  0)
>   		RETURN(BADTCON)
>
> -	tclass = string_to_security_class(tclassstr);
> -	if (!tclass)
> +	rc = sepol_string_to_security_class(tclassstr,&tclass);
> +	if (rc<  0)
>   		RETURN(BADTCLASS)
>
>   	/* Convert the permission list to an AV. */
> @@ -365,8 +365,8 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
>   		permstr = PyString_AsString( strObj );
>   #endif
>   		
> -		perm = string_to_av_perm(tclass, permstr);
> -		if (!perm)
> +		rc = sepol_string_to_av_perm(tclass, permstr,&perm);
> +		if (rc<  0)
>   			RETURN(BADPERM)
>
>   		av |= perm;
