Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p73KIJfS005352
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:18:19 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p73KIIv1016725
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 20:18:18 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p73KIIdq005490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2011 16:18:18 -0400
Message-ID: <4E39AD08.2010205@redhat.com>
Date: Wed, 03 Aug 2011 16:18:16 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 153/155] Allow seunshare to run as root
References: <4E39AABA.8080209@redhat.com>
In-Reply-To: <4E39AABA.8080209@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/03/2011 04:08 PM, Daniel J Walsh wrote:
> 
> This patch looks good to me. acked.

Given how drastically different seunshare/sandbox is between upstream
and fedora I'm leary to backport something this late in the fedora
series right to upstream.  I'll add your ack, but don't plan to push it
until we get the rest of unshare to a point we think it is solid.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
