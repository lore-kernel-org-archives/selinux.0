Date: Fri, 12 Apr 2002 14:12:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Howard Holm <hdholm@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
        Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: RE: db conflict ?
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152433E@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0204121410220.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Westerman, Mark wrote:

> The ...security/policy directory would have a type of policy_conf_t and
> the program the would install a new policy would only need to have read
> permissions on file_label_t. This directory would only exist on the root
> file system and not on the other filesystems. This would keep to a minimum
> differences in the FHS (v2.2).

I'd prefer to not mix the persistent label mapping directory with the
compiled policy, even if using a separate subdirectory.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
