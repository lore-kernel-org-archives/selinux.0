Subject: Re: limitations of CONTEXT__CONTAINS interface
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <4939CB81.1030707@tycho.nsa.gov>
References: <4939CB81.1030707@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 09:22:29 -0500
Message-Id: <1228746149.18446.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-12-05 at 19:46 -0500, Eamon Walsh wrote:
> The attached C code uses the CONTEXT__CONTAINS permission check to check
> dominance, and produces the following output on my mls box:
> 
> staff_u:staff_r:staff_t:s15:c0.c255 dominates staff_u:staff_r:staff_t:s0
> 
> system_u:object_r:etc_t:s15:c0.c255 does not dominate system_u:object_r:etc_t:s0
> 
> 
> Why doesn't this check work in the second case?

Likely due to a TE denial.  The existing policy likely only has:
allow domain self:context contains;
as the original use case for this check was to apply a check between two
subject contexts.

If you want to use it for object contexts, you'll have to allow it for
those types as well.

> My color translation code has a config file that may contain lines such
> as (paraphrasing):
> range s0 = green
> range s1 = yellow
> range s1:c1 = blue
> range s15:c0.c255 = red
> 
> and so forth, which are matched with incoming contexts using a dominance
> check.  The observed behavior above is causing this not to work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
