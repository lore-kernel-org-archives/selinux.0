Date: Fri, 23 Aug 2002 10:52:06 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: new file contexts
In-Reply-To: <1030114035.16278.31.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208231048300.20183-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 23 Aug 2002, Timothy Wood wrote:

> (gnome doesn't so I don't see why ROX would).  So should I just append
> these changes to the types.fc since that is where the generic /usr/bin
> type is located or would it be better to leave them in the already
> seperate rox.fc and change the Makefile?
>
> here are my changes:
>
> # ROX
> /usr/apps/ROX-Filer/Linux-ix86/ROX-Filer		system_u:object_r:bin_t
> /usr/apps/ROX-Session/Linux-ix86/ROX-Session		system_u:object_r:bin_t
> /usr/apps/(.*)/AppRun		system_u:object_r:bin_t

To date, we've only created a program .fc file when there is a
corresponding program domain and have used types.fc to assign general
types (like bin_t) to other files.  Hence, I think I would just append
these entries to types.fc.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
