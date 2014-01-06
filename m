Message-ID: <52CAF1DC.9080300@tycho.nsa.gov>
Date: Mon, 06 Jan 2014 13:11:40 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org> <52C27333.3060801@networkcrypt.com>
 <52C31282.6080809@mthode.org> <52CAD237.3060701@redhat.com>
 <52CAECB7.6050500@tycho.nsa.gov> <52CAEF39.6020404@redhat.com>
In-Reply-To: <52CAEF39.6020404@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/06/2014 01:00 PM, Daniel J Walsh wrote:
> How is returning a ERRNO/ERROR for bad values hiding bugs from callers?  We
> are actually telling the callers what is bad.

Not really.  Stack trace is more informative than EINVAL, as the one
will show you exactly where you failed and what the arguments were,
whereas EINVAL could be a result of any of the arguments or a side
effect elsewhere in the function.  And the original functions that
prompted this discussion have never allowed you to pass NULL as
contexts.  Would you add a NULL check inside of every string.h function
in libc?
