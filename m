Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA23137
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 06:36:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PBa0I02911
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 11:36:00 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h1PBa0f02907 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 11:36:00 GMT
Date: Tue, 25 Feb 2003 06:35:55 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Frank Mayer <mayerf@tresys.com>
cc: "'Russell Coker'" <russell@coker.com.au>,
        "'Clem Skorupka'" <ragnor@mitre.org>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: Core policy
In-Reply-To: <004101c2dc4b$e93fddd0$6600a8c0@columbia.tresys.com>
Message-ID: <Pine.LNX.4.33.0302250628140.1479-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003, Frank Mayer wrote:

> Category names are a good idea (e.g., #CATEGORY <category name> ).  I
> can see all sorts of ways to use that in configuration tools.
>
> I'd like to suggest that the third list be #DEPENDS <list of .te file
> upon which this module depends> so we can also manage dependencies with
> configuration tools.
>

  I was thinking of something similar: a set of tags that can be used by
tools. Here's some I came up with:
#TITLE - The title, 30 characters or less (replaces the #DESC tag)
#DESCRIPTION (or #DESC) - Description, not limited in length

I also thought of a #DEPENDS tag, but I'm not sure how well it would be
maintained by the policy writers. What would be nice is to have some way
of annotating policy file relationships in a modular way; possibly an
#IMPORTS tag that means something to the compiler. If a policy file uses a
type defined in another file, unless that file is imported, it's an error.
The goal is to have more control over the relationships between policy
components.


 --
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
