Message-ID: <53739A7F.6090902@tycho.nsa.gov>
Date: Wed, 14 May 2014 12:31:59 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Mladen Sekara <dev@emefes.com>, selinux@tycho.nsa.gov
Subject: Re: Single init script for multiple daemons
References: <1400083486.3010.21.camel@vaio-emefes-com>
In-Reply-To: <1400083486.3010.21.camel@vaio-emefes-com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2014 12:04 PM, Mladen Sekara wrote:
> What would be the best approach to attack this:
> 
> One application, multiple components/daemons.
> Some files are specific to a daemon, some are shared between them (eg.
> log files are unique, some config files, keystores... are shared etc.)
> 
> All daemons start from a single init script and I am not allowed to
> change it.
> 
> Options:
> 
> 1. Create policy for each component and then domain transition between
> them (what about shared files???)
> 2. Create a single policy for multiple daemons?
> 
> Any advice...

Given that there are some resources private to each daemon and the
daemons may have different permission requirements, I'd suggest creating
a separate domain per daemon and just defining a set of shared types for
the shared resources.  You can define them all in a single policy
module; there is no requirement that there only be a single domain in
each policy module.

If you then find that some of the domains are almost identical, you can
coalesce them.  But you likely won't know that a priori and it is easier
to coalesce domains/types than to split them.
