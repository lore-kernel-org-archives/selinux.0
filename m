Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s06HnjVe011392
 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2014 12:49:45 -0500
Message-ID: <52CAECB7.6050500@tycho.nsa.gov>
Date: Mon, 06 Jan 2014 12:49:43 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org> <52C27333.3060801@networkcrypt.com>
 <52C31282.6080809@mthode.org> <52CAD237.3060701@redhat.com>
In-Reply-To: <52CAD237.3060701@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/06/2014 10:56 AM, Daniel J Walsh wrote:
> How about this patch?

I'm not in favor.  We shouldn't hide bugs in the callers.
