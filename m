Date: Tue, 22 Jan 2002 16:35:59 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: avc deny messages.
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242AA@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0201221625320.20295-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 22 Jan 2002, Westerman, Mark wrote:

> I am not getting all my deny messages in development mode.
> I get a permission denied in enforcing mode, but
> where I change to permisive I do not get a permission denied.
> No messages show up either way.

The AVC rate limit should only be applied when in enforcing mode.  If you
built your kernel with the development mode option and are in permissive
mode, then every AVC denial should be audited.  Try again, this time
checking the output of 'dmesg' as well as your /var/log/messages file.
Make sure that you are in permissive mode with 'avc_enforcing'.
Check both for avc messages and for security_compute_sid messages.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
