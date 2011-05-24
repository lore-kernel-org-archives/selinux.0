Message-ID: <4DDBA986.4000207@redhat.com>
Date: Tue, 24 May 2011 08:50:14 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: rongqing.li@windriver.com
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 0/2] Review request for reorganizing the role transition
 rule
References: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1306230374-29019-1-git-send-email-rongqing.li@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/24/2011 05:46 AM, rongqing.li@windriver.com wrote:
> Comments:
> ---------
> Organize the roletr in hash table rather than single list.

Why?  I'm not opposed to the change, but it is added complexity.  How
many such rules exist?  How often are they searched?  What was that
underlying problem for the patch?

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
