Subject: Re: [PATCH] newrole: use pam session management services
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <1154377198.26550.171.camel@localhost.localdomain>
References: <1154108936.7907.4.camel@localhost.localdomain>
	 <1154377198.26550.171.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 17:13:53 -0400
Message-Id: <1154380433.25740.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 16:19 -0400, Karl MacMillan wrote:
> On Fri, 2006-07-28 at 13:48 -0400, Janak Desai wrote:
> <snip>
> 
> > +int namespace_via_pam(const struct passwd *pw)
> > +{
> > +
> > +	int result = 0;	/* set result to 0 (namespace not set) by default */
> > +	int rc;		/* pam return code */
> > +	pam_handle_t *pam_handle; /* opaque handle used by all PAM functions */
> > +
> > +	/* This is a jump table of functions for PAM to use when it wants to *
> > +	 * communicate with the user.  We'll be using misc_conv(), which is  *
> > +	 * provided for us via pam_misc.h.                                   */
> > +	struct pam_conv pam_conversation = {
> > +		misc_conv,
> > +		NULL
> > +	};
> > +
> > +	/* Make `p_pam_handle' a valid PAM handle so we can use it when *
> > +	 * calling PAM functions.                                       */
> > +	rc = pam_start(SERVICE_NAME, pw->pw_name, &pam_conversation,
> > +		&pam_handle);
> > +	if(rc != PAM_SUCCESS) {
> > +		fprintf(stderr, _("failed to initialize PAM\n"));
> > +		exit(-1);
> 
> Why not return an error code instead? 0 seems to be the error code for
> most of the code (strange as that is) - seems appropriate to return
> that.
> 

I was following the example of the other pam_star()t call in 
authenticate_via_pam(). Basically, I followed authenticate_via_pam
logic, return codes, style etc when coding namespace_via_pam.

> > +	}
> > +
> > +	/* Ask PAM to setup session for user running this program */
> > +	rc = pam_open_session(pam_handle,0);
> > +		if(rc == PAM_SUCCESS) {
> > +		result = 1;  /* Namespace setup OK! */
> > +	}
> > +
> 
> Looks like there is some code in policycoreutils that wants to use 1 for
> success and 0 for error - so you are following the convention. It is
> unfortunate as it doesn't match the bulk of the selinux code. Auditing
> and fixing it would be nice, but I don't think it is necessary.
> 
> > +	/* We're done with PAM.  Free `pam_handle'. */
> > +	pam_end(pam_handle, rc);
> > +
> > +	return(result);
> 
> Most SELinux code thinks return is a keyword and not a function, though
> several of the policycoreutils programs think otherwise. Oh well -
> again, it would be nice to clean this up but it is probably low
> priority.
> 
> Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
