Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05934
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 12:53:37 -0400 (EDT)
Date: Tue, 1 Oct 2002 12:53:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200209300055.39193.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210011251050.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 30 Sep 2002, Russell Coker wrote:

> The archive newfiles.tar.gz of new policy files I've written which aren't yet
> in the CVS.
>
> The patch can_net.diff which removes duplicate calls to can_network().  This
> makes the resulting policy.conf smaller and makes it easier to grep.
>
> The patch mta.diff has some new changes related to mail servers.  Of
> particular note, I finally got qmail fully working in enforcing mode - and
> the policy has changed a lot.
>
> The netscape changes in netscape.diff rely on the new file x_client_macros.te,
> it is about splitting the X access part of it into a separate file so the
> same policy is also used by other programs that use X but which are not
> entirely trusted.
>
> The file diff contains other small patches, including some that are required
> for the netscape patch, and for the new xauth policy that is needed for a
> separate type for the ~/.Xauthority file.

Thanks, merged.  There were some rejects, but I think that they were just
duplicate diffs from earlier patches.  I also dropped capabilities from
netscape.  Do we need an entry for the .Xauthority files in types.fc?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
