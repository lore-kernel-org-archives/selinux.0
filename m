Subject: Re: SE Android on Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
In-Reply-To: <CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
References: 
	 <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	 <1330702776.2616.43.camel@moss-pluto>
	 <CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	 <CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
	 <1330719989.2616.100.camel@moss-pluto>
	 <CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Mar 2012 14:01:46 -0500
Message-ID: <1331060506.26027.99.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 16:16 -0600, Bryan Hinton wrote: 
> I agree. A per-device file_contexts file makes sense given the
> variation in radio types between ICS based devices.

Support for per-device .te and .fc files has been added to the sepolicy
Android.mk file.  Thus, you can place your device-specific additions for
file_contexts in a sepolicy.fc file or for policy rules in a sepolicy.te
file under target/board/<device>, device/<vendor>/<device>, or
vendor/<vendor>/<device> and have it automatically included into the
policy.

Since the device-specific .fc files are appended to the end of
file_contexts, they will take precedence over less specific entries in
the base file_contexts file (e.g. no need to change the /dev/tty[0-9]
entry in file_contexts in order to override the context for /dev/tty03;
you can just add the latter to your .fc file and it should take
precedence).  The device-specific .te files are likewise appended after
the base set of .te files, although order there shouldn't matter.

This is still experimental and may change further.  For example, if we
wanted to support multiple .fc or .te files per device, we might
introduce an optional sepolicy subdirectory under the device directories
that could contain any number of such files.

These changes are available in our sepolicy tree, but not yet in the
AOSP one.  In order to ensure that you use our sepolicy tree, you may
need to update your local_manifest.xml file.  I have placed updated
local_manifest.xml (for git-based access) and local_manifest_http.xml
(for http-based access) files under
http://selinuxproject.org/~seandroid/

-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
