Date: Thu, 21 Feb 2002 10:32:10 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Documentation! (Was: Re: activity?)
In-Reply-To: <20020220183947.B5148@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0202211023390.819-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Feb 2002, Tracy R Reed wrote:

> It is easier to set up than in the past. But what it REALLY needs to be
> useful to me is some good documentation aimed at the system administrator.
> I've read the papers on the site but I still just can't get it in my head
> how to do much with it. I would love to see some examples of how to alter
> policies, add new domains for new software, etc. I would like to see a
> good glossary of all of the terminology used also. LIDS was easy to figure
> out compared to SE Linux. I just know SE Linux is the better solution for
> me but I am having problems figuring out how to actually customize it to
> my system requirements!
>
> Please, someone, write some docs!

By the way, although we are working on a new policy report, you can find
an informal description of the policy language in the Policy Configuration
Language subsection of http://www.nsa.gov/selinux/slinux-abs.html, and you
can find a description of the original example policy configuration in
http://www.nsa.gov/selinux/policy-abs.html.  And, of course, there is the
paper from the 2001 OLS.

A number of SELinux users have developed and posted revisions to the
example policy, including the addition of permissions to existing domains
and the creation of new domains, so you can certainly look to their
examples from the mailing list archives.

Feel free to ask specific questions about configuring the policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
