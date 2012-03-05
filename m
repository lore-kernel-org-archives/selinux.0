Subject: Re: Performance optimization of libsepol and the need for detailed
 policydb docs.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <kyle@moffetthome.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAGZ=bqKEXNiRp_4YZaTvYEm6JhhAdk0LunwYbgWtuMKWPPAiiA@mail.gmail.com>
References: 
	 <CAGZ=bqKEXNiRp_4YZaTvYEm6JhhAdk0LunwYbgWtuMKWPPAiiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Mar 2012 14:53:01 -0500
Message-ID: <1330977181.7184.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 22:05 -0800, Kyle Moffett wrote:
> In the past (with my previous employer), I participated in some
> efforts to analyze the performance of libsepol and identified some
> low-hanging fruit in the form of incorrectly sized hash tables (EG: A
> hash table with 2 entries has equivalent performance to a linked list
> except with a lot of extra code on the front end), but we never were
> able to polish up patches for merging.
> 
> I would like to potentially take on some of this work, but I'd really
> need to have some better documentation on the various binary policy
> formats (base policy, modules, and linked policy).  Is there any
> existing documentation or should I just start by writing some?

Old, but possibly helpful as a starting point:
http://securityblog.org/brindle/2006/07/05/selinux-policy-module-primer/


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
