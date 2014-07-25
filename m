Message-ID: <53D2B3ED.2070102@quarksecurity.com>
Date: Fri, 25 Jul 2014 15:45:49 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] [PATCH] libsemanage: Skip policy module re-link when only
 setting booleans.
References: <53D28DBB.8000905@tycho.nsa.gov>
In-Reply-To: <53D28DBB.8000905@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley wrote:
> Motivated by:
> https://bugzilla.redhat.com/show_bug.cgi?id=1098446
>
> I believe this is always safe for booleans because we only set their
> value; we are never adding new ones via semanage, unlike for example
> users, ports, nodes, and interfaces.  For the rest, I was wondering why
> we don't save the linked file and just reuse it on those changes rather
> than re-linking each time - that seems like it would be straightforward

We originally kept the linked copy around and had intended to do what 
you are saying above but removed it when the minimal Red Hat guys 
complained about the size of it.

> to do in libsemanage and make those operations significantly faster and
> less memory intensive.
