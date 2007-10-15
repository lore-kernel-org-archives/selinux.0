MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: concept of a permissive domain
Date: Mon, 15 Oct 2007 13:26:29 -0400
Message-ID: <C3391B05.2F4B9%csellers@tresys.com>
In-Reply-To: <1192467177.28762.7.camel@blentz>
From: "Chad Sellers" <csellers@tresys.com>
To: "Brett Lentz" <blentz@cardomain.com>, "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stefan Schulze Frielinghaus" <stefan@seekline.net>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/15/07 12:52 PM, "Brett Lentz" <blentz@cardomain.com> wrote:

> On Mon, 2007-10-15 at 08:40 -0400, Daniel J Walsh wrote:
>>>> - From the user point of view we could change the setenforce command
>>>> 
>>>> setenforce 0
>>>> setenforce httpd_t 0
>>>> 
>>>> getenforce 0
>>>> getenforce httpd_t 0
>>>> 
>>>> Then we could replace both to do something in semanage to rebuild and
>>>> reload policy.
>>> 
>>> But that would mean e.g. consider apache that you would have to
>>> setenforce for every domain type?
>>> 
>>> apache_t
>>> apache_helper_t
>>> apache_php_t
>>> httpd_rotatelogs_t
>>> httpd_suexec_t
>>> ...
>>> 
>>> There wouldn't be a setenforce for a whole module, right?
>>> 
>>> Stefan
>>> 
>> Yes although it is doubtful you would have all of those running at the
>> same time.  (httpd_t and httpd_helper_t).
>> 
>> 
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.7 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>> 
>> iD8DBQFHE1/NrlYvE4MpobMRAuiiAKDgSEfnJHsFI9R1nmvvPx6PrhuQ9QCeIQHh
>> p4+2X7ixDbvoxSyMjrReLCE=
>> =6X1D
>> -----END PGP SIGNATURE-----
> 
> 
> As an SELinux user, it makes the most sense to me for this capability to
> be accessible on a per-module basis rather than per-domain.
> 
> I would much rather set the httpd module as a whole to permissive rather
> than fiddle around trying to A) set all of httpd's domains to permissive
> and B) requiring a fairly significant amount of knowledge of the
> security policy to know which domains may require this intervention.
> 
> I think that per-domain permissive is probably useful for certain kinds
> of policy development, but per-module permissive would be significantly
> more useful for the work that I'm currently doing with SELinux.
> 
I tend to agree with using module-level granularity, except I'm not sure how
we handle things in the base module. There are still a fair amount of source
modules compiled into the base module. I suppose we could just tell the user
to set permissive on "base" for certain domains, but that's fairly
unintuitive and messy.

Chad 

> _______________________________
> Brett Lentz | CarDomain Network
> System Administrator
> 
> blentz@cardomain.com | tel 206.926.2109 | cell 206.851.6669
> http://www.cardomain.com/id/wakko666
> 
> One organism, one vote.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
