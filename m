Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r7SA6GSU006590
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2013 06:06:16 -0400
Date: Wed, 28 Aug 2013 11:06:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
To: Colin Walters <walters@verbum.org>
Cc: SELinux List <selinux@tycho.nsa.gov>, dwalsh@redhat.com, eparis@redhat.com
Subject: Re: libselinux's __attribute__((constructor)) versus nVidia libGL.so
Message-ID: <20130828100612.GI15706@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1377625212.20072.4.camel@localhost>
 <1377625674.20072.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1377625674.20072.5.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 27, 2013 at 01:47:54PM -0400, Colin Walters wrote:
> This bug:
> 
> https://bugzilla.gnome.org/show_bug.cgi?id=706836

FWIW, you can define "priority" values on the constructor attributes, to
sort out ordering between libraries, but this sucks as a general purpose
solution as it requires co-ordination of priorities between different a
projects. eg you might fix the selinux vs nvidia problem now, but it can
recur with any other library using constructors in the future. IMHO it
would be better to use pthread_once to do any one time initialization
of library code

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
