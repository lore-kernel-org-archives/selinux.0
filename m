Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6RKj4Ha013522
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 16:45:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6RKhsFB003686
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 20:43:55 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6RKhsGD003681
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 20:43:54 GMT
Subject: Re: experimental SEDebian 2.5 packages
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: tom@lemuria.org, Russell Coker <russell@coker.com.au>
In-Reply-To: <20030727170038.R542@lemuria.org>
References: <1058648176.681.14.camel@columbia>
	 <20030727170038.R542@lemuria.org>
Content-Type: multipart/mixed; boundary="=-1EhK1hTmkWpZOSY5sSHx"
Message-Id: <1059338576.13122.268.camel@columbia>
Mime-Version: 1.0
Date: 27 Jul 2003 16:42:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1EhK1hTmkWpZOSY5sSHx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-07-27 at 11:00, Tom wrote:
> On Sat, Jul 19, 2003 at 04:56:16PM -0400, Colin Walters wrote:
> > Before you install these; note that I doubt I am going to have time to
> > continuously keep up with all the rapid changes that happen in Debian
> > unstable.  This means you have to be very careful when upgrading to
> > ensure that a .selinux package isn't removed.  I recommend you put all
> > the .selinux packages on hold after you've installed them.
> 
> This, btw. is true for all of them. Well, at least for sid which is
> moving rapidly, but also for woody you can not GUARANTEE that a
> security fix doesn't replace the package.

Yeah.

> If you want me to set up a mirror for this like I did for Russel and
> Brian, just tell me how to best fetch them (rsync-over-ssh or
> something). I'd be happy to do it.

I have set up a regular rsync server, to copy the debs you can do e.g.:

rsync -av web.verbum.org::web/debian/experimental/ /path/to/mirror/

Of course, running rsyncd required writing a policy for it :)  That
should be attached.  I had to create a shell script /usr/sbin/rsyncd
which looks like:

#!/bin/sh -e
exec rsync --daemon

rsyncd.{te,fc} are in my arch tree too.


--=-1EhK1hTmkWpZOSY5sSHx
Content-Disposition: attachment; filename=rsyncd.te
Content-Type: text/plain; name=rsyncd.te; charset=UTF-8
Content-Transfer-Encoding: base64

I0RFU0MgcnN5bmNkIC0gcnN5bmMgZGFlbW9uDQojDQojIEF1dGhvcjogQ29saW4gV2FsdGVycyA8
d2FsdGVyc0B2ZXJidW0ub3JnPg0KDQp0eXBlIHJzeW5jZF9wb3J0X3QsIHBvcnRfdHlwZTsNCg0K
ZGFlbW9uX2RvbWFpbihyc3luY2QpDQoNCiMgQWxsb3cgdGhlIHN5c2FkbWluIHRvIGV4ZWMgdGhl
IHNlcnZlciBkaXJlY3RseS4gIEF0IGxlYXN0DQojIHJzeW5jZCBvbiBEZWJpYW4gZG9lcyBub3Qg
aGF2ZSBhbiBpbml0IHNjcmlwdC4NCnJvbGUgc3lzYWRtX3IgdHlwZXMgcnN5bmNkX3Q7DQpkb21h
aW5fYXV0b190cmFucyhzeXNhZG1fdCwgcnN5bmNkX2V4ZWNfdCwgcnN5bmNkX3QpDQoNCmJhc2Vf
ZmlsZV9yZWFkX2FjY2Vzcyhyc3luY2RfdCkNCnJfZGlyX2ZpbGUocnN5bmNkX3QsIHsgZXRjX3Qg
ZXRjX3J1bnRpbWVfdCByZXNvbHZfY29uZl90IH0pDQpkb250YXVkaXQgcnN5bmNkX3QgcHJvY190
OmZpbGUgcl9maWxlX3Blcm1zOw0KY2FuX25ldHdvcmsocnN5bmNkX3QpDQoNCiMgQWxsb3cgcnN5
bmNkIHRvIGJlIGEgc2hlbGwgc2NyaXB0IHdoaWNoIGV4ZWNzIC91c3IvYmluL3JzeW5jIC0tZGFl
bW9uDQpjYW5fZXhlYyhyc3luY2RfdCwgYmluX3QpDQoNCmFsbG93IHJzeW5jZF90IHJzeW5jZF9w
b3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7DQphbGxvdyByc3luY2RfdCBzZWxmOnsgdW5peF9z
dHJlYW1fc29ja2V0IHVuaXhfZGdyYW1fc29ja2V0IH0gY3JlYXRlX3NvY2tldF9wZXJtczsNCg0K
YWxsb3cgcnN5bmNkX3Qgc2VsZjpjYXBhYmlsaXR5IHsgc2V0dWlkIHNldGdpZCBuZXRfYmluZF9z
ZXJ2aWNlIH07DQoNCg0K

--=-1EhK1hTmkWpZOSY5sSHx
Content-Disposition: attachment; filename=rsyncd.fc
Content-Type: text/plain; name=rsyncd.fc; charset=UTF-8
Content-Transfer-Encoding: base64

IyByc3luY2QNCi91c3Ivc2Jpbi9yc3luY2QJCXN5c3RlbV91Om9iamVjdF9yOnJzeW5jZF9leGVj
X3QNCg==

--=-1EhK1hTmkWpZOSY5sSHx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
