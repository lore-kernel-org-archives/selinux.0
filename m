Reply-To: <dac@tresys.com>
From: "David Caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>, <SeLinux@tycho.nsa.gov>
Subject: RE: 2 checkpolicy bugs
Date: Fri, 24 May 2002 10:23:30 -0400
Message-ID: <NJEELFKFDFJAACDDMCHCAEMFEAAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020524121244.237B6655@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think it's because of the way checkpolicy validates policy.conf.  If you
look at policy_parse.y (in .../selinux/module/checkpolicy/), a "policy" is
defined such that it must have "net_contexts".  If you follow that through
you find that there must be at least one of everything:

net_contexts : port_contexts netif_contexts node_contexts \
               opt_nfs_contexts

So to be a "valid configuration" a policy must define all these parts.

Regarding the error message, I think it's just typical of most
compiler/interpreter errors when you leave out a required piece of syntax.

I think the important issue is that in order to compile a "valid" policy you
may have to add things that you don't require.  In a sense this is allowing
unnecessary permissions, violating the principle of least privilege.

David

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Russell Coker
> Sent: Friday, May 24, 2002 7:09 AM
> To: SE Linux
> Subject: 2 checkpolicy bugs
>
>
> If I don't assign SIDs to any TCP or UDP ports then I get the following
> checkpolicy error:
>
> error in the statement ending on line 31779 (token 'system_u'):
> parse error
>
> Line 31779 is the following:
> lo system_u:object_r:netif_lo_t system_u:object_r:netmsg_lo_t
>
> I consider that there are two bugs in checkpolicy, firstly it
> doesn't accept
> a valid configuration with no special SIDs assigned to any TCP or
> UDP ports.
> Secondly it doesn't give me an error message that is any good to
> inform me of
> this matter.
>
> Currently to work around this matter I've assigned a type for
> port 1 (tcpmux)
> which is never used.
>
> --
> If you send email to me or to a mailing list that I use which has >4 lines
> of legalistic junk at the end then you are specifically
> authorizing me to do
> whatever I wish with the message and all other messages from your
> domain, by
> posting the message you agree that your long legalistic sig is void.
>
> --
> You have received this message because you are subscribed to the
> selinux list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
