Date: Fri, 12 Apr 2002 13:29:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: Howard Holm <hdholm@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
        Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
Subject: RE: db conflict ?
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152433C@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0204121328140.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Westerman, Mark wrote:

> Since you must create ...security why on the top
> of every file system why not put it in there ?

The per-filesystem ...security directories are for the persistent label
mappings.  They also have a different type, and should be distinguished
from the compiled policy configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
